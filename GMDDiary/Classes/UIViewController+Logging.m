//
//  UIViewController+Logging.m
//  GMDDiary
//
//  Created by Rockstar. on 1/31/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+Logging.h"

@implementation UIViewController (Logging)

+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        Class class = [self class];
        SEL viewWillAppearSelector = @selector(viewDidAppear:);
        SEL viewWillAppearLoggerSelector = @selector(logged_viewDidAppear:);
        Method originalMethod = class_getInstanceMethod(self, viewWillAppearSelector);
        Method extendedMethod = class_getInstanceMethod(self, viewWillAppearLoggerSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        viewWillAppearSelector,
                        method_getImplementation(extendedMethod),
                        method_getTypeEncoding(extendedMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                viewWillAppearLoggerSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, extendedMethod);
        }
        
    });
}

- (void) logged_viewDidAppear:(BOOL)animated {
    [self logged_viewDidAppear:animated];
    NSLog(@"logged view did appear for %@", [self class]);
    [[GMDTagService sharedInstance] pushOpenWithScreen:[NSString stringWithFormat:@"%@", [self class]]];
    [[GMDTagService sharedInstance] pushValue:[NSString stringWithFormat:@"%@", [self class]] withKey:@"screenName"];
}

@end
