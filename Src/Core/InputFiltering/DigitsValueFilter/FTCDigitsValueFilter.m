//
// Created by Denis Morozov on 15/05/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCDigitsValueFilter.h"
#import "FTCFilteredString.h"
#import "FTCTextEntryFormattingStringUtils.h"

@implementation FTCDigitsValueFilter

- (instancetype)initWithMaxLength:(NSUInteger)aLength
{
	self = [super init];
	
	_maxLength = aLength;

	return self;
}

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement shouldTrim:(BOOL)shouldTrim
{
	assert( (nil != originalString) && @"Argument 'originalString' must not be nil." );
	assert( (nil != replacement) && @"Argument 'replacement' must not be nil." );

	NSString *filteredReplacement = [FTCTextEntryFormattingStringUtils stringWithDecimalDigitsFromString:replacement];

	NSString *filteredString = [originalString stringByReplacingCharactersInRange:range withString:filteredReplacement];

	if( shouldTrim && (filteredString.length > _maxLength) && (0 != _maxLength) )
	{
		filteredString = [filteredString substringToIndex:_maxLength];
	}

	if( 0 == _maxLength || filteredString.length <= _maxLength )
	{
		return [[FTCFilteredString alloc] initWithString:filteredString range:NSMakeRange(range.location, filteredReplacement.length)];
	}
	else
	{
		return [[FTCFilteredString alloc] initWithString:originalString range:NSMakeRange(range.location, 0)];
	}
}

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement
{
	return [self replaceSubstringInString:originalString atRange:range withString:replacement shouldTrim:NO];
}

- (NSString *)filterString:(NSString *)string
{
	assert( nil != string );

	return [self replaceSubstringInString:@"" atRange:NSMakeRange(0, 0) withString:string shouldTrim:YES].string;
}

- (instancetype)init
{
	assert( NO );
	return nil;
}

@end
