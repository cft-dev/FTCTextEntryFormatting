//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "FTCMoneyEntryEditingInputFilter.h"
#import "FTCFilteredString.h"
#import "FTCTextEntryFormattingStringUtils.h"
#import "FTCMoneyEntryFormatUtils.h"
#import <FTCMoneyType/MoneyType.h>
#import <FTCMoneyType/MoneyTypeParser.h>


static const int MAX_FRACTIONAL_DIGITS = 2;


@implementation FTCMoneyEntryEditingInputFilter
{

}

- (instancetype)init
{
	self = [super init];

	if (nil == self)
	{
		return nil;
	}

	return self;
}

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement
{
	assert( nil != originalString );
	assert( nil != replacement );

	NSString *filteredReplacement = [FTCMoneyEntryFormatUtils removeNonMoneyEntryCharactersFromString:replacement];

	const NSUInteger originalStringSeparatorLocation = [originalString rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]].location;

	if(NSNotFound != originalStringSeparatorLocation)
	{
		filteredReplacement = [FTCTextEntryFormattingStringUtils removeCharactersOfSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet] fromString:filteredReplacement];
	}
	else
	{
		filteredReplacement = [self filterExtraSeparatorsFromString:filteredReplacement];
	}

	NSRange filteredReplacementRange = range;
	filteredReplacementRange.length = filteredReplacement.length;

	NSString *replacedString = [originalString stringByReplacingCharactersInRange:range withString:filteredReplacement];

	if( [self shouldUseReplacementResult:replacedString originalString:originalString] )
	{
		return [[FTCFilteredString alloc] initWithString:replacedString range:filteredReplacementRange];
	}

	return [[FTCFilteredString alloc] initWithString:originalString range:NSMakeRange(filteredReplacementRange.location, 0)];
}

- (BOOL)shouldUseReplacementResult:(NSString *)replacementResult originalString:(NSString *)originalString
{
	const NSUInteger separatorLocation = [replacementResult rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]].location;

	if( NSNotFound != separatorLocation )
	{
		NSString *fractionalPart = [FTCMoneyEntryFormatUtils removeIntegralPartFromString:replacementResult];
		if ( fractionalPart.length > MAX_FRACTIONAL_DIGITS )
		{
			return NO;
		}
	}

	if( nil != _maxMoneyAmount )
	{
		MoneyType *newMoney = [MoneyTypeParser parseAmountFromString:replacementResult];
		assert( nil != newMoney );
		if( [_maxMoneyAmount isLessThanAmount:newMoney] )
		{
			return NO;
		}
		if( ([_maxMoneyAmount isEqualToMoneyType:newMoney] && (separatorLocation == replacementResult.length - 1)) &&
				replacementResult.length > originalString.length )
		{
			return NO;
		}
	}

	return YES;
}

- (NSString *)filterExtraSeparatorsFromString:(NSString * const)string
{
	NSString *result = string;

	const NSUInteger separatorLocation = [result rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]].location;

	if(NSNotFound != separatorLocation)
	{
		NSString *singleSeparator = [result substringWithRange:NSMakeRange(separatorLocation, 1)];

		result = [FTCTextEntryFormattingStringUtils removeCharactersOfSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet] fromString:result];
		result = [result stringByReplacingCharactersInRange:NSMakeRange(separatorLocation, 0) withString:singleSeparator];
	}

	return result;
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

- (BOOL)isEqualToFilter:(FTCMoneyEntryEditingInputFilter *)object
{
	return [_maxMoneyAmount isEqualToMoneyType:object.maxMoneyAmount];
}

@end