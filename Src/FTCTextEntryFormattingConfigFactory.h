//
// Created by Denis Morozov on 25/08/2017.
// Copyright (c) 2017 FTC. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@class FTCTextEntryFormattingConfig;

@interface FTCTextEntryFormattingConfigFactory : NSObject

+ (FTCTextEntryFormattingConfig *)mobilePhoneConfigWithFormat:(NSString *)format
                                                     maskChar:(unichar)maskChar
                                               maskCharsCount:(NSUInteger)maskCharsCount;

+ (FTCTextEntryFormattingConfig *)moneyConfigWithCurrency:(nullable NSString *)currency onlyIntegral:(BOOL)onlyIntegral;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
