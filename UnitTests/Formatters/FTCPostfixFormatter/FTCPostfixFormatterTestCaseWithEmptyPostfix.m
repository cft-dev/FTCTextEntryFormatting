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

@import XCTest;
@import FTCTextEntryFormatting;

@interface FTCPostfixFormatterTestCaseWithEmptyPostfix : XCTestCase
{
	FTCPostfixFormatter *formatter;
}

@end

@implementation FTCPostfixFormatterTestCaseWithEmptyPostfix

- (void)setUp
{
	[super setUp];

	formatter = [[FTCPostfixFormatter alloc] initWithPostfix:@""];
}

- (void)test_raw_from_formatted
{
	XCTAssertEqualObjects([formatter rawFromFormatted:@""], @"");
	XCTAssertEqualObjects([formatter rawFromFormatted:@"123"], @"123");
}

- (void)test_formatted_from_raw
{
	XCTAssertEqualObjects([formatter formattedFromRaw:@""], @"");
	XCTAssertEqualObjects([formatter formattedFromRaw:@"123"], @"123");
}

- (void)test_rangeInFormattedValueForRange_inRawValue
{
	NSRange rangeInFormatted;

	rangeInFormatted = [formatter rangeInFormattedValueForRange:NSMakeRange(0, 3) inRawValue:@"123"];
	XCTAssertTrue(NSEqualRanges(rangeInFormatted, NSMakeRange(0, 3)));

	rangeInFormatted = [formatter rangeInFormattedValueForRange:NSMakeRange(1, 2) inRawValue:@"123"];
	XCTAssertTrue(NSEqualRanges(rangeInFormatted, NSMakeRange(1, 2)));
}

- (void)test_rangeInRawValueForRange_inFormattedValue
{
	NSRange rangeInRaw;

	rangeInRaw = [formatter rangeInRawValueForRange:NSMakeRange(0, 3) inFormattedValue:@"123"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(0, 3)));

	rangeInRaw = [formatter rangeInRawValueForRange:NSMakeRange(1, 2) inFormattedValue:@"123"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(1, 2)));
}

@end
