//
//  socketHandler.h
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/27/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignUpViewController.h"

extern NSInputStream *inputstream;
extern NSOutputStream *outputstream;

@interface SocketHandler : NSObject <NSStreamDelegate>

-(void) initNetworkConnection;
-(void) postNotification:(NSString*) notification;
@end
