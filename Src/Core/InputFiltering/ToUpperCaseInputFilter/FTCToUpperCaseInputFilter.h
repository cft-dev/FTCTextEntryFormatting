//
// Created by Sechko Artem Sergeevich on 09/06/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

#import "FTCTextEntryEditingInputFilter.h"
#import "FTCTextEntryNotEditingInputFilter.h"

@interface FTCToUpperCaseInputFilter : NSObject<FTCTextEntryEditingInputFilter, FTCTextEntryNotEditingInputFilter>

- (instancetype)init;

@end
