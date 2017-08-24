//
//  FTCMaskFormatterTestCase2.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import FTCTextEntryFormatting;

#import "FormatterGenericTestCase.h"
#import "FTCMaskFormatterGenericConfig.h"

@interface FTCMaskFormatterTestCase2 : XCTestCase
{
	FormatterGenericTestCase *_genericTestCase;
}

@end

@implementation FTCMaskFormatterTestCase2

- (void)setUp
{
	[super setUp];

	_genericTestCase = [[FormatterGenericTestCase alloc] init];

	FTCMaskFormatterGenericConfig *config = [FTCMaskFormatterGenericConfig new];
	config.format = @"_____";
	config.maskCharacter = '_';
	config.cutTail = NO;

	_genericTestCase.formatter = [[FTCMaskFormatter alloc] initWithConfig:config];

	[_genericTestCase addFormattedInputValue:@"_____" etalonRawOutputValue:@""];
	[_genericTestCase addFormattedInputValue:@"foo__" etalonRawOutputValue:@"foo"];
	[_genericTestCase addFormattedInputValue:@"12345" etalonRawOutputValue:@"12345"];

	[_genericTestCase addRawInputValue:@"" etalonFormattedOutputValue:@"_____"];
	[_genericTestCase addRawInputValue:@"foo" etalonFormattedOutputValue:@"foo__"];
	[_genericTestCase addRawInputValue:@"12345" etalonFormattedOutputValue:@"12345"];

	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 0) inRawValue:@"" etalonRangeInFormattedValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 3) inRawValue:@"foo" etalonRangeInFormattedValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(2, 1) inRawValue:@"12345" etalonRangeInFormattedValue:NSMakeRange(2, 1)];

	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 0) inFormattedValue:@"_____" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 2) inFormattedValue:@"_____" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(1, 2) inFormattedValue:@"_____" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 3) inFormattedValue:@"foo__" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 5) inFormattedValue:@"foo__" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(2, 1) inFormattedValue:@"12345" etalonRangeInRawValue:NSMakeRange(2, 1)];
}

- (void)invokeTest
{
	[super invokeTest];

	assert( nil != _genericTestCase );
}

- (void)testToRawFromFormatted
{
	[_genericTestCase testToRawFromFormatted];
}

- (void)testToFormattedFromRaw
{
	[_genericTestCase testToFormattedFromRaw];
}

- (void)testGetRangeInFormattedValueFromRangeInRawValue
{
	[_genericTestCase testGetRangeInFormattedValueFromRangeInRawValue];
}

- (void)testGetRangeInRawValueFromRangeInFormattedValue
{
	[_genericTestCase testGetRangeInRawValueFromRangeInFormattedValue];
}

@end
