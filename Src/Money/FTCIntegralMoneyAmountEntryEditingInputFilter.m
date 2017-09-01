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

#import "FTCIntegralMoneyAmountEntryEditingInputFilter.h"
#import "FTCTextEntryFormattingStringUtils.h"
#import "FTCFilteredString.h"
#import "FTCMoneyEntryFormatUtils.h"

@implementation FTCIntegralMoneyAmountEntryEditingInputFilter

- (instancetype)init
{
	self = [super init];

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
	return ( (self == object) || [object isMemberOfClass:self.class] );
}

@end
