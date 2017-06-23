//
// Created by Sechko Artem Sergeevich on 29/07/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "FTCIntegralMoneyAmountEntryNotEditingInputFilter.h"
#import "FTCMoneyEntryFormatUtils.h"
#import <FTCMoneyType/MoneyType.h>
#import <FTCMoneyType/MoneyTypeParser.h>


@implementation FTCIntegralMoneyAmountEntryNotEditingInputFilter

- (instancetype)init
{
	self = [super init];

	return self;
}

- (NSString *)filterString:(NSString *)string
{
	assert( nil != string );

	if( 0 == string.length )
	{
		return [FTCMoneyEntryFormatUtils emptyString];
	}

	string = [self checkMaximum:string];

	string = [FTCMoneyEntryFormatUtils removeFractionalPartFromString:string];
	string = [FTCMoneyEntryFormatUtils trimZeroHeadFromString:string];
	string = [FTCMoneyEntryFormatUtils removeNonMoneyEntryCharactersFromString:string];

	return string;
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
		return [NSString stringWithFormat:@"%ld", (long) [_maxMoneyAmount integerValuePart]];
	}
	return string;
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

- (BOOL)isEqualToFilter:(FTCIntegralMoneyAmountEntryNotEditingInputFilter *)filter
{
	return [_maxMoneyAmount isEqualToMoneyType:filter.maxMoneyAmount];
}

@end