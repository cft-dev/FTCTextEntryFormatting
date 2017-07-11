//
// Created by Sechko Artem Sergeevich on 29/07/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCIntegralMoneyAmountEntryEditingInputFilter.h"
#import "FTCTextEntryFormattingStringUtils.h"
#import "FTCFilteredString.h"
#import "FTCMoneyEntryFormatUtils.h"

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

	return [[FTCFilteredString alloc] initWithString:replacedString range:filteredReplacementRange];
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
	return ( (self == object) || [object isKindOfClass:FTCIntegralMoneyAmountEntryEditingInputFilter.class] );
}

@end
