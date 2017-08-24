//
// Created by Yuriy Muzyukin on 4/28/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

#import "FTCTextEntryEditingInputFilter.h"
#import "FTCTextEntryNotEditingInputFilter.h"

@interface FTCNoFilteringFilter : NSObject<FTCTextEntryEditingInputFilter, FTCTextEntryNotEditingInputFilter>

- (instancetype)init;

@end
