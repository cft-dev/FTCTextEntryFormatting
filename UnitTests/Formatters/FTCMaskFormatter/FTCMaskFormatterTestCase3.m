//
//  FTCMaskFormatterTestCase3.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import FTCTextEntryFormatting;

#import "FormatterGenericTestCase.h"
#import "FTCMaskFormatterGenericConfig.h"

@interface FTCMaskFormatterTestCase3 : XCTestCase
{
	FormatterGenericTestCase *_genericTestCase;
}

@end

@implementation FTCMaskFormatterTestCase3

- (void)setUp
{
	[super setUp];

	_genericTestCase = [[FormatterGenericTestCase alloc] init];
	
	FTCMaskFormatterGenericConfig *config = [FTCMaskFormatterGenericConfig new];
	config.format = @" ___ ___";
	config.maskCharacter = '_';
	config.cutTail = NO;

	_genericTestCase.formatter = [[FTCMaskFormatter alloc] initWithConfig:config];
	
	[_genericTestCase addFormattedInputValue:@" ___ ___" etalonRawOutputValue:@""];
	[_genericTestCase addFormattedInputValue:@" foo ___" etalonRawOutputValue:@"foo"];
	[_genericTestCase addFormattedInputValue:@" foo 123" etalonRawOutputValue:@"foo123"];
	
	[_genericTestCase addRawInputValue:@"" etalonFormattedOutputValue:@" ___ ___"];
	[_genericTestCase addRawInputValue:@"foo" etalonFormattedOutputValue:@" foo ___"];
	[_genericTestCase addRawInputValue:@"foo123" etalonFormattedOutputValue:@" foo 123"];

	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 0) inRawValue:@"" etalonRangeInFormattedValue:NSMakeRange(1, 0)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 3) inRawValue:@"foo" etalonRangeInFormattedValue:NSMakeRange(1, 4)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(3, 3) inRawValue:@"foo123" etalonRangeInFormattedValue:NSMakeRange(4, 4)];

	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 0) inFormattedValue:@" ___ ___" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 8) inFormattedValue:@" ___ ___" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(1, 3) inFormattedValue:@" foo ___" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 4) inFormattedValue:@" foo ___" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(4, 4) inFormattedValue:@" foo ___" etalonRangeInRawValue:NSMakeRange(3, 0)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 8) inFormattedValue:@" 123 456" etalonRangeInRawValue:NSMakeRange(0, 6)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(3, 3) inFormattedValue:@" 123 456" etalonRangeInRawValue:NSMakeRange(2, 2)];
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
