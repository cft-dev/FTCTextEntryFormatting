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

#import "FTCPostfixFormatter.h"

@implementation FTCPostfixFormatter

- (instancetype)init
{
	assert(false && "Won't happen");
	return nil;
}

- (instancetype)initWithPostfix:(NSString *)postfix
{
	self = [super init];

	_postfix = postfix;

	return self;
}

- (NSString *)rawFromFormatted:(NSString *)formattedValue
{
	if( NO == [self canShowPostfix] )
	{
		return formattedValue;
	}

	NSString *result = formattedValue;

	if(result.length >= _postfix.length)
	{
		NSString *const possiblePostfix = [result substringFromIndex:result.length - _postfix.length];

		if([possiblePostfix isEqualToString:_postfix])
		{
			result = [result substringToIndex:result.length - _postfix.length];
		}
	}

	return result;
}

- (NSString *)formattedFromRaw:(NSString *)rawValue
{
	NSString *result = (rawValue != nil ? rawValue : @"");

	if( NO == [self canShowPostfix] )
	{
		return result;
	}

	return [result stringByAppendingString:_postfix];
}

- (NSRange)rangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	assert( (rawValue.length >= rangeInRawValue.location + rangeInRawValue.length) && "Argument 'rangeInRawValue' is out of bounds of 'rawValue'" );

	return rangeInRawValue;
}

- (NSRange)rangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue
{
	assert( (formattedValue.length >= rangeInFormattedValue.location + rangeInFormattedValue.length) &&
			@"Argument 'rangeInFormattedValue' is out of bounds of 'formattedValue'" );

	NSRange rawRange = rangeInFormattedValue;

	if( [self canShowPostfix] )
	{
		NSRange postfixRange = [formattedValue rangeOfString:_postfix];
		if( NSNotFound != postfixRange.location )
		{
			if( rawRange.location > postfixRange.location )
			{
				rawRange.location = postfixRange.location;
			}

			if( (rawRange.location + rawRange.length) > postfixRange.location )
			{
				NSInteger exceedingLength = (rawRange.location + rawRange.length) - postfixRange.location;

				rawRange.length = rawRange.length - exceedingLength;
			}
		}
	}

	return rawRange;
}

- (BOOL)canShowPostfix
{
	if( nil == _postfix || 0 == _postfix.length )
	{
		return NO;
	}

	return YES;
}

@end
