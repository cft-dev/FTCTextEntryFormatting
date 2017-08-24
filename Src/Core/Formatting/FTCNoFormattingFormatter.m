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

- (NSString *)rawFromFormatted:(NSString *)formattedValue
{
	return formattedValue;
}

- (NSString *)formattedFromRaw:(NSString *)rawValue
{
	return rawValue;
}

- (NSRange)rangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	return rangeInRawValue;
}

- (NSRange)rangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue
{
	return rangeInFormattedValue;
}

@end
