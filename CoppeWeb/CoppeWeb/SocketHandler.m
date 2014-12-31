//
//  socketHandler.m
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/27/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "socketHandler.h"
#import "SignUpViewController.h"
#import "PostInfo.h"

NSInputStream *inputstream;
NSOutputStream *outputstream;

@implementation SocketHandler


-(void)initNetworkConnection{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 8124, &readStream, &writeStream);
    inputstream = (__bridge NSInputStream *)readStream;
    outputstream = (__bridge NSOutputStream *)writeStream;
    [inputstream setDelegate:self];
    [outputstream setDelegate:self];
    [inputstream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputstream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputstream open];
    [outputstream open];
}


- (void) stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable:
            if(aStream==inputstream){
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSMutableData *buffer = [[NSMutableData alloc] init];
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
                    uint8_t buf[1024];
                    int length;
                    while ([inputstream hasBytesAvailable]){
                        length = [inputstream read:buf maxLength:1024];
                        if (length>0){
                            [buffer appendBytes:buf length:length];
                        }
                    }
                    NSString *output = [[NSString alloc] initWithData:buffer encoding:NSASCIIStringEncoding];
                    NSData *data = [output dataUsingEncoding:NSASCIIStringEncoding];
                    id jsonBack = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSString *backMsg = [jsonBack objectForKey:@"BackMsg"];
                    if([backMsg isEqualToString:@"SignUpRes"]){
                        NSString *result = [jsonBack objectForKey:@"Result"];
                        if ([result isEqualToString:@"true"])
                            [self postNotification:@"signUp_success"];
                        else
                            [self postNotification:@"signUp_existed"];
                    }else if ([backMsg isEqualToString:@"LogInRes"]){
                        NSString *result = [jsonBack objectForKey:@"Result"];
                        if ([result isEqualToString:@"true"])
                            [self postNotification:@"login_success"];
                        else
                            [self postNotification:@"login_fail"];
                    }else if ([backMsg isEqualToString:@"Post"]){
                        NSLog(@"received post");
                        NSDictionary *backPost = [jsonBack objectForKey:@"BackPosts"];
                        NSNumber *count = [backPost objectForKey:@"Count"];
                        if (count==0){
                            NSLog(@"count is zero");
                            [self postNotification:@"no_more_post"];
                        }
                        else{
                            NSArray *postsArray = [backPost objectForKey:@"Items"];
                            for (NSDictionary *post in postsArray){
                                PostInfo *postInfo = [NSEntityDescription insertNewObjectForEntityForName:@"PostInfo" inManagedObjectContext:self.managedObjectContext];
                                postInfo.id = [numberFormatter numberFromString:[[post objectForKey:@"PostID"] objectForKey:@"N"]];
                                postInfo.name = [[post objectForKey:@"PostName"] objectForKey:@"S"];
                                postInfo.content = [[post objectForKey:@"Content"] objectForKey:@"S"];
                                postInfo.createDate = [dateFormatter dateFromString:[[post objectForKey:@"CreateDate"] objectForKey:@"S"]];
                                NSError *error;
                                if (![self.managedObjectContext save:&error]) {
                                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                                }
                                NSLog(@"save");
                            }
                            [self postNotification:@"fetch_data_completed"];
                        }
                    }
                });
            }
            break;
        default:
            break;
    }
}

-(void) postNotification:(NSString*) notification{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:self];
    }];
}
@end
