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

#import "FTCMoneyEntryNotEditingInputFilter.h"
#import "FTCMoneyEntryFormatUtils.h"

static const NSInteger PREFERRED_NUMBER_OF_FRACTIONAL_DIGITS = 2;

@implementation FTCMoneyEntryNotEditingInputFilter

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

	return result;
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
	return ( (self == object) || [object isMemberOfClass:self.class] );
}

@end
