//
//  FTCPostfixFormatterTestCaseWithNilPostfix.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import FTCTextEntryFormatting;

#import "FormatterGenericTestCase.h"

@interface FTCPostfixFormatterTestCaseWithNilPostfix : XCTestCase
{
	FormatterGenericTestCase *_genericTestCase;
}

@end

@implementation FTCPostfixFormatterTestCaseWithNilPostfix

- (void)setUp
{
	[super setUp];

	_genericTestCase = [[FormatterGenericTestCase alloc] init];

	_genericTestCase.formatter = [[FTCPostfixFormatter alloc] initWithPostfix:nil];
	
	[_genericTestCase addFormattedInputValue:@"" etalonRawOutputValue:@""];
	[_genericTestCase addFormattedInputValue:@"foo" etalonRawOutputValue:@"foo"];
	
	[_genericTestCase addRawInputValue:@"" etalonFormattedOutputValue:@""];
	[_genericTestCase addRawInputValue:@"foo" etalonFormattedOutputValue:@"foo"];
	
	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 0) inRawValue:@"" etalonRangeInFormattedValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 3) inRawValue:@"foo" etalonRangeInFormattedValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(2, 1) inRawValue:@"foo" etalonRangeInFormattedValue:NSMakeRange(2, 1)];
	
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 0) inFormattedValue:@"" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 3) inFormattedValue:@"foo" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(2, 1) inFormattedValue:@"foo" etalonRangeInRawValue:NSMakeRange(2, 1)];
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
