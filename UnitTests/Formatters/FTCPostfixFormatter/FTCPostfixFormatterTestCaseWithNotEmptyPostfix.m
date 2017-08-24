//
//  FTCPostfixFormatterTestCaseWithNotEmptyPostfix.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import FTCTextEntryFormatting;

#import "FormatterGenericTestCase.h"

@interface FTCPostfixFormatterTestCaseWithNotEmptyPostfix : XCTestCase
{
	FormatterGenericTestCase *_genericTestCase;
}

@end

@implementation FTCPostfixFormatterTestCaseWithNotEmptyPostfix

- (void)setUp
{
	[super setUp];

	_genericTestCase = [[FormatterGenericTestCase alloc] init];

	_genericTestCase.formatter = [[FTCPostfixFormatter alloc] initWithPostfix:@" руб"];
	
	[_genericTestCase addFormattedInputValue:@" руб" etalonRawOutputValue:@""];
	[_genericTestCase addFormattedInputValue:@"  руб" etalonRawOutputValue:@" "];
	[_genericTestCase addFormattedInputValue:@"1 руб" etalonRawOutputValue:@"1"];
	
	[_genericTestCase addRawInputValue:@"" etalonFormattedOutputValue:@" руб"];
	[_genericTestCase addRawInputValue:@" " etalonFormattedOutputValue:@"  руб"];
	[_genericTestCase addRawInputValue:@"1" etalonFormattedOutputValue:@"1 руб"];
	[_genericTestCase addRawInputValue:@"1 руб" etalonFormattedOutputValue:@"1 руб руб"];
	
	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 0) inRawValue:@"" etalonRangeInFormattedValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 3) inRawValue:@"200" etalonRangeInFormattedValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(2, 1) inRawValue:@"200" etalonRangeInFormattedValue:NSMakeRange(2, 1)];
	
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 0) inFormattedValue:@"" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 3) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(2, 1) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(2, 1)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 4) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(2, 3) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(2, 1)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(4, 1) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(3, 0)];
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
