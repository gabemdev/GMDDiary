//
//  CustomMacroHandler.m
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "CustomMacroHandler.h"

@implementation CustomMacroHandler

- (id)valueForMacro:(NSString *)macroName parameters:(NSDictionary *)parameters {
    if ([macroName isEqual:@"increment"]) {
        self.numOfCalls++;
        return [NSString stringWithFormat:@"%lu", (unsigned long)self.numOfCalls];
    } else if ([macroName isEqual:@"mod"]) {
        NSString *value1 = parameters[@"key1"];
        NSString *value2 = parameters[@"key2"];
        return [NSNumber numberWithInt:([value1 intValue] % [value2 intValue])];
    } else {
        NSString *message = [NSString stringWithFormat:@"Custom macro name: %@ is not supported", macroName];
        @throw [NSException exceptionWithName:@"IllegalArgumentException"
                                       reason:message
                                     userInfo:nil];
    }
}

@end
