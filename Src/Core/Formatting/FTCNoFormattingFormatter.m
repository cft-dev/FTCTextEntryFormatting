//
// Created by Yuriy Muzyukin on 4/28/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

#import "FTCNoFormattingFormatter.h"

@implementation FTCNoFormattingFormatter

- (instancetype)init
{
	self = [super init];
	if( nil == self )
	{
		return nil;
	}

	// intentionally do nothing

	return self;
}

- (NSString *)toRawFromFormatted:(NSString *)formattedValue
{
	return formattedValue;
}

- (NSString *)toFormattedFromRaw:(NSString *)rawValue
{
	return rawValue;
}

- (NSRange)getRangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	return rangeInRawValue;
}

- (NSRange)getRangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue
{
	return rangeInFormattedValue;
}

@end
