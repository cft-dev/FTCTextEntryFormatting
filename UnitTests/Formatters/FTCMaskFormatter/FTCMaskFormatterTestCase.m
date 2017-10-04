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

@interface FTCMaskFormatterTestCase : XCTestCase
{
	FTCMaskFormatter *formatterWithCutTail;
	FTCMaskFormatter *formatterWithoutCutTail;
}

@end

@implementation FTCMaskFormatterTestCase

- (void)setUp
{
	[super setUp];
	
	FTCMaskFormatterGenericConfig *configWithCutTail = [[FTCMaskFormatterGenericConfig alloc] initWithMask:@"_ _ _ _ _" maskCharacter:@"_"];
	configWithCutTail.cutTail = YES;

	formatterWithCutTail = [[FTCMaskFormatter alloc] initWithConfig:configWithCutTail];

	FTCMaskFormatterGenericConfig *configWithoutCutTail = [[FTCMaskFormatterGenericConfig alloc] initWithMask:@"_ _ _ _ _" maskCharacter:@"_"];
	configWithoutCutTail.cutTail = NO;

	formatterWithoutCutTail = [[FTCMaskFormatter alloc] initWithConfig:configWithoutCutTail];
}

- (void)test_raw_from_formatted
{
	XCTAssertEqualObjects([formatterWithCutTail rawFromFormatted:@""], @"");
	XCTAssertEqualObjects([formatterWithCutTail rawFromFormatted:@"1 2 3"], @"123");

	XCTAssertEqualObjects([formatterWithoutCutTail rawFromFormatted:@""], @"");
	XCTAssertEqualObjects([formatterWithoutCutTail rawFromFormatted:@"1 2 3"], @"123");
}

- (void)test_formatted_from_raw
{
	XCTAssertEqualObjects([formatterWithCutTail formattedFromRaw:@""], @"");
	XCTAssertEqualObjects([formatterWithCutTail formattedFromRaw:@"123"], @"1 2 3");

	XCTAssertEqualObjects([formatterWithoutCutTail formattedFromRaw:@""], @"_ _ _ _ _");
	XCTAssertEqualObjects([formatterWithoutCutTail formattedFromRaw:@"123"], @"1 2 3 _ _");
}

- (void)test_rangeInFormattedValueForRange_inRawValue
{
	NSRange rangeInFormatted;


	rangeInFormatted = [formatterWithCutTail rangeInFormattedValueForRange:NSMakeRange(0, 3) inRawValue:@"123"];
	XCTAssertTrue(NSEqualRanges(rangeInFormatted, NSMakeRange(0, 6)));

	rangeInFormatted = [formatterWithCutTail rangeInFormattedValueForRange:NSMakeRange(1, 2) inRawValue:@"123"];
	XCTAssertTrue(NSEqualRanges(rangeInFormatted, NSMakeRange(1, 4)));


	rangeInFormatted = [formatterWithoutCutTail rangeInFormattedValueForRange:NSMakeRange(0, 3) inRawValue:@"123"];
	XCTAssertTrue(NSEqualRanges(rangeInFormatted, NSMakeRange(0, 6)));

	rangeInFormatted = [formatterWithoutCutTail rangeInFormattedValueForRange:NSMakeRange(1, 2) inRawValue:@"123"];
	XCTAssertTrue(NSEqualRanges(rangeInFormatted, NSMakeRange(1, 4)));
}

- (void)test_rangeInRawValueForRange_inFormattedValue
{
	NSRange rangeInRaw;


	rangeInRaw = [formatterWithCutTail rangeInRawValueForRange:NSMakeRange(0, 3) inFormattedValue:@"1 2 3"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(0, 2)));

	rangeInRaw = [formatterWithCutTail rangeInRawValueForRange:NSMakeRange(1, 2) inFormattedValue:@"1 2 3"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(1, 1)));


	rangeInRaw = [formatterWithoutCutTail rangeInRawValueForRange:NSMakeRange(0, 3) inFormattedValue:@"1 2 3 _ _"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(0, 2)));

	rangeInRaw = [formatterWithoutCutTail rangeInRawValueForRange:NSMakeRange(1, 2) inFormattedValue:@"1 2 3 _ _"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(1, 1)));
}

@end
