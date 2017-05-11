//
// Created by Andrey Sikerin on 11/14/13.
// Copyright (c) 2013 FTC. All rights reserved.


#import "FTCTextEntryFormattingStringUtils.h"

@implementation FTCTextEntryFormattingStringUtils

+ (NSString *)joinStringsFromArray:(NSArray *)arrayToJoinStringsFrom
{
#if defined(DEBUG)
	for( id obj in arrayToJoinStringsFrom )
	{
		assert( [obj isKindOfClass:[NSString class]] && @"'obj' is of unexpected class." );
	}
#endif // defined(DEBUG)

	return [arrayToJoinStringsFrom componentsJoinedByString:@""];
}

+ (NSString *)removeCharactersOfSet:(NSCharacterSet *)characterSet fromString:(NSString *)string
{
	return [self joinStringsFromArray:[string componentsSeparatedByCharactersInSet:characterSet]];
}

+ (NSString *)stringWithDecimalDigitsFromString:(NSString *)string
{
	if (nil == string || 0 == [string length])
	{
		return string;
	}

	NSCharacterSet *bannedCharacters = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	NSString *normalString = [self removeCharactersOfSet:bannedCharacters fromString:string];
	return normalString;
}

+ (NSString *)stringWithCharacter:(unichar)character
{
	return [NSString stringWithCharacters:&character length:1];
}

@end