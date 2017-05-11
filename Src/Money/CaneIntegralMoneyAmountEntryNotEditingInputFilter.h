//
// Created by Sechko Artem Sergeevich on 29/07/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "FTCTextEntryNotEditingInputFilter.h"


@class MoneyType;


@interface CaneIntegralMoneyAmountEntryNotEditingInputFilter : NSObject<FTCTextEntryNotEditingInputFilter>

@property (nonatomic, strong) MoneyType *maxMoneyAmount;

- (instancetype)init;

@end