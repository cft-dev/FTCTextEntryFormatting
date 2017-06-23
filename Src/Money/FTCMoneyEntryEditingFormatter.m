//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCMoneyEntryEditingFormatter.h"
#import "FTCPostfixFormatter.h"
#import <FTCMoneyType/CurrencyType.h>

@implementation FTCMoneyEntryEditingFormatter
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
	if( nil != aCurrency )
	{
		amountPostfix = [NSString stringWithFormat:@" %@", [currency getDisplayString]];
	}
	postfixFormatter = [[FTCPostfixFormatter alloc] initWithPostfix:amountPostfix];

	return self;
}

- (NSString *)toRawFromFormatted:(NSString *)formattedValue
{
	return [postfixFormatter toRawFromFormatted:formattedValue];
}

- (NSString *)toFormattedFromRaw:(NSString *)rawValue
{
	assert( nil != rawValue );
	return [postfixFormatter toFormattedFromRaw:rawValue];
}

- (NSRange)getRangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	return [postfixFormatter getRangeInFormattedValueForRange:rangeInRawValue inRawValue:rawValue];
}

- (NSRange)getRangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue
{
	return [postfixFormatter getRangeInRawValueForRange:rangeInFormattedValue inFormattedValue:formattedValue];
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

- (BOOL)isEqualToFormatter:(FTCMoneyEntryEditingFormatter *)formatter
{
	if( nil == currency )
	{
		return (nil == formatter->currency);
	}
	return [currency isEqualToCurrency:formatter->currency];
}

@end
