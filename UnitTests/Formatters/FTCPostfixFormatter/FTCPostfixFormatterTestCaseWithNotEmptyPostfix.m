//
//  FTCPostfixFormatterTestCaseWithNotEmptyPostfix.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import FTCTextEntryFormatting;

#import "FormatterGenericTestCase.h"

@interface FTCPostfixFormatterTestCaseWithNotEmptyPostfix : FormatterGenericTestCase
@end

@implementation FTCPostfixFormatterTestCaseWithNotEmptyPostfix

- (void)setUp
{
	[super setUp];
	
	self.formatter = [[FTCPostfixFormatter alloc] initWithPostfix:@" руб"];
	
	[self addFormattedInputValue:@" руб" etalonRawOutputValue:@""];
	[self addFormattedInputValue:@"  руб" etalonRawOutputValue:@" "];
	[self addFormattedInputValue:@"1 руб" etalonRawOutputValue:@"1"];
	
	[self addRawInputValue:@"" etalonFormattedOutputValue:@" руб"];
	[self addRawInputValue:@" " etalonFormattedOutputValue:@"  руб"];
	[self addRawInputValue:@"1" etalonFormattedOutputValue:@"1 руб"];
	[self addRawInputValue:@"1 руб" etalonFormattedOutputValue:@"1 руб руб"];
	
	[self addRangeInRawValue:NSMakeRange(0, 0) inRawValue:@"" etalonRangeInFormattedValue:NSMakeRange(0, 0)];
	[self addRangeInRawValue:NSMakeRange(0, 3) inRawValue:@"200" etalonRangeInFormattedValue:NSMakeRange(0, 3)];
	[self addRangeInRawValue:NSMakeRange(2, 1) inRawValue:@"200" etalonRangeInFormattedValue:NSMakeRange(2, 1)];
	
	[self addRangeInFormattedValue:NSMakeRange(0, 0) inFormattedValue:@"" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[self addRangeInFormattedValue:NSMakeRange(0, 3) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[self addRangeInFormattedValue:NSMakeRange(2, 1) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(2, 1)];
	[self addRangeInFormattedValue:NSMakeRange(0, 4) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[self addRangeInFormattedValue:NSMakeRange(2, 3) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(2, 1)];
	[self addRangeInFormattedValue:NSMakeRange(4, 1) inFormattedValue:@"200 руб" etalonRangeInRawValue:NSMakeRange(3, 0)];
}

@end
