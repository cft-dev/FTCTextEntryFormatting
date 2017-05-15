//
// Created by Denis Morozov on 29/04/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "MobilePhoneFormatter.h"
#import "FTCMaskFormatter.h"
#import "MobilePhoneFormatterConfig.h"


@implementation MobilePhoneFormatter
{
	FTCMaskFormatter *formatter;
}

- (instancetype)init
{
	assert( false && @"Won't happen" );
	return nil;
}

- (instancetype)initWithConfig:(MobilePhoneFormatterConfig *)aConfig
{
	self = [super init];

	if( nil == self )
	{
		return nil;
	}

	formatter = [[FTCMaskFormatter alloc] initWithConfig:aConfig];

	return self;
}

- (NSString *)toRawFromFormatted:(NSString *)formattedValue
{
	return [formatter toRawFromFormatted:formattedValue];
}

- (NSString *)toFormattedFromRaw:(NSString *)rawValue
{
	assert( nil != rawValue );
	return [formatter toFormattedFromRaw:rawValue];
}

- (NSRange)getRangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	return [formatter getRangeInFormattedValueForRange:rangeInRawValue inRawValue:rawValue];
}

- (NSRange)getRangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue
{
	return [formatter getRangeInRawValueForRange:rangeInFormattedValue inFormattedValue:formattedValue];
}


@end