//
// Created by Yuriy Muzyukin on 4/28/15.
// Copyright (c) 2015 CFT. All rights reserved.
//


#import "FTCNoFilteringFilter.h"
#import "FTCFilteredString.h"


@implementation FTCNoFilteringFilter

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

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement
{
	assert( (nil != originalString) && @"Argument 'originalString' must not be nil." );
	assert( (nil != replacement) && @"Argument 'replacement' must not be nil." );

	NSString *resultString = [originalString stringByReplacingCharactersInRange:range withString:replacement];
	const NSRange resultRange = NSMakeRange(range.location, replacement.length);

	return [[FTCFilteredString alloc] initWithString:resultString range:resultRange];
}

- (NSString *)filterString:(NSString *)string
{
	return string;
}

@end