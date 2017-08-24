//
// Created by Kirill Zuev on 07/10/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

#import "FTCLimitedLengthInputFilter.h"
#import "FTCFilteredString.h"

@implementation FTCLimitedLengthInputFilter
{
	NSUInteger maxLength;
}

- (instancetype)init
{
	assert( false && @"Won't happen" );
	return nil;
}

- (instancetype)initWithMaximumLength:(NSUInteger)maximumLength
{
	self = [super init];

	maxLength = maximumLength;

	return self;
}

- (NSString *)trimmedString:(NSString *)string
{
	assert( nil != string && @"String must not be nil" );

	if( string.length > maxLength )
	{
		return [string substringToIndex:maxLength];
	}

	return string;
}

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement
{
	assert( (nil != originalString) && @"Argument 'originalString' must not be nil." );
	assert( (nil != replacement) && @"Argument 'replacement' must not be nil." );

	NSString *replacedString = [originalString stringByReplacingCharactersInRange:range withString:replacement];;

	if( replacedString.length <= maxLength )
	{
		NSRange resultRange = NSMakeRange(range.location, replacement.length);
		return [[FTCFilteredString alloc] initWithString:replacedString range:resultRange];
	}

	NSString *trimmedString = [self trimmedString:originalString];

	return [[FTCFilteredString alloc] initWithString:trimmedString range:NSMakeRange(range.location, 0)];
}

- (NSString *)filterString:(NSString *)string
{
	assert( nil != string );

	return [self trimmedString:string];
}

@end
