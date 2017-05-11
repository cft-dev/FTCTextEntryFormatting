//
// Created by Andrey Sikerin on 11/14/13.
// Copyright (c) 2013 FTC. All rights reserved.


@interface TextFieldUtils : NSObject

+ (void)selectTextInTextInput:(id<UITextInput>)textInput atRange:(NSRange)selectionRange;
+ (void)selectTextInTextInput:(id<UITextInput>)textInput fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toInde;

+ (void)moveCursorInTextInput:(id<UITextInput>)textInput toPosition:(NSUInteger)position;

+ (NSRange)selectedRangeInTextInput:(id<UITextInput>)textInput;

- (instancetype)init NS_UNAVAILABLE;

@end