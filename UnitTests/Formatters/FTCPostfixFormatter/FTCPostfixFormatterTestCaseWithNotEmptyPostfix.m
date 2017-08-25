//
//  FTCPostfixFormatterTestCaseWithNotEmptyPostfix.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import XCTest;
@import FTCTextEntryFormatting;

@interface FTCPostfixFormatterTestCaseWithNotEmptyPostfix : XCTestCase
{
	FTCPostfixFormatter *formatter;
}

@end

@implementation FTCPostfixFormatterTestCaseWithNotEmptyPostfix

- (void)setUp
{
	[super setUp];

	formatter = [[FTCPostfixFormatter alloc] initWithPostfix:@" rub"];
}

- (void)test_raw_from_formatted
{
	XCTAssertEqualObjects([formatter rawFromFormatted:@" rub"], @"");
	XCTAssertEqualObjects([formatter rawFromFormatted:@"123 rub"], @"123");
}

- (void)test_formatted_from_raw
{
	XCTAssertEqualObjects([formatter formattedFromRaw:@""], @" rub");
	XCTAssertEqualObjects([formatter formattedFromRaw:@"123"], @"123 rub");
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

	rangeInRaw = [formatter rangeInRawValueForRange:NSMakeRange(0, 3) inFormattedValue:@"123 rub"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(0, 3)));

	rangeInRaw = [formatter rangeInRawValueForRange:NSMakeRange(1, 2) inFormattedValue:@"123 rub"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(1, 2)));

	rangeInRaw = [formatter rangeInRawValueForRange:NSMakeRange(2, 3) inFormattedValue:@"123 rub"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(2, 1)));

	rangeInRaw = [formatter rangeInRawValueForRange:NSMakeRange(4, 1) inFormattedValue:@"123 rub"];
	XCTAssertTrue(NSEqualRanges(rangeInRaw, NSMakeRange(3, 0)));
}

@end
