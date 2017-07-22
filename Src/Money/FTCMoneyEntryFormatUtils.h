//
// Created by Sechko Artem Sergeevich on 30/07/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

@import Foundation;

@interface FTCMoneyEntryFormatUtils : NSObject

+ (NSString *)trimZeroHeadFromString:(NSString *const)string;
+ (NSString *)removeNonMoneyEntryCharactersFromString:(NSString *const)string;
+ (NSString *)removeFractionalPartFromString:(NSString *)string;
+ (NSString *)removeIntegralPartFromString:(NSString *)string;

+ (NSString *)emptyString;
+ (NSString *)zeroString;

+ (NSCharacterSet *)decimalSeparatorsCharacterSet;
+ (NSString *)preferredDecimalSeparator;

- (instancetype)init NS_UNAVAILABLE;

@end
