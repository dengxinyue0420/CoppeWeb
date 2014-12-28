//
//  AppDelegate.h
//  CoppeWeb
//
//  Created by Yicheng Wang on 12/22/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SocketHandler.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,NSStreamDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong,nonatomic) SocketHandler *sh;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end


