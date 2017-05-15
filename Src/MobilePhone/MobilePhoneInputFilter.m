//
// Created by Дирша Андрей Александрович on 09.11.16.
// Copyright (c) 2016 FTC. All rights reserved.
//

#import "MobilePhoneInputFilter.h"
#import "FTCFilteredString.h"
#import "FTCTextEntryFormattingStringUtils.h"


@implementation MobilePhoneInputFilter
{
}

- (instancetype)initWithMaxLength:(NSUInteger)aLength
{
	self = [super init];

	if( nil == self )
	{
		return nil;
	}

	_maxLength = aLength;

	return self;
}

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement shouldTrim:(BOOL)shouldTrim
{
	assert( nil != originalString );
	assert( nil != replacement );

	NSString *filteredReplacement = [FTCTextEntryFormattingStringUtils stringWithDecimalDigitsFromString:replacement];

	NSString *filteredString = [originalString stringByReplacingCharactersInRange:range withString:filteredReplacement];

	if( shouldTrim && (filteredString.length > _maxLength) )
	{
		filteredString = [filteredString substringFromIndex:filteredString.length - _maxLength];
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