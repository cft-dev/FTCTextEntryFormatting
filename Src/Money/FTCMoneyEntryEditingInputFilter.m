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

#import "FTCMoneyEntryEditingInputFilter.h"
#import "FTCFilteredString.h"
#import "FTCTextEntryFormattingStringUtils.h"
#import "FTCMoneyEntryFormatUtils.h"

static const int MAX_FRACTIONAL_DIGITS = 2;

@implementation FTCMoneyEntryEditingInputFilter

- (instancetype)init
{
	self = [super init];

	return self;
}

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement
{
	assert( nil != originalString );
	assert( nil != replacement );

	NSString *filteredReplacement = [FTCMoneyEntryFormatUtils removeNonMoneyEntryCharactersFromString:replacement];

	const NSUInteger originalStringSeparatorLocation = [originalString rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]].location;

	if(NSNotFound != originalStringSeparatorLocation)
	{
		filteredReplacement = [FTCTextEntryFormattingStringUtils removeCharactersOfSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet] fromString:filteredReplacement];
	}
	else
	{
		filteredReplacement = [self filterExtraSeparatorsFromString:filteredReplacement];
	}

	NSRange filteredReplacementRange = range;
	filteredReplacementRange.length = filteredReplacement.length;

	NSString *replacedString = [originalString stringByReplacingCharactersInRange:range withString:filteredReplacement];

	if( [self shouldUseReplacementResult:replacedString] )
	{
		return [[FTCFilteredString alloc] initWithString:replacedString range:filteredReplacementRange];
	}

	return [[FTCFilteredString alloc] initWithString:originalString range:NSMakeRange(filteredReplacementRange.location, 0)];
}

- (BOOL)shouldUseReplacementResult:(nonnull NSString *)replacementResult
{
	const NSUInteger separatorLocation = [replacementResult rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]].location;

	if( NSNotFound != separatorLocation )
	{
		NSString *fractionalPart = [FTCMoneyEntryFormatUtils removeIntegralPartFromString:replacementResult];
		if ( fractionalPart.length > MAX_FRACTIONAL_DIGITS )
		{
			return NO;
		}
	}

	return YES;
}

- (NSString *)filterExtraSeparatorsFromString:(NSString * const)string
{
	NSString *result = string;

	const NSUInteger separatorLocation = [result rangeOfCharacterFromSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet]].location;

	if(NSNotFound != separatorLocation)
	{
		NSString *singleSeparator = [result substringWithRange:NSMakeRange(separatorLocation, 1)];

		result = [FTCTextEntryFormattingStringUtils removeCharactersOfSet:[FTCMoneyEntryFormatUtils decimalSeparatorsCharacterSet] fromString:result];
		result = [result stringByReplacingCharactersInRange:NSMakeRange(separatorLocation, 0) withString:singleSeparator];
	}

	return result;
}

- (BOOL)isEqual:(id)object
{
	return ( (self == object) || [object isMemberOfClass:self.class] );
}

@end
