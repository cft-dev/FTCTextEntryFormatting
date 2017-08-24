//
// Created by Sechko Artem Sergeevich on 09/06/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

#import "FTCToUpperCaseInputFilter.h"
#import "FTCFilteredString.h"

@implementation FTCToUpperCaseInputFilter

- (instancetype)init
{
	self = [super init];

	return self;
}

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement
{
	assert( (nil != originalString) && @"Argument 'originalString' must not be nil." );
	assert( (nil != replacement) && @"Argument 'replacement' must not be nil." );

	NSString * const upperCaseReplacement = [replacement uppercaseString];

	NSString * const resultString = [originalString stringByReplacingCharactersInRange:range withString:upperCaseReplacement];
	const NSRange resultRange = NSMakeRange(range.location, upperCaseReplacement.length);

	return [[FTCFilteredString alloc] initWithString:resultString range:resultRange];
}

- (NSString *)filterString:(NSString *)string
{
	assert( nil != string );

	return [string uppercaseString];
}

@end
