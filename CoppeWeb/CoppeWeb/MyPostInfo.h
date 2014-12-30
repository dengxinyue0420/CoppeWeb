//
//  MyPostInfo.h
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/29/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyPostInfo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * date;

@end
