// Copyright (c) 2017 CFT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "FTCTextInputUtils.h"

@implementation FTCTextInputUtils

+ (void)selectTextInTextInput:(id<UITextInput>)textInput atRange:(NSRange)selectionRange
{
	assert( nil != textInput );

	const NSUInteger selectionStart = selectionRange.location;
	const NSUInteger selectionEnd = selectionRange.location + selectionRange.length;
	[FTCTextInputUtils selectTextInTextInput:textInput fromIndex:selectionStart toIndex:selectionEnd];
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
	assert( false && "Won't happen." );
	return nil;
}

@end
