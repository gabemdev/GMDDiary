//
//  UIColor+GMDKitAdditions.m
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "UIColor+GMDKitAdditions.h"
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (GMDKitPrivateAdditions)
- (NSUInteger)_hexValue;
@end

@implementation NSString (GMDKitPrivateAdditions)

- (NSUInteger)_hexValue {
    NSUInteger result = 0;
    sscanf([self UTF8String], "%lx",(unsigned long *)&result);
    return result;
}

@end

@implementation UIColor (GMDKitAdditions)

//---------------
// ColorWithHex
//--------------
+ (UIColor *)GMDKitColorWithHex:(NSString *)hex {
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    } else if ([hex hasPrefix:@"0x"]) {
        hex = [hex substringFromIndex:2];
    }
    
    NSUInteger length = [hex length];
    if (length != 3 && length != 6 && length != 8) {
        return nil;
    }
    
    if (length == 3) {
        NSString *r = [hex substringWithRange:NSMakeRange(0, 1)];
        NSString *g = [hex substringWithRange:NSMakeRange(1, 1)];
        NSString *b = [hex substringWithRange:NSMakeRange(2, 1)];
        hex = [NSString stringWithFormat:@"%@%@%@%@%@%@ff",
               r, r, g, g, b, b];
    } else if (length == 6) {
        hex = [hex stringByAppendingString:@"ff"];
    }
    
    CGFloat red = [[hex substringWithRange:NSMakeRange(0, 2)] _hexValue] / 255.0f;
    CGFloat green = [[hex substringWithRange:NSMakeRange(2, 2)] _hexValue] / 255.0f;
    CGFloat blue = [[hex substringWithRange:NSMakeRange(4, 2)] _hexValue] / 255.0f;
    CGFloat alpha = [[hex substringWithRange:NSMakeRange(6, 2)] _hexValue] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}



@end
