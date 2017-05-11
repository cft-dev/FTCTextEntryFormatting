//
// Created by Sechko Artem Sergeevich on 05/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


@class FTCTextEntryFormattingConfig;


@interface FTCTextEntryFormatCoordinator : NSObject

@property (nonatomic, strong) NSString *rawValue;
@property (nonatomic, readonly) NSString *formattedValue;

@property (nonatomic, assign) NSRange currentSelectionRangeInFormattedValue;

- (instancetype)init;

- (void)userReplacedInFormattedValueSubstringAtRange:(NSRange)range withString:(NSString *)replacement;

- (void)beginEditing;
- (void)endEditing;

- (BOOL)isEditing;

- (void)applyConfig:(FTCTextEntryFormattingConfig *)config;

@end
