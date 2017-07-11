//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCTextEntryFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTCMoneyEntryEditingFormatter : NSObject<FTCTextEntryFormatter>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCurrency:(nullable NSString *)aCurrency;

@end

NS_ASSUME_NONNULL_END