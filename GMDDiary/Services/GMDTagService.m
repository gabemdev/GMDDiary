//
//  GMDTagService.m
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GMDTagService.h"
#import "TAGManager.h"
#import "TAGLogger.h"
#import "TAGContainer.h"
#import "TAGContainerOpener.h"
#import "TAGDataLayer.h"
#import "AppDelegate.h"


@interface GMDTagService () <TAGContainerOpenerNotifier>

// Used for sending traffic in the background.



@end

@implementation GMDTagService

- (instancetype)init {
    if ((self = [super init])) {
        _manager = [TAGManager instance];
        [_manager.logger setLogLevel:kTAGLoggerLogLevelVerbose];
        
        [TAGContainerOpener openContainerWithId:kContainerId
                                     tagManager:_manager
                                       openType:kTAGOpenTypePreferNonDefault
                                        timeout:nil
                                       notifier:self];
        
        
    }
    return self;
}

- (void)containerAvailable:(TAGContainer *)container {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.container = container;
        [self.container registerFunctionCallMacroHandler:[[CustomMacroHandler alloc] init] forMacro:@"increment"];
        [self.container registerFunctionCallMacroHandler:[[CustomMacroHandler alloc] init] forMacro:@"mod"];
        
        [self.container registerFunctionCallTagHandler:[[CustomTagHandler alloc] init] forTag:@"custom_tag"];
    });
}

+ (GMDTagService *)sharedInstance {
    static GMDTagService *instance = nil;
    if (!instance) {
        instance = [[GMDTagService alloc] init];
    }
    return instance;
}

- (void)pushOpenWithScreen:(NSString *)screen {
    [_manager.dataLayer push:@{@"event": @"openScreen",
                               @"screen" : screen}];
}

- (void)pushCloseWithScreen:(NSString *)screen {
    [_manager.dataLayer push:@{@"event" : @"closeScreen",
                               @"screen" : screen}];
}

- (void)pushValue:(NSString *)value withKey:(NSString *)key {
    [_manager.dataLayer pushValue:value forKey:key];
    
}

- (void)pushNewEntry:(NSString *)value {
    [_manager.dataLayer pushValue:value forKey:@"newEntry"];
}

- (void)trackEntry:(NSString *)entry fromSender:(NSString *)sender {
    [_manager.dataLayer push:@{@"event" : @"newEntry",
                               @"entryName" : entry,
                               @"screenName": sender}];
}



@end
