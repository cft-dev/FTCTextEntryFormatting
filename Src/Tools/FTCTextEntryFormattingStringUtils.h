//
// Created by Andrey Sikerin on 11/14/13.
// Copyright (c) 2013 FTC. All rights reserved.

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface FTCTextEntryFormattingStringUtils : NSObject

+ (NSString *)removeCharactersOfSet:(NSCharacterSet *)characterSet fromString:(NSString *)string;
+ (nullable NSString *)stringWithDecimalDigitsFromString:(nullable NSString *)string;

+ (NSString *)stringWithCharacter:(unichar)character;

@end

NS_ASSUME_NONNULL_END
