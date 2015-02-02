//
//  ViewController.m
//  NetWordDemo
//
//  Created by Yicheng Wang on 1/17/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UIButton *send;



@end

NSInputStream *inputstream;

NSOutputStream *outputstream;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageview = [[UIImageView alloc]init];
    self.imageview.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width/2-100, [[UIScreen mainScreen]bounds].size.height/2-100, 200, 200);
    [self.view addSubview:self.imageview];
    [self.button addTarget:self action:@selector(buttontapped) forControlEvents:UIControlEventTouchUpInside];
    [self.send addTarget:self action:@selector(sendmsg) forControlEvents:UIControlEventTouchUpInside];
    [self initNetworkConnection];
}



-(void)initNetworkConnection{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 8125, &readStream, &writeStream);
    inputstream = (__bridge NSInputStream *)readStream;
    outputstream = (__bridge NSOutputStream *)writeStream;
    inputstream.delegate = self;
    outputstream.delegate = self;
    [inputstream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputstream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputstream open];
    [outputstream open];
}

-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable:
            if(aStream == inputstream){
                NSLog(@"has bytes reached");
                NSMutableData *buffer = [[NSMutableData alloc] init];
                uint8_t buf[1024];
                int length;
                while ([inputstream hasBytesAvailable]){
                    length = [inputstream read:buf maxLength:1024];
                    if (length>0){
                        [buffer appendBytes:buf length:length];
                    }
                }
                UIImage *image = [UIImage imageWithData:buffer];
                self.imageview.image = image;
                NSLog(@"image set");
            }
            
            
            break;
            
        default:
            break;
    }
}

- (void)sendmsg{
    for (int n = 0; n<1; n++){
        UIImage *image = [UIImage imageNamed:@"dsa.png"];
        NSData *imagedata = UIImagePNGRepresentation(image);
        NSString *string = [NSString stringWithFormat:@"{\"heyhey\":\"%@\"};",imagedata];
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSUInteger length = [data length];
        NSLog(@"%lu",[data length]);
        NSUInteger chunkSize = 1024;
        NSUInteger offset = 0;
        do {
            NSUInteger thisChunkSize = length - offset > chunkSize ? chunkSize : length - offset;
            NSData* chunk = [NSData dataWithBytesNoCopy:(char *)[data bytes] + offset
                                                 length:thisChunkSize
                                           freeWhenDone:NO];
            offset += thisChunkSize;
            [outputstream write:[chunk bytes] maxLength:[chunk length]];
        } while (offset < length);
    }
}

- (void)buttontapped{
    NSString *str = @"back";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [outputstream write:[data bytes] maxLength:[data length]];
}


@end
