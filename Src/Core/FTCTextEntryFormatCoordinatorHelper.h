//
// Created by Дирша Андрей Александрович on 26.07.16.
// Copyright (c) 2016 FTC. All rights reserved.
//


@class FTCTextEntryFormattingConfig;


NS_ASSUME_NONNULL_BEGIN

@protocol FTCTextEntry;

@protocol FTCTextEntryDelegate<NSObject>

- (void)textEntryDidBeginEditing:(id<FTCTextEntry>)textEntry NS_SWIFT_NAME( textEntryDidBeginEditing(_:) );
- (BOOL)textEntry:(id<FTCTextEntry>)textEntry shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacement NS_SWIFT_NAME( textEntry(_:shouldChangeCharactersIn:replacementString:) );
- (void)textEntryDidEndEditing:(id<FTCTextEntry>)textEntry NS_SWIFT_NAME( textEntryDidEndEditing(_:) );

@end

@protocol FTCTextEntry<NSObject>

@property (nonatomic, strong, nullable) NSString *text;

@property (nonatomic, assign) NSRange selectedTextRange;

- (void)addDelegate:(id<FTCTextEntryDelegate>)delegate NS_SWIFT_NAME( addDelegate(_:) );
- (void)removeDelegate:(id<FTCTextEntryDelegate>)delegate NS_SWIFT_NAME( removeDelegate(_:) );

@end


@interface FTCTextEntryFormatCoordinatorHelper : NSObject

@property (nonatomic, nullable, copy) void (^didChangeValueHandler)();

@property (nonatomic, nullable, copy) NSString *rawValue;

@property (nonatomic, nullable, readonly) NSString *formattedValue;

- (instancetype)initWithUI:(id<FTCTextEntry>)textEntryUI;

- (void)applyFormattingConfig:(FTCTextEntryFormattingConfig *)config NS_SWIFT_NAME( apply(formattingConfig:) );

@end

NS_ASSUME_NONNULL_END
