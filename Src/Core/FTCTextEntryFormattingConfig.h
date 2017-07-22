//
// Created by Yuriy Muzyukin on 3/24/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

@import Foundation;

@protocol FTCTextEntryFormatter;
@protocol FTCTextEntryEditingInputFilter;
@protocol FTCTextEntryNotEditingInputFilter;

NS_ASSUME_NONNULL_BEGIN

@interface FTCTextEntryFormattingConfig : NSObject

@property (nonatomic, strong) id<FTCTextEntryFormatter> editingFormatter;
@property (nonatomic, strong) id<FTCTextEntryEditingInputFilter> editingInputFilter;

@property (nonatomic, strong) id<FTCTextEntryFormatter> notEditingFormatter;
@property (nonatomic, strong) id<FTCTextEntryNotEditingInputFilter> notEditingInputFilter;

- (BOOL)isEqualToConfig:(FTCTextEntryFormattingConfig *)config;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
