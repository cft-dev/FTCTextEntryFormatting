// Copyright (c) 2017 CFT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
