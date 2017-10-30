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
	assert( (nil != originalString) && "Argument 'originalString' must not be nil." );
	assert( (nil != replacement) && "Argument 'replacement' must not be nil." );

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
