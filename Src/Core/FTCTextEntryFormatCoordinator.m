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

#import "FTCTextEntryFormatCoordinator.h"
#import "FTCTextEntryFormatter.h"
#import "FTCFilteredString.h"
#import "FTCTextEntryEditingInputFilter.h"
#import "FTCTextEntryNotEditingInputFilter.h"
#import "FTCTextEntryFormattingConfig.h"

@implementation FTCTextEntryFormatCoordinator
{
	BOOL isEditing;

	NSRange currentSelectionRangeInRawValue;

	id<FTCTextEntryFormatter> editingFormatter;
	id<FTCTextEntryEditingInputFilter> editingInputFilter;

	id<FTCTextEntryFormatter> notEditingFormatter;
	id<FTCTextEntryNotEditingInputFilter> notEditingInputFilter;
}

- (instancetype)init
{
	self = [super init];

	[self applyDefaultConfig];

	self.rawValue = @"";

	return self;
}

- (void)applyDefaultConfig
{
	FTCTextEntryFormattingConfig *defaultConfig = [[FTCTextEntryFormattingConfig alloc] init];
	[self applyConfig:defaultConfig];
}

- (void)userReplacedInFormattedValueSubstringAtRange:(NSRange)range withString:(NSString *)replacement
{
	assert( nil != replacement );
	assert( isEditing );
	assert( (nil != editingFormatter) && "'editingFormatter' must not be nil here." );

	NSRange replacementRangeInRawValue = [editingFormatter rangeInRawValueForRange:range inFormattedValue:_formattedValue];

	assert( (nil != _rawValue) || (nil == _rawValue && (replacementRangeInRawValue.location + replacementRangeInRawValue.length == 0)) );

	//фикс так как voice input добавляет пробел и не вызывает replacement
	replacementRangeInRawValue.location = MIN(_rawValue.length, replacementRangeInRawValue.location);

	FTCFilteredString *filteredRawString = [editingInputFilter replaceSubstringInString:(nil != _rawValue ? _rawValue : @"")
	                                                                            atRange:replacementRangeInRawValue
	                                                                         withString:replacement];

	assert( nil != filteredRawString.string );

	_rawValue = filteredRawString.string;
	[self doFormatValue];

	const NSRange filteredRange = filteredRawString.range;
	const NSUInteger lastInsertedCharacterLocation = filteredRange.location + filteredRange.length;
	currentSelectionRangeInRawValue = NSMakeRange(lastInsertedCharacterLocation, 0);
	_currentSelectionRangeInFormattedValue = [editingFormatter rangeInFormattedValueForRange:currentSelectionRangeInRawValue inRawValue:_rawValue];
}

- (void)beginEditing
{
	assert( NO == isEditing );
	assert( (nil != editingFormatter) && "'editingFormatter' must not be nil here." );

	isEditing = YES;

	[self doFormatValue];
	[self moveCaretToTheEndOfRawValue];
}

- (void)moveCaretToTheEndOfRawValue
{
	currentSelectionRangeInRawValue = NSMakeRange(_rawValue.length, 0);

	id<FTCTextEntryFormatter> currentFormatter = isEditing ? editingFormatter : notEditingFormatter;
	assert( (nil != currentFormatter) && "'currentFormatter' must not be nil here." );

	_currentSelectionRangeInFormattedValue = [currentFormatter rangeInFormattedValueForRange:currentSelectionRangeInRawValue inRawValue:_rawValue];
}

- (void)endEditing
{
	assert( isEditing );

	isEditing = NO;

	_rawValue = [self filterValue:_rawValue];

	[self doFormatValue];
}

- (void)doFormatValue
{
	id<FTCTextEntryFormatter> currentFormatter = isEditing ? editingFormatter : notEditingFormatter;
	assert( (nil != currentFormatter) && "'currentFormatter' must not be nil here." );

	_formattedValue = [currentFormatter formattedFromRaw:(nil != _rawValue ? _rawValue : @"")];
}

- (BOOL)isEditing
{
	return isEditing;
}

- (void)setRawValue:(NSString *)rawValue
{
	assert( NO == isEditing );

	[self doSetRawValue:rawValue];
}

- (void)applyConfig:(FTCTextEntryFormattingConfig *)config
{
	assert( (nil != config) && "Argument 'config' must not be nil." );
	assert( (nil != config.editingFormatter) && "'config.editingFormatter' must not be nil here." );
	assert( (nil != config.editingInputFilter) && "'config.editingInputFilter' must not be nil here." );
	assert( (nil != config.notEditingFormatter) && "'config.notEditingFormatter' must not be nil here." );
	assert( (nil != config.notEditingInputFilter) && "'config.notEditingInputFilter' must not be nil here." );

	editingFormatter = config.editingFormatter;
	editingInputFilter = config.editingInputFilter;

	notEditingFormatter = config.notEditingFormatter;
	notEditingInputFilter = config.notEditingInputFilter;

	[self doSetRawValue:_rawValue];
}

- (void)doSetRawValue:(nullable NSString *)rawValue
{
	_rawValue = [self filterValue:rawValue];

	[self doFormatValue];
	[self moveCaretToTheEndOfRawValue];
}

- (nullable NSString *)filterValue:(nullable NSString *)value
{
	assert( (nil != notEditingInputFilter) && "'notEditingInputFilter' must not be nil here." );

	if( nil == value )
	{
		return value;
	}

	return [notEditingInputFilter filterString:value];
}

@end
