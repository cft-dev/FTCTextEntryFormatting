//
// Created by Denis Morozov on 25/08/2017.
// Copyright (c) 2017 FTC. All rights reserved.
//

#import "FTCTextEntryFormattingConfigFactory.h"
#import "FTCTextEntryFormattingConfig.h"
#import "FTCMaskFormatterGenericConfig.h"
#import "FTCMaskFormatter.h"
#import "FTCDigitsValueFilter.h"
#import "FTCMoneyEntryNotEditingFormatter.h"
#import "FTCMoneyEntryEditingFormatter.h"
#import "FTCMoneyEntryNotEditingInputFilter.h"
#import "FTCMoneyEntryEditingInputFilter.h"
#import "FTCIntegralMoneyAmountEntryNotEditingInputFilter.h"
#import "FTCIntegralMoneyAmountEntryEditingInputFilter.h"

@implementation FTCTextEntryFormattingConfigFactory

+ (FTCTextEntryFormattingConfig *)mobilePhoneConfigWithFormat:(NSString *)format
                                                     maskChar:(unichar)maskChar
                                               maskCharsCount:(NSUInteger)maskCharsCount
{
	__auto_type maskConfig = [[FTCMaskFormatterGenericConfig alloc] initWithFormat:format];
	maskConfig.maskCharacter = maskChar;

	__auto_type maskFormatter = [[FTCMaskFormatter alloc] initWithConfig:maskConfig];
	__auto_type inputFilter = [[FTCDigitsValueFilter alloc] initWithMaxLength:maskCharsCount];

	__auto_type formattingConfig = [[FTCTextEntryFormattingConfig alloc] init];

	formattingConfig.editingInputFilter = inputFilter;
	formattingConfig.editingFormatter = maskFormatter;
	formattingConfig.notEditingInputFilter = inputFilter;
	formattingConfig.notEditingFormatter = maskFormatter;

	return formattingConfig;
}

+ (FTCTextEntryFormattingConfig *)moneyConfigWithCurrency:(nullable NSString *)currency onlyIntegral:(BOOL)onlyIntegral
{
	__auto_type formattingConfig = [[FTCTextEntryFormattingConfig alloc] init];

	formattingConfig.notEditingFormatter = [[FTCMoneyEntryNotEditingFormatter alloc] initWithCurrency:currency];
	formattingConfig.editingFormatter = [[FTCMoneyEntryEditingFormatter alloc] initWithCurrency:currency];

	if( onlyIntegral )
	{
		formattingConfig.notEditingInputFilter = [[FTCIntegralMoneyAmountEntryNotEditingInputFilter alloc] init];
		formattingConfig.editingInputFilter = [[FTCIntegralMoneyAmountEntryEditingInputFilter alloc] init];
	}
	else
	{
		formattingConfig.notEditingInputFilter = [[FTCMoneyEntryNotEditingInputFilter alloc] init];
		formattingConfig.editingInputFilter = [[FTCMoneyEntryEditingInputFilter alloc] init];
	}

	return formattingConfig;
}

- (instancetype)init
{
	assert( NO );
	return nil;
}

@end