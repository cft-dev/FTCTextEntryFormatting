//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "FTCTextEntryEditingInputFilter.h"


@class MoneyType;

NS_ASSUME_NONNULL_BEGIN

@interface CaneMoneyEntryEditingInputFilter : NSObject<FTCTextEntryEditingInputFilter>

@property (nonatomic, strong) MoneyType *maxMoneyAmount;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
