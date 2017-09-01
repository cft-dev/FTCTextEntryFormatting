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

#import "FTCTextEntryFormatCoordinatorHelper.h"
#import "FTCTextEntryFormatCoordinator.h"
#import "FTCTextEntryFormattingConfig.h"
#import "FTCTextEntry.h"

@interface FTCTextEntryFormatCoordinatorHelper ()

@end

@implementation FTCTextEntryFormatCoordinatorHelper
{
	id<FTCTextEntry> __weak entryUI;

	FTCTextEntryFormatCoordinator *formatCoordinator;

    FTCTextEntryFormattingConfig *currentConfig;
}

- (instancetype)initWithUI:(id<FTCTextEntry>)anEntryUI
{
	assert( nil != anEntryUI );

	self = [super init];

	entryUI = anEntryUI;
	formatCoordinator = [[FTCTextEntryFormatCoordinator alloc] init];

	return self;
}

- (NSString *)rawValue
{
	return formatCoordinator.rawValue;
}

- (void)setRawValue:(NSString *)rawValue
{
	BOOL shouldBecomeFirstResponder = NO;
	if( [formatCoordinator isEditing] )
	{
		shouldBecomeFirstResponder = YES;
		[formatCoordinator endEditing];
	}
	assert( NO == [formatCoordinator isEditing] );

	formatCoordinator.rawValue = [rawValue copy];
	entryUI.text = formatCoordinator.formattedValue;

	if( shouldBecomeFirstResponder )
	{
		[formatCoordinator beginEditing];
	}
}

- (NSString *)formattedValue
{
	return formatCoordinator.formattedValue;
}

- (void)beginEditing
{
	[self handleValueChange:^
	{
		[formatCoordinator beginEditing];
		entryUI.text = formatCoordinator.formattedValue;
		entryUI.selectedTextRange = formatCoordinator.currentSelectionRangeInFormattedValue;
	}];
}

- (void)changeCharactersInRange:(NSRange)range replacement:(NSString *)replacement
{
	[self handleValueChange:^
	{
		[formatCoordinator userReplacedInFormattedValueSubstringAtRange:range withString:replacement];
		entryUI.text = formatCoordinator.formattedValue;
		entryUI.selectedTextRange = formatCoordinator.currentSelectionRangeInFormattedValue;
	}];
}

- (void)endEditing
{
	[self handleValueChange:^
	{
		[formatCoordinator endEditing];
		entryUI.text = formatCoordinator.formattedValue;
	}];
}

- (void)handleValueChange:(void(^)())valueChange
{
	NSString *initialValue = formatCoordinator.rawValue;

	if( NULL != valueChange )
	{
		valueChange();
	}

	if( NULL == _didChangeValueHandler )
	{
		return;
	}

	BOOL valueIsReallyChanged;
	if( (nil == initialValue) && (nil == formatCoordinator.rawValue) )
	{
		valueIsReallyChanged = NO;
	}
	else
	{
		valueIsReallyChanged = (NO == [initialValue isEqualToString:formatCoordinator.rawValue]);
	}

	if( valueIsReallyChanged )
	{
		_didChangeValueHandler();
	}
}

- (void)applyFormattingConfig:(FTCTextEntryFormattingConfig *)config
{
	assert( nil != config );

	[formatCoordinator applyConfig:config];

	NSRange currentRange = entryUI.selectedTextRange;
	if( (NSNotFound != currentRange.location) && (0 != currentRange.location) && [config isEqualToConfig:currentConfig] )
	{
		formatCoordinator.currentSelectionRangeInFormattedValue = currentRange;
	}

	entryUI.text = formatCoordinator.formattedValue;

	entryUI.selectedTextRange = formatCoordinator.currentSelectionRangeInFormattedValue;

	currentConfig = config;
}

@end
