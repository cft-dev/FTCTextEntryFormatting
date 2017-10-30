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

#import "FTCMoneyEntryNotEditingFormatter.h"
#import "FTCPostfixFormatter.h"

@implementation FTCMoneyEntryNotEditingFormatter
{
	FTCPostfixFormatter *postfixFormatter;

	NSString *currency;
}

- (instancetype)init
{
	assert(NO && "Won't happen");
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
