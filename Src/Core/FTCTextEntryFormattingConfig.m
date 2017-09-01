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

#import "FTCTextEntryFormattingConfig.h"
#import "FTCNoFormattingFormatter.h"
#import "FTCNoFilteringFilter.h"

@implementation FTCTextEntryFormattingConfig

- (instancetype)init
{
	self = [super init];

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
