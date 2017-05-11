//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "FTCTextEntryNotEditingInputFilter.h"


@class MoneyType;


@interface CaneMoneyEntryNotEditingInputFilter : NSObject<FTCTextEntryNotEditingInputFilter>

@property (nonatomic, strong) MoneyType *maxMoneyAmount;

- (instancetype)init;

@end