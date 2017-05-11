//
// Created by Lukovnikova Ekaterina on 10/8/15.
// Copyright (c) 2015 CFT. All rights reserved.
//


#import "FTCTextEntryFormatter.h"


@protocol FTCMaskFormatterConfig;


@interface FTCMaskFormatter : NSObject<FTCTextEntryFormatter>

- (instancetype)initWithConfig:(id<FTCMaskFormatterConfig>)config NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end