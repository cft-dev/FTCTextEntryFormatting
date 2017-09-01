//
// Created by Sechko Artem Sergeevich on 27/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCMoneyEntryNotEditingFormatter.h"
#import "FTCPostfixFormatter.h"

@implementation FTCMoneyEntryNotEditingFormatter
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
	if( nil != currency )
	{
		amountPostfix = [NSString stringWithFormat:@" %@", currency];
	}
	postfixFormatter = [[FTCPostfixFormatter alloc] initWithPostfix:amountPostfix];

	return self;
}

- (NSString *)rawFromFormatted:(NSString *)formattedValue
{
	if( NO == [self canShowPostfixForString:formattedValue] )
	{
		return formattedValue;
	}

	return [postfixFormatter rawFromFormatted:formattedValue];
}

- (NSString *)formattedFromRaw:(NSString *)rawValue
{
	if( NO == [self canShowPostfixForString:rawValue] )
	{
		return (rawValue != nil ? rawValue : @"");
	}

	return [postfixFormatter formattedFromRaw:rawValue];
}

- (NSRange)rangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	return [postfixFormatter rangeInFormattedValueForRange:rangeInRawValue inRawValue:rawValue];
}

- (NSRange)rangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue
{
	if( [self canShowPostfixForString:formattedValue] )
	{
		return [postfixFormatter rangeInRawValueForRange:rangeInFormattedValue inFormattedValue:formattedValue];
	}

	return rangeInFormattedValue;
}

- (BOOL)canShowPostfixForString:(nullable NSString *)string
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

	if( NO == [object isMemberOfClass:self.class] )
	{
		return NO;
	}

	return [self isEqualToFormatter:object];
}

- (BOOL)isEqualToFormatter:(FTCMoneyEntryNotEditingFormatter *)object
{
	if( nil == currency )
	{
		return (nil == object->currency);
	}
	return [currency isEqualToString:object->currency];
}

@end
