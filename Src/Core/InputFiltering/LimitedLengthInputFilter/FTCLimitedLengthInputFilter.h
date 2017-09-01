//
// Created by Kirill Zuev on 07/10/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

@import Foundation;

#import "FTCTextEntryEditingInputFilter.h"
#import "FTCTextEntryNotEditingInputFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTCLimitedLengthInputFilter : NSObject<FTCTextEntryEditingInputFilter, FTCTextEntryNotEditingInputFilter>

- (instancetype)initWithMaximumLength:(NSUInteger)maximumLength NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
