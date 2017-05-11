//
// Created by Дирша Андрей Александрович on 26.07.16.
// Copyright (c) 2016 FTC. All rights reserved.
//

#import "CaneTextEntryFormatCoordinatorHelper.h"
#import "FTCTextEntryFormatCoordinator.h"
#import "FTCTextEntryFormattingConfig.h"


@interface CaneTextEntryFormatCoordinatorHelper ()<UITextFieldDelegate>

@end

@implementation CaneTextEntryFormatCoordinatorHelper
{
	id<FTCTextEntryUI> __weak entryUI;

	FTCTextEntryFormatCoordinator *formatCoordinator;

    FTCTextEntryFormattingConfig *currentConfig;
}

- (instancetype)initWithUI:(id<FTCTextEntryUI>)anEntryUI
{
	assert( nil != anEntryUI );

	self = [super init];

	entryUI = anEntryUI;
	[entryUI addDelegate:self];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	[self handleValueChange:^
	{
		[formatCoordinator beginEditing];
		entryUI.text = formatCoordinator.formattedValue;
		entryUI.selectedTextRange = formatCoordinator.currentSelectionRangeInFormattedValue;
	}];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)replacement
{
	[self handleValueChange:^
	{
		[formatCoordinator userReplacedInFormattedValueSubstringAtRange:range withString:replacement];
		entryUI.text = formatCoordinator.formattedValue;
		entryUI.selectedTextRange = formatCoordinator.currentSelectionRangeInFormattedValue;
	}];

	return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
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

	const BOOL valueIsReallyChanged = (NO == [initialValue isEqualToString:formatCoordinator.rawValue]);
	if( valueIsReallyChanged && NULL != _didChangeValueHandler )
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