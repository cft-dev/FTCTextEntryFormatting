//
// Created by Denis Morozov on 11/07/2017.
//

#import "FTCTextFieldFormatCoordinator.h"
#import "FTCTextEntry.h"
#import "FTCTextInputUtils.h"
#import "FTCTextEntryFormatCoordinatorHelper.h"
#import "FTCTextEntryFormattingConfig.h"

@interface FTCTextFieldFormatCoordinator()<FTCTextEntry, UITextFieldDelegate>
{
	UITextField * __weak textField;

	FTCTextEntryFormatCoordinatorHelper *formatCoordinatorHelper;
}

@end

@implementation FTCTextFieldFormatCoordinator

- (instancetype)initWithTextField:(UITextField *)aTextField
{
	assert(aTextField != nil);

	self = [super init];

	textField = aTextField;

	_textFieldDelegate = textField.delegate;
	textField.delegate = self;

	formatCoordinatorHelper = [[FTCTextEntryFormatCoordinatorHelper alloc] initWithUI:self];

	return self;
}

// MARK: Public

- (void)setDidChangeValueHandler:(void (^)())didChangeValueHandler
{
	[formatCoordinatorHelper setDidChangeValueHandler: didChangeValueHandler];
}

- (void (^)())didChangeValueHandler
{
	return [formatCoordinatorHelper didChangeValueHandler];
}

- (void)setRawValue:(NSString *)rawValue
{
	[formatCoordinatorHelper setRawValue:rawValue];
}

- (NSString *)rawValue
{
	return [formatCoordinatorHelper rawValue];
}

- (NSString *)formattedValue
{
	return formatCoordinatorHelper.formattedValue;
}

- (void)applyFormattingConfig:(FTCTextEntryFormattingConfig *)config
{
	[formatCoordinatorHelper applyFormattingConfig:config];
}

// MARK: FTCTextEntry

- (NSString *)text
{
	return textField.text;
}

- (void)setText:(NSString *)text
{
	textField.text = text;
}

- (NSRange)selectedTextRange
{
	return [FTCTextInputUtils selectedRangeInTextInput:textField];
}

- (void)setSelectedTextRange:(NSRange)selectedTextRange
{
	[FTCTextInputUtils selectTextInTextInput:textField atRange:selectedTextRange];
}

// MARK: UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
	{
		[self.textFieldDelegate textFieldDidBeginEditing:textField];
	}

	[formatCoordinatorHelper beginEditing];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
	{
		[self.textFieldDelegate textFieldDidEndEditing:textField];
	}

	[formatCoordinatorHelper endEditing];
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:reason:)])
	{
		return [self.textFieldDelegate textFieldDidEndEditing:textField reason:reason];
	}
	else if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
	{
		[self.textFieldDelegate textFieldDidEndEditing:textField];
	}

	[formatCoordinatorHelper endEditing];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	BOOL shouldChange = YES;

	if ([self.textFieldDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
	{
		shouldChange = [self.textFieldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
	}

	if (shouldChange)
	{
		[formatCoordinatorHelper changeCharactersInRange:range replacement:string];
	}

	return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
	{
		return [self.textFieldDelegate textFieldShouldBeginEditing:textField];
	}
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
	{
		return [self.textFieldDelegate textFieldShouldEndEditing:textField];
	}
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldClear:)])
	{
		return [self.textFieldDelegate textFieldShouldClear:textField];
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
	{
		return [self.textFieldDelegate textFieldShouldReturn:textField];
	}
	return YES;
}

// MARK: Unavailable init

- (instancetype)init
{
	assert(NO);
	return nil;
}

@end
