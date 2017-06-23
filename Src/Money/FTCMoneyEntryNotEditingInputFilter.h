//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "FTCTextEntryNotEditingInputFilter.h"


@class MoneyType;

NS_ASSUME_NONNULL_BEGIN

@interface FTCMoneyEntryNotEditingInputFilter : NSObject<FTCTextEntryNotEditingInputFilter>

@property (nonatomic, strong) MoneyType *maxMoneyAmount;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
