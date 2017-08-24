//
//  FTCMaskFormatterTestCase1.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import FTCTextEntryFormatting;

#import "FormatterGenericTestCase.h"
#import "FTCMaskFormatterGenericConfig.h"

@interface FTCMaskFormatterTestCase1 : XCTestCase
{
	FormatterGenericTestCase *_genericTestCase;
}

@end

@implementation FTCMaskFormatterTestCase1

- (void)setUp
{
	[super setUp];

	_genericTestCase = [[FormatterGenericTestCase alloc] init];
	
	FTCMaskFormatterGenericConfig *config = [FTCMaskFormatterGenericConfig new];
	config.format = @"_____";
	config.maskCharacter = '_';
	config.cutTail = YES;

	_genericTestCase.formatter = [[FTCMaskFormatter alloc] initWithConfig:config];
	
	[_genericTestCase addFormattedInputValue:@"" etalonRawOutputValue:@""];
	[_genericTestCase addFormattedInputValue:@"foo" etalonRawOutputValue:@"foo"];
	[_genericTestCase addFormattedInputValue:@"12345" etalonRawOutputValue:@"12345"];
	
	[_genericTestCase addRawInputValue:@"" etalonFormattedOutputValue:@""];
	[_genericTestCase addRawInputValue:@"foo" etalonFormattedOutputValue:@"foo"];
	[_genericTestCase addRawInputValue:@"12345" etalonFormattedOutputValue:@"12345"];

	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 0) inRawValue:@"" etalonRangeInFormattedValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(0, 3) inRawValue:@"foo" etalonRangeInFormattedValue:NSMakeRange(0, 3)];
	[_genericTestCase addRangeInRawValue:NSMakeRange(2, 1) inRawValue:@"12345" etalonRangeInFormattedValue:NSMakeRange(2, 1)];

	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 0) inFormattedValue:@"" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[_genericTestCase addRangeInFormattedValue:NSMakeRange(0, 3) inFormattedValue:@"foo" etalonRangeInRawValue:NSMakeRange(0, 3)];
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
