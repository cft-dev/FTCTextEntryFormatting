//
// Created by Sechko Artem Sergeevich on 29/07/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCIntegralMoneyAmountEntryEditingInputFilter.h"
#import "FTCTextEntryFormattingStringUtils.h"
#import "FTCFilteredString.h"
#import "FTCMoneyEntryFormatUtils.h"
#import <FTCMoneyType/MoneyType.h>
#import <FTCMoneyType/MoneyTypeParser.h>

@implementation FTCIntegralMoneyAmountEntryEditingInputFilter

- (instancetype)init
{
	self = [super init];

	if(nil == self)
	{
		return nil;
	}

	return self;
}

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement
{
	assert( (nil != originalString) && @"Argument 'originalString' must not be nil." );
	assert( (nil != replacement) && @"Argument 'replacement' must not be nil." );

	NSString *filteredReplacement = [FTCMoneyEntryFormatUtils removeFractionalPartFromString:replacement];
	filteredReplacement = [FTCTextEntryFormattingStringUtils removeCharactersOfSet:[FTCIntegralMoneyAmountEntryEditingInputFilter notAllowedCharacters] fromString:filteredReplacement];

	NSRange filteredReplacementRange = range;
	filteredReplacementRange.length = filteredReplacement.length;

	NSString *replacedString = [originalString stringByReplacingCharactersInRange:range withString:filteredReplacement];

	if( [self shouldUseReplacement:replacedString] )
	{
		return [[FTCFilteredString alloc] initWithString:replacedString range:filteredReplacementRange];
	}

	return [[FTCFilteredString alloc] initWithString:originalString range:NSMakeRange(filteredReplacementRange.location, 0)];
}

- (BOOL)shouldUseReplacement:(NSString *)replacement
{
	if( nil != _maxMoneyAmount )
	{
		MoneyType *newMoney = [MoneyTypeParser parseAmountFromString:replacement];

		assert( nil != newMoney );
		if( [_maxMoneyAmount isLessThanAmount:newMoney] )
		{
			return NO;
		}
	}

	return YES;
}

+ (NSCharacterSet *)notAllowedCharacters
{
	static NSCharacterSet *notAllowedCharacters;

	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^
	{
		NSCharacterSet *numericCharSet = [NSCharacterSet decimalDigitCharacterSet];

		notAllowedCharacters = [numericCharSet invertedSet];
	});

	return notAllowedCharacters;
}

- (BOOL)isEqual:(id)object
{
	if( nil == object )
	{
		return NO;
	}

	if( self == object )
	{
		return YES;
	}

	if( NO == [object isKindOfClass:[self class]] )
	{
		return NO;
	}

	return [self isEqualToFilter:object];
}

- (BOOL)isEqualToFilter:(FTCIntegralMoneyAmountEntryEditingInputFilter *)filter
{
	return [_maxMoneyAmount isEqualToMoneyType:filter.maxMoneyAmount];
}

@end
