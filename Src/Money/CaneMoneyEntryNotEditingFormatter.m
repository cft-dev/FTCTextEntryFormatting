//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "CaneMoneyEntryNotEditingFormatter.h"
#import "FTCPostfixFormatter.h"
#import <FTCMoneyType/CurrencyType.h>


@implementation CaneMoneyEntryNotEditingFormatter
{
	FTCPostfixFormatter *postfixFormatter;

	CurrencyType *currency;
}

- (instancetype)init
{
	assert(NO && @"Won't happen");
	return nil;
}

- (instancetype)initWithCurrency:(CurrencyType *)aCurrency
{
	self = [super init];

	currency = aCurrency;

	NSString *amountPostfix = @"";
	if( nil != currency )
	{
		amountPostfix = [NSString stringWithFormat:@" %@", [currency getDisplayString]];
	}
	postfixFormatter = [[FTCPostfixFormatter alloc] initWithPostfix:amountPostfix];

	return self;
}

- (NSString *)toRawFromFormatted:(NSString *)formattedValue
{
	if( NO == [self canShowPostfixForString:formattedValue] )
	{
		return formattedValue;
	}

	return [postfixFormatter toRawFromFormatted:formattedValue];
}

- (NSString *)toFormattedFromRaw:(NSString *)rawValue
{
	assert( nil != rawValue );

	if( NO == [self canShowPostfixForString:rawValue] )
	{
		return rawValue;
	}

	return [postfixFormatter toFormattedFromRaw:rawValue];
}

- (NSRange)getRangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	return [postfixFormatter getRangeInFormattedValueForRange:rangeInRawValue inRawValue:rawValue];
}

- (NSRange)getRangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue
{
	if( [self canShowPostfixForString:formattedValue] )
	{
		return [postfixFormatter getRangeInRawValueForRange:rangeInFormattedValue inFormattedValue:formattedValue];
	}

	return rangeInFormattedValue;
}

- (BOOL)canShowPostfixForString:(NSString *)string
{
	if(0 == string.length)
	{
		return NO;
	}

	return YES;
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

	return [self isEqualToFormatter:object];
}

- (BOOL)isEqualToFormatter:(CaneMoneyEntryNotEditingFormatter *)object
{
	if( nil == currency )
	{
		return (nil == object->currency);
	}
	return [currency isEqualToCurrency:object->currency];
}

@end