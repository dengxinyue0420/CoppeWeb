//
//  socketHandler.m
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/27/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import "socketHandler.h"
#import "SignUpViewController.h"

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
                    uint8_t buffer[1024];
                    int len;
                    while ([inputstream hasBytesAvailable]){
                        len = [inputstream read:buffer maxLength:sizeof(buffer)];
                        if (len>0){
                            NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                            NSData *data = [output dataUsingEncoding:NSASCIIStringEncoding];
                            id jsonBack = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            NSString *backMsg = [jsonBack objectForKey:@"BackMsg"];
                            NSString *result = [jsonBack objectForKey:@"Result"];
                            if([backMsg isEqualToString:@"SignUpRes"]){
                                if ([result isEqualToString:@"true"]) {
                                    [self postNotification:@"signUp_success"];
                                }else{
                                    [self postNotification:@"signUp_existed"];
                                }
                            }else if ([backMsg isEqualToString:@"LogInRes"]){
                                if ([result isEqualToString:@"true"]){
                                    [self postNotification:@"login_success"];
                                }else{
                                    [self postNotification:@"login_fail"];
                                }
                            }
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
