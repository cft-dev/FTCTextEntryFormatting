//
// Created by Дирша Андрей Александрович on 26.07.16.
// Copyright (c) 2016 FTC. All rights reserved.
//

@import Foundation;

@class FTCTextEntryFormattingConfig;
@protocol FTCTextEntry;

NS_ASSUME_NONNULL_BEGIN

@interface FTCTextEntryFormatCoordinatorHelper : NSObject

@property (nonatomic, nullable, copy) void (^didChangeValueHandler)();

@property (nonatomic, nullable, copy) NSString *rawValue;

@property (nonatomic, nullable, readonly) NSString *formattedValue;

- (instancetype)initWithUI:(id<FTCTextEntry>)textEntryUI;

- (void)beginEditing;
- (void)changeCharactersInRange:(NSRange)range replacement:(NSString *)replacement;
- (void)endEditing;

- (void)applyFormattingConfig:(FTCTextEntryFormattingConfig *)config NS_SWIFT_NAME( apply(formattingConfig:) );

@end

NS_ASSUME_NONNULL_END
