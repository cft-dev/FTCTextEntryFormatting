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

#import "FTCLimitedLengthInputFilter.h"
#import "FTCFilteredString.h"

@implementation FTCLimitedLengthInputFilter
{
	NSUInteger maxLength;
}

- (instancetype)init
{
	assert( false && "Won't happen" );
	return nil;
}

- (instancetype)initWithMaximumLength:(NSUInteger)maximumLength
{
	self = [super init];

	maxLength = maximumLength;

	return self;
}

- (NSString *)trimmedString:(NSString *)string
{
	assert( nil != string && "String must not be nil" );

	if( string.length > maxLength )
	{
		return [string substringToIndex:maxLength];
	}

	return string;
}

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString atRange:(NSRange)range withString:(NSString *)replacement
{
	assert( (nil != originalString) && "Argument 'originalString' must not be nil." );
	assert( (nil != replacement) && "Argument 'replacement' must not be nil." );

	NSString *replacedString = [originalString stringByReplacingCharactersInRange:range withString:replacement];;

	if( replacedString.length <= maxLength )
	{
		NSRange resultRange = NSMakeRange(range.location, replacement.length);
		return [[FTCFilteredString alloc] initWithString:replacedString range:resultRange];
	}

	NSString *trimmedString = [self trimmedString:originalString];

	return [[FTCFilteredString alloc] initWithString:trimmedString range:NSMakeRange(range.location, 0)];
}

- (NSString *)filterString:(NSString *)string
{
	assert( nil != string );

	return [self trimmedString:string];
}

@end
