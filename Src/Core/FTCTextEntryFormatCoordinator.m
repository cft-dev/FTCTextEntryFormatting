//
// Created by Sechko Artem Sergeevich on 05/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

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
	if( nil == self )
	{
		return nil;
	}

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
	assert( (nil != editingFormatter) && @"'editingFormatter' must not be nil here." );

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
	assert( (nil != editingFormatter) && @"'editingFormatter' must not be nil here." );

	isEditing = YES;

	[self doFormatValue];
	[self moveCaretToTheEndOfRawValue];
}

- (void)moveCaretToTheEndOfRawValue
{
	currentSelectionRangeInRawValue = NSMakeRange(_rawValue.length, 0);

	id<FTCTextEntryFormatter> currentFormatter = isEditing ? editingFormatter : notEditingFormatter;
	assert( (nil != currentFormatter) && @"'currentFormatter' must not be nil here." );

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
	assert( (nil != currentFormatter) && @"'currentFormatter' must not be nil here." );

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
	assert( (nil != config) && @"Argument 'config' must not be nil." );
	assert( (nil != config.editingFormatter) && @"'config.editingFormatter' must not be nil here." );
	assert( (nil != config.editingInputFilter) && @"'config.editingInputFilter' must not be nil here." );
	assert( (nil != config.notEditingFormatter) && @"'config.notEditingFormatter' must not be nil here." );
	assert( (nil != config.notEditingInputFilter) && @"'config.notEditingInputFilter' must not be nil here." );

	editingFormatter = config.editingFormatter;
	editingInputFilter = config.editingInputFilter;

	notEditingFormatter = config.notEditingFormatter;
	notEditingInputFilter = config.notEditingInputFilter;

	[self doSetRawValue:_rawValue];
}

- (void)doSetRawValue:(NSString *)rawValue
{
	_rawValue = [self filterValue:rawValue];

	[self doFormatValue];
	[self moveCaretToTheEndOfRawValue];
}

- (NSString *)filterValue:(NSString *)value
{
	assert( (nil != notEditingInputFilter) && @"'notEditingInputFilter' must not be nil here." );

	if( nil == value )
	{
		return value;
	}

	return [notEditingInputFilter filterString:value];
}

@end
