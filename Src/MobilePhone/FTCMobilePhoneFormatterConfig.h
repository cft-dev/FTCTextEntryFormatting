//
// Created by Denis Morozov on 08/05/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

@import Foundation;

#import "FTCMaskFormatterConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTCMobilePhoneFormatterConfig : NSObject<FTCMaskFormatterConfig>

@property (nonatomic, readwrite) unichar maskCharacter; // default '_'

- (instancetype)initWithFormat:(NSString *)format NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
