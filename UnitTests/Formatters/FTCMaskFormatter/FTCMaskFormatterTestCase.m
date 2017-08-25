//
//  FTCMaskFormatterTestCase.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

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
	
	FTCMaskFormatterGenericConfig *configWithCutTail = [[FTCMaskFormatterGenericConfig alloc] initWithFormat:@"_ _ _ _ _"];
	configWithCutTail.maskCharacter = '_';
	configWithCutTail.cutTail = YES;

	formatterWithCutTail = [[FTCMaskFormatter alloc] initWithConfig:configWithCutTail];

	FTCMaskFormatterGenericConfig *configWithoutCutTail = [[FTCMaskFormatterGenericConfig alloc] initWithFormat:@"_ _ _ _ _"];
	configWithoutCutTail.maskCharacter = '_';
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
