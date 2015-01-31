//
//  GMDTrackingService.h
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kAllowTracking = @"allowTracking";
static NSString *const kTrackingId = @"UA-2793234-9";

@interface GMDTrackingService : NSObject

+ (GMDTrackingService *)sharedInstance;

- (void)trackEvent:(NSString *)event withValue:(NSNumber *)value fromSender:(NSString *)sender;

- (void)trackScreen:(NSString *)screen;

@end
