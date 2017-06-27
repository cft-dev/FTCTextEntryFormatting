//
// Created by Sechko Artem Sergeevich on 30/07/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCMoneyEntryFormatUtils.h"
#import "FTCTextEntryFormattingStringUtils.h"

static NSString * const EMPTY_STRING = @"";
static NSString * const ZERO_STRING = @"0";
static NSString * const DECIMAL_SEPARATORS = @".,";

@implementation FTCMoneyEntryFormatUtils

+ (NSString *)trimZeroHeadFromString:(NSString * const)string
{
	const NSUInteger zeroHeadLength = [FTCMoneyEntryFormatUtils zeroHeadRangeForString:string].length;

	return [string substringFromIndex:zeroHeadLength];
}

+ (NSRange)zeroHeadRangeForString:(NSString * const)string
{
	NSRange zeroHeadRange = NSMakeRange(NSNotFound, 0);

	if( 0 == string.length )
	{
		return zeroHeadRange;
	}

	NSString *substring = nil;
	for(NSUInteger i = 0; i < string.length; i++)
	{
		substring = [string substringWithRange:NSMakeRange(i, 1)];
		if( [ZERO_STRING isEqualToString:substring] )
		{
			zeroHeadRange.length++;
			zeroHeadRange.location = 0;
		}
		else
		{
			break;
		}
	}

	// Обрабатываем случаи @"00", @"00.1", чтобы после триминга иметь @"0", @"0.1" соответственно, иначе
	// если этого не делать, то после триминга будем иметь @"", @".1" соответственно.
	if( zeroHeadRange.length > 0 )
	{
		BOOL reachedDecimalSeparator = (substring != nil && 0 != [self.decimalSeparators rangeOfString:substring].length);
		BOOL reachedEndOfString = (string.length == zeroHeadRange.length);

		if( reachedDecimalSeparator || reachedEndOfString )
		{
			zeroHeadRange.length--;
		}
	}

	return zeroHeadRange;
}

+ (NSString *)removeNonMoneyEntryCharactersFromString:(NSString * const)string
{
	return [FTCTextEntryFormattingStringUtils removeCharactersOfSet:[FTCMoneyEntryFormatUtils nonMoneyEntryCharacters] fromString:string];
}

+ (NSCharacterSet *)nonMoneyEntryCharacters
{
	static NSCharacterSet *notAllowedCharacters;

	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^
	{
		NSMutableCharacterSet *numericCharSet = [NSMutableCharacterSet decimalDigitCharacterSet];
		[numericCharSet addCharactersInString:DECIMAL_SEPARATORS];

		notAllowedCharacters = [numericCharSet invertedSet];
	});

	return notAllowedCharacters;
}

+ (NSString *)removeFractionalPartFromString:(NSString *)string
{
	const NSUInteger separatorLocation = [string rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]].location;

	if(NSNotFound != separatorLocation)
	{
		string = [string substringToIndex:separatorLocation];
	}

	return string;
}

+ (NSString *)removeIntegralPartFromString:(NSString *)string
{
	const NSUInteger separatorLocation = [string rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]].location;

	if(NSNotFound != separatorLocation)
	{
		string = [string substringFromIndex:separatorLocation + 1];
	}

	return string;
}

+ (NSString *)emptyString
{
	return EMPTY_STRING;
}

+ (NSString *)zeroString
{
	return ZERO_STRING;
}

+ (NSString *)decimalSeparators
{
	return DECIMAL_SEPARATORS;
}

+ (NSCharacterSet *)decimalSeparatorsCharacterSet
{
	static NSCharacterSet *separatingCharSet;

	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^
	{
		separatingCharSet = [NSCharacterSet characterSetWithCharactersInString:[FTCMoneyEntryFormatUtils decimalSeparators]];
	});

	return separatingCharSet;
}

+ (NSString *)preferredDecimalSeparator
{
	static NSString *decimalSeparator;

	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^
	{
		NSLocale *russianLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
		decimalSeparator = [russianLocale objectForKey:NSLocaleDecimalSeparator];
	});

	return decimalSeparator;
}

- (instancetype)init
{
	assert( NO );
	return nil;
}

@end
