//
//  PostInfo.h
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/31/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PostInfo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * createDate;

@end
