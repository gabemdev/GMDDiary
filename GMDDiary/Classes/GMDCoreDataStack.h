//
//  GMDCoreDataStack.h
//  GMDDiary
//
//  Created by Rockstar. on 1/31/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMDCoreDataStack : NSObject

+ (instancetype)defaultStack;

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentDirectory;

@end
