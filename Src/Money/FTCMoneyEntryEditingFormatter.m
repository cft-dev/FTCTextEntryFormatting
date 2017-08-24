//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCMoneyEntryEditingFormatter.h"
#import "FTCPostfixFormatter.h"

@implementation FTCMoneyEntryEditingFormatter
{
	FTCPostfixFormatter *postfixFormatter;
	NSString *currency;
}

- (instancetype)init
{
	assert(NO && @"Won't happen");
	return nil;
}

- (instancetype)initWithCurrency:(NSString *)aCurrency
{
	self = [super init];

	currency = aCurrency;

	NSString *amountPostfix = @"";
	if( nil != aCurrency )
	{
		amountPostfix = [NSString stringWithFormat:@" %@", currency];
	}
	postfixFormatter = [[FTCPostfixFormatter alloc] initWithPostfix:amountPostfix];

	return self;
}

- (NSString *)rawFromFormatted:(NSString *)formattedValue
{
	return [postfixFormatter rawFromFormatted:formattedValue];
}

- (NSString *)formattedFromRaw:(NSString *)rawValue
{
	assert( nil != rawValue );
	return [postfixFormatter formattedFromRaw:rawValue];
}

- (NSRange)rangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	return [postfixFormatter rangeInFormattedValueForRange:rangeInRawValue inRawValue:rawValue];
}

- (NSRange)rangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue
{
	return [postfixFormatter rangeInRawValueForRange:rangeInFormattedValue inFormattedValue:formattedValue];
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

	if( NO == [object isMemberOfClass:self.class] )
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
	return [currency isEqualToString:formatter->currency];
}

@end
