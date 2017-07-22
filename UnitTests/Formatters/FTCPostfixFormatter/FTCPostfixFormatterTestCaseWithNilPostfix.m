//
//  FTCPostfixFormatterTestCaseWithNilPostfix.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import FTCTextEntryFormatting;

#import "FormatterGenericTestCase.h"

@interface FTCPostfixFormatterTestCaseWithNilPostfix : FormatterGenericTestCase
@end

@implementation FTCPostfixFormatterTestCaseWithNilPostfix

- (void)setUp
{
	[super setUp];
	
	self.formatter = [[FTCPostfixFormatter alloc] initWithPostfix:nil];
	
	[self addFormattedInputValue:@"" etalonRawOutputValue:@""];
	[self addFormattedInputValue:@"foo" etalonRawOutputValue:@"foo"];
	
	[self addRawInputValue:@"" etalonFormattedOutputValue:@""];
	[self addRawInputValue:@"foo" etalonFormattedOutputValue:@"foo"];
	
	[self addRangeInRawValue:NSMakeRange(0, 0) inRawValue:@"" etalonRangeInFormattedValue:NSMakeRange(0, 0)];
	[self addRangeInRawValue:NSMakeRange(0, 3) inRawValue:@"foo" etalonRangeInFormattedValue:NSMakeRange(0, 3)];
	[self addRangeInRawValue:NSMakeRange(2, 1) inRawValue:@"foo" etalonRangeInFormattedValue:NSMakeRange(2, 1)];
	
	[self addRangeInFormattedValue:NSMakeRange(0, 0) inFormattedValue:@"" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[self addRangeInFormattedValue:NSMakeRange(0, 3) inFormattedValue:@"foo" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[self addRangeInFormattedValue:NSMakeRange(2, 1) inFormattedValue:@"foo" etalonRangeInRawValue:NSMakeRange(2, 1)];
}

@end
