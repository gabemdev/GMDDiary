//
//  GMDTagService.h
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TAGManager;
@class TAGContainer;

//Update Container ID
static NSString *const kContainerId = @"GTM-W9JN7S";

@interface GMDTagService : NSObject

+ (GMDTagService *)sharedInstance;

@property (nonatomic, retain) TAGManager *manager;
@property (nonatomic, retain) TAGContainer *container;

- (void)pushOpenWithScreen:(NSString *)screen;
- (void)pushCloseWithScreen:(NSString *)screen;
- (void)pushValue:(NSString *)value withKey:(NSString *)key;



@end
