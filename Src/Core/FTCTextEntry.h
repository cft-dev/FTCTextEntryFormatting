//
// Created by Denis Morozov on 23/06/2017.
// Copyright (c) 2017 FTC. All rights reserved.
//

@protocol FTCTextEntry;

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
