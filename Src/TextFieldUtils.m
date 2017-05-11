//
// Created by Andrey Sikerin on 11/14/13.
// Copyright (c) 2013 FTC. All rights reserved.


#import "TextFieldUtils.h"


@implementation TextFieldUtils

+ (void)selectTextInTextInput:(id<UITextInput>)textInput atRange:(NSRange)selectionRange
{
	assert( nil != textInput );

	const NSUInteger selectionStart = selectionRange.location;
	const NSUInteger selectionEnd = selectionRange.location + selectionRange.length;
	[TextFieldUtils selectTextInTextInput:textInput fromIndex:selectionStart toIndex:selectionEnd];
}

+ (void)selectTextInTextInput:(id<UITextInput>)textInput fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
	assert( nil != textInput );
	assert( fromIndex <= toIndex && "'fromIndex' or 'toIndex' is out of bounds." );

	UITextPosition *fromPosition = [textInput positionFromPosition:[textInput beginningOfDocument] offset:fromIndex];
	UITextPosition *toPosition = [textInput positionFromPosition:[textInput beginningOfDocument] offset:toIndex];
	UITextRange *selectionRange = [textInput textRangeFromPosition:fromPosition toPosition:toPosition];
	[textInput setSelectedTextRange:selectionRange];
}

+ (void)moveCursorInTextInput:(id<UITextInput>)textInput toPosition:(NSUInteger)position
{
	assert( nil != textInput );

	[self selectTextInTextInput:textInput fromIndex:position toIndex:position];
}

+ (NSRange)selectedRangeInTextInput:(id<UITextInput>)textInput
{
	UITextPosition *beginning = textInput.beginningOfDocument;

	UITextRange *selectedRange = textInput.selectedTextRange;
	UITextPosition *selectionStart = selectedRange.start;
	UITextPosition *selectionEnd = selectedRange.end;

	const NSInteger location = [textInput offsetFromPosition:beginning toPosition:selectionStart];
	const NSInteger length = [textInput offsetFromPosition:selectionStart toPosition:selectionEnd];

	assert( location >= 0 );
	assert( length >= 0 );

	return NSMakeRange((NSUInteger)location, (NSUInteger)length);
}

- (instancetype)init
{
	assert( false && @"Won't happen." );
	return nil;
}

@end