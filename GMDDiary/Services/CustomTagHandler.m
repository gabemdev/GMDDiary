//
//  CustomTagHandler.m
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "CustomTagHandler.h"


@implementation CustomTagHandler

- (void)execute:(NSString *)tagName parameters:(NSDictionary *)parameters {
    NSLog(@"Custom function call tag: %@ is fired", tagName);
}

@end
