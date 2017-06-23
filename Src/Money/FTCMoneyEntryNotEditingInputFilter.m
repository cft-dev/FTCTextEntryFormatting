//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "FTCMoneyEntryNotEditingInputFilter.h"
#import "FTCMoneyEntryFormatUtils.h"
#import <FTCMoneyType/MoneyType.h>
#import <FTCMoneyType/MoneyTypeParser.h>


static const NSInteger PREFERRED_NUMBER_OF_FRACTIONAL_DIGITS = 2;

@implementation FTCMoneyEntryNotEditingInputFilter
{

}

- (instancetype)init
{
	self = [super init];

	if(nil == self)
	{
		return nil;
	}

	return self;
}

- (NSString *)filterString:(NSString *)string
{
	assert( nil != string );

	if( 0 == string.length )
	{
		return [FTCMoneyEntryFormatUtils emptyString];
	}

	NSString *result = [FTCMoneyEntryFormatUtils removeNonMoneyEntryCharactersFromString:string];
	result = [FTCMoneyEntryFormatUtils trimZeroHeadFromString:result];
	result = [self trimZeroTailFromString:result];
	result = [self trimEndingSeparatorInString:result];

	if( 0 == result.length )
	{
		result = [FTCMoneyEntryFormatUtils zeroString];
	}

	result = [self fixNotExistingIntegerPartInString:result];
	result = [self appendMissingZeroInFractionalPartToString:result];
	result = [self checkMaximum:result];

	return result;
}

- (NSString *)checkMaximum:(NSString *)string
{
	if( nil == _maxMoneyAmount )
	{
		return string;
	}
	MoneyType *moneyAmount = [MoneyTypeParser parseAmountFromString:string];
	if( [_maxMoneyAmount isLessThanAmount:moneyAmount] )
	{
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];

		formatter.numberStyle = NSNumberFormatterCurrencyStyle;
		formatter.roundingMode = NSNumberFormatterRoundDown;
		formatter.maximumFractionDigits = 2;

		formatter.positivePrefix = @"";
		formatter.positiveSuffix = @"";

		formatter.negativePrefix = @"\u2212";
		formatter.negativeSuffix = @"";

		formatter.currencySymbol = @"";
		formatter.currencyCode = @"";

		formatter.currencyGroupingSeparator = @"\u2060 \u2060";

		NSString *result = [formatter stringFromNumber:@(_maxMoneyAmount.value)];
		return [FTCMoneyEntryFormatUtils removeNonMoneyEntryCharactersFromString:result];
	}
	return string;
}

- (NSString *)trimZeroTailFromString:(NSString * const)string
{
	NSString *result = string;

	const NSUInteger separatorLocation = [string rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]].location;

	if(NSNotFound != separatorLocation)
	{
		const NSUInteger zeroTailLocation = [self zeroTailRangeForString:result].location;

		if(NSNotFound != zeroTailLocation)
		{
			result = [result substringToIndex:zeroTailLocation];
		}
	}

	return result;
}

- (NSString *)trimEndingSeparatorInString:(NSString * const)string
{
	NSString *result = string;

	if(0 < result.length)
	{
		const NSRange trimmedStringSeparatorRange = [result rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]];

		if(NSNotFound != trimmedStringSeparatorRange.location)
		{
			if (result.length == trimmedStringSeparatorRange.location + 1)
			{
				result = [result substringToIndex:trimmedStringSeparatorRange.location];
			}
		}
	}

	return result;
}

- (NSString *)fixNotExistingIntegerPartInString:(NSString * const)string
{
	NSString *result = string;

	if(0 < result.length)
	{
		const NSRange trimmedStringSeparatorRange = [result rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]];

		if(0 == trimmedStringSeparatorRange.location)
		{
			result = [[FTCMoneyEntryFormatUtils zeroString] stringByAppendingString:result];
		}
	}

	return result;
}

- (NSString *)appendMissingZeroInFractionalPartToString:(NSString * const)string
{
	NSString *result = string;

	NSRange separatorRange = [string rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]];

	if( NSNotFound != separatorRange.location )
	{
		const NSInteger numberOfFractionalDigits = string.length - (separatorRange.location + separatorRange.length);
		const NSInteger fractionalDigitsToAdd = PREFERRED_NUMBER_OF_FRACTIONAL_DIGITS - numberOfFractionalDigits;

		if( fractionalDigitsToAdd > 0 )
		{
			for( NSInteger index = 0; index < fractionalDigitsToAdd; index++ )
			{
				result = [result stringByAppendingString:[FTCMoneyEntryFormatUtils zeroString]];
			}
		}
	}
	else
	{
		NSString *separator = [FTCMoneyEntryFormatUtils preferredDecimalSeparator];
		NSString *zeroString = [FTCMoneyEntryFormatUtils zeroString];
		NSString *zeroTail = [zeroString stringByAppendingString:zeroString];
		NSString *tail = [separator stringByAppendingString:zeroTail];
		result = [result stringByAppendingString:tail];
	}

	return result;
}

- (NSRange)zeroTailRangeForString:(NSString * const)string
{
	NSRange zeroHeadRange = NSMakeRange(NSNotFound, 0);

	if( 0 == string.length )
	{
		return zeroHeadRange;
	}

	for(NSInteger i = string.length - 1; i >= 0; i--)
	{
		NSString *substring = [string substringWithRange:NSMakeRange((NSUInteger)i, 1)];

		if( [[FTCMoneyEntryFormatUtils zeroString] isEqualToString:substring] )
		{
			zeroHeadRange.length++;
			zeroHeadRange.location = (NSUInteger)i;
		}
		else
		{
			break;
		}
	}

	return zeroHeadRange;
}

- (BOOL)isEqual:(id)object
{
    if( nil == object )
    {
        return NO;
    }

    if( self == object )
    {
        return YES;
    }

    if( NO == [object isKindOfClass:[self class]] )
    {
        return NO;
    }

    return [self isEqualToFilter:object];
}

- (BOOL)isEqualToFilter:(FTCMoneyEntryNotEditingInputFilter *)object
{
	return [_maxMoneyAmount isEqualToMoneyType:object.maxMoneyAmount];
}

@end