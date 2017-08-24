//
// Created by Sechko Artem Sergeevich on 25/03/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

#import "FTCPostfixFormatter.h"

@implementation FTCPostfixFormatter

- (instancetype)init
{
	assert(false && @"Won't happen");
	return nil;
}

- (instancetype)initWithPostfix:(NSString *)postfix
{
	self = [super init];

	if(nil == self)
	{
		return nil;
	}

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
	assert( nil != rawValue );

	if( NO == [self canShowPostfix] )
	{
		return rawValue;
	}

	return [rawValue stringByAppendingString:_postfix];
}

- (NSRange)rangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	assert( (rawValue.length >= rangeInRawValue.location + rangeInRawValue.length) && @"Argument 'rangeInRawValue' is out of bounds of 'rawValue'" );

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
