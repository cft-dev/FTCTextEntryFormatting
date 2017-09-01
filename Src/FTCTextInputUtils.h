//
// Created by Andrey Sikerin on 11/14/13.
// Copyright (c) 2013 FTC. All rights reserved.

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface FTCTextInputUtils : NSObject

+ (void)selectTextInTextInput:(id<UITextInput>)textInput atRange:(NSRange)selectionRange NS_SWIFT_NAME( selectText(in:at:) );
+ (void)selectTextInTextInput:(id<UITextInput>)textInput fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex NS_SWIFT_NAME( selectText(in:from:to:) );

+ (void)moveCursorInTextInput:(id<UITextInput>)textInput toPosition:(NSUInteger)position NS_SWIFT_NAME( moveCursor(in:to:) );

+ (NSRange)selectedRangeInTextInput:(id<UITextInput>)textInput NS_SWIFT_NAME( selectedRange(in:) );

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
