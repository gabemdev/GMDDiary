//
//  GMDTrackingService.m
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GMDTrackingService.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"


@interface GMDTrackingService ()
@property (nonatomic) id <GAITracker> gaTracker;
@end

@implementation GMDTrackingService

- (instancetype)init {
    if ((self = [super init])) {
        [GAI sharedInstance].optOut = ![[NSUserDefaults standardUserDefaults] boolForKey:kAllowTracking];
        [GAI sharedInstance].trackUncaughtExceptions = YES;
        [GAI sharedInstance].dispatchInterval = 10;
        [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
        _gaTracker = [[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
    }
    return self;
}

- (void)trackEvent:(NSString *)event withValue:(NSNumber *)value fromSender:(NSString *)sender {
    NSMutableDictionary *e = [[GAIDictionaryBuilder createEventWithCategory:@"GMDDiary" action:event label:sender value:value] build];
    [[GAI sharedInstance].defaultTracker send:e];
    [[GAI sharedInstance] dispatch];
}

- (void)trackScreen:(NSString *)screen{
    GAITrackedViewController *trackedController = [[GAITrackedViewController alloc] init];
    trackedController.screenName = screen;
}

+ (GMDTrackingService *)sharedInstance {
    static GMDTrackingService *instance = nil;
    if (!instance) {
        instance = [[GMDTrackingService alloc] init];
    }
    return instance;
}

@end
