//
// Created by Denis Morozov on 25/08/2017.
// Copyright (c) 2017 FTC. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@class FTCTextEntryFormattingConfig;

@interface FTCTextEntryFormattingConfigFactory : NSObject

+ (FTCTextEntryFormattingConfig *)mobilePhoneConfigWithMask:(NSString *)mask
                                                   maskChar:(NSString *)maskChar NS_SWIFT_NAME( mobilePhoneConfig(with:maskChar:) );

+ (FTCTextEntryFormattingConfig *)moneyConfigWithCurrency:(nullable NSString *)currency
                                             onlyIntegral:(BOOL)onlyIntegral NS_SWIFT_NAME( moneyConfig(with:onlyIntegral:) );

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
