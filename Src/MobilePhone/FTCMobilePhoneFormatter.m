//
// Created by Denis Morozov on 29/04/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCMobilePhoneFormatter.h"
#import "FTCMaskFormatter.h"
#import "FTCMaskFormatterGenericConfig.h"

@implementation FTCMobilePhoneFormatter
{
	FTCMaskFormatter *formatter;
}

- (instancetype)init
{
	assert( false && @"Won't happen" );
	return nil;
}

- (instancetype)initWithConfig:(FTCMaskFormatterGenericConfig *)aConfig
{
	self = [super init];

	formatter = [[FTCMaskFormatter alloc] initWithConfig:aConfig];

	return self;
}

- (NSString *)rawFromFormatted:(NSString *)formattedValue
{
	return [formatter rawFromFormatted:formattedValue];
}

- (NSString *)formattedFromRaw:(NSString *)rawValue
{
	assert( nil != rawValue );
	return [formatter formattedFromRaw:rawValue];
}

- (NSRange)rangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	return [formatter rangeInFormattedValueForRange:rangeInRawValue inRawValue:rawValue];
}

- (NSRange)rangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue
{
	return [formatter rangeInRawValueForRange:rangeInFormattedValue inFormattedValue:formattedValue];
}

@end
