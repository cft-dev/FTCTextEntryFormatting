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

+ (FTCTextEntryFormattingConfig *)mobilePhoneConfigWithMask:(NSString *)mask maskChar:(NSString *)maskChar
{
	return [self mobilePhoneConfigWithMask:mask maskChar:maskChar tailMode:FTCMaskFormatterConfigTailModeNone];
}

+ (FTCTextEntryFormattingConfig *)mobilePhoneConfigWithMask:(NSString *)mask maskChar:(NSString *)maskChar tailMode:(FTCMaskFormatterConfigTailMode)tailMode
{
	__auto_type maskConfig = [[FTCMaskFormatterGenericConfig alloc] initWithMask:mask maskCharacter:maskChar];
	maskConfig.tailMode = tailMode;

	__auto_type maskFormatter = [[FTCMaskFormatter alloc] initWithConfig:maskConfig];
	__auto_type inputFilter = [[FTCDigitsValueFilter alloc] initWithMaxLength:maskConfig.countMaskCharacters];

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
