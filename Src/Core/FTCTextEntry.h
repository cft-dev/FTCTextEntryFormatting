//
// Created by Denis Morozov on 23/06/2017.
// Copyright (c) 2017 FTC. All rights reserved.
//

@import Foundation;

@protocol FTCTextEntry;

NS_ASSUME_NONNULL_BEGIN

@protocol FTCTextEntry<NSObject>

@property (nonatomic, strong, nullable) NSString *text;

@property (nonatomic, assign) NSRange selectedTextRange;

@end

NS_ASSUME_NONNULL_END
