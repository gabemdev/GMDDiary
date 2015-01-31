//
//  CustomMacroHandler.h
//  GMDDiary
//
//  Created by Rockstar. on 1/30/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "TAGContainer.h"

@interface CustomMacroHandler : NSObject <TAGFunctionCallMacroHandler>

@property (nonatomic) NSUInteger numOfCalls;

@end
