//
// Created by Yuriy Muzyukin on 3/24/15.
// Copyright (c) 2015 CFT. All rights reserved.
//


#import "FTCTextEntryFormattingConfig.h"
#import "FTCNoFormattingFormatter.h"
#import "FTCNoFilteringFilter.h"


@implementation FTCTextEntryFormattingConfig

- (instancetype)init
{
	self = [super init];
	if( nil == self )
	{
		return nil;
	}

	_editingFormatter = [[FTCNoFormattingFormatter alloc] init];
	_editingInputFilter = [[FTCNoFilteringFilter alloc] init];

	_notEditingFormatter = [[FTCNoFormattingFormatter alloc] init];
	_notEditingInputFilter = [[FTCNoFilteringFilter alloc] init];

	return self;
}

- (void)setEditingFormatter:(id<FTCTextEntryFormatter>)editingFormatter
{
	assert( (nil != editingFormatter) && @"Argument 'editingFormatter' must not be nil." );

	_editingFormatter = editingFormatter;
}

- (void)setEditingInputFilter:(id<FTCTextEntryEditingInputFilter>)editingInputFilter
{
	assert( (nil != editingInputFilter) && @"Argument 'editingInputFilter' must not be nil." );

	_editingInputFilter = editingInputFilter;
}

- (void)setNotEditingFormatter:(id<FTCTextEntryFormatter>)notEditingFormatter
{
	assert( (nil != notEditingFormatter) && @"Argument 'notEditingFormatter' must not be nil." );

	_notEditingFormatter = notEditingFormatter;
}

- (void)setNotEditingInputFilter:(id<FTCTextEntryNotEditingInputFilter>)notEditingInputFilter
{
	assert( (nil != notEditingInputFilter) && @"Argument 'notEditingInputFilter' must not be nil." );

	_notEditingInputFilter = notEditingInputFilter;
}

- (BOOL)isEqualToConfig:(FTCTextEntryFormattingConfig *)config
{
	if( nil == config )
	{
		return NO;
	}

	BOOL editingFormatterEquality = [self.editingFormatter isEqual:config.editingFormatter];
	BOOL editingInputFormatterEquality = [self.editingInputFilter isEqual:config.editingInputFilter];
	BOOL notEditingFormatterEquality = [self.notEditingFormatter isEqual:config.notEditingFormatter];
	BOOL notEditingInputFormatterEquality = [self.notEditingInputFilter isEqual:config.notEditingInputFilter];

    return editingFormatterEquality && editingInputFormatterEquality && notEditingFormatterEquality && notEditingInputFormatterEquality;
}

@end