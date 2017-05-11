//
// Created by Дирша Андрей Александрович on 26.07.16.
// Copyright (c) 2016 FTC. All rights reserved.
//


@class FTCTextEntryFormattingConfig;


NS_ASSUME_NONNULL_BEGIN

@protocol FTCTextEntryUI<NSObject>

@property (nonatomic, strong, nullable) NSString *text;

@property (nonatomic, assign) NSRange selectedTextRange;

- (void)addDelegate:(id<UITextFieldDelegate>)delegate;
- (void)removeDelegate:(id<UITextFieldDelegate>)delegate;

@end


@interface CaneTextEntryFormatCoordinatorHelper : NSObject

@property (nonatomic, nullable, copy) void (^didChangeValueHandler)();

@property (nonatomic, nullable, copy) NSString *rawValue;

@property (nonatomic, nullable, readonly) NSString *formattedValue;

- (instancetype)initWithUI:(id<FTCTextEntryUI>)textEntryUI;

- (void)applyFormattingConfig:(FTCTextEntryFormattingConfig *)config;

@end

NS_ASSUME_NONNULL_END
