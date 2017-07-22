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

@interface FTCMaskFormatterTestCase2 : FormatterGenericTestCase
@end

@implementation FTCMaskFormatterTestCase2

- (void)setUp
{
	[super setUp];
	
	FTCMaskFormatterGenericConfig *config = [FTCMaskFormatterGenericConfig new];
	config.format = @"_____";
	config.maskCharacter = '_';
	config.cutTail = NO;
	
	self.formatter = [[FTCMaskFormatter alloc] initWithConfig:config];
	
	[self addFormattedInputValue:@"_____" etalonRawOutputValue:@""];
	[self addFormattedInputValue:@"foo__" etalonRawOutputValue:@"foo"];
	[self addFormattedInputValue:@"12345" etalonRawOutputValue:@"12345"];
	
	[self addRawInputValue:@"" etalonFormattedOutputValue:@"_____"];
	[self addRawInputValue:@"foo" etalonFormattedOutputValue:@"foo__"];
	[self addRawInputValue:@"12345" etalonFormattedOutputValue:@"12345"];

	[self addRangeInRawValue:NSMakeRange(0, 0) inRawValue:@"" etalonRangeInFormattedValue:NSMakeRange(0, 0)];
	[self addRangeInRawValue:NSMakeRange(0, 3) inRawValue:@"foo" etalonRangeInFormattedValue:NSMakeRange(0, 3)];
	[self addRangeInRawValue:NSMakeRange(2, 1) inRawValue:@"12345" etalonRangeInFormattedValue:NSMakeRange(2, 1)];

	[self addRangeInFormattedValue:NSMakeRange(0, 0) inFormattedValue:@"_____" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[self addRangeInFormattedValue:NSMakeRange(0, 2) inFormattedValue:@"_____" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[self addRangeInFormattedValue:NSMakeRange(1, 2) inFormattedValue:@"_____" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[self addRangeInFormattedValue:NSMakeRange(0, 3) inFormattedValue:@"foo__" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[self addRangeInFormattedValue:NSMakeRange(0, 5) inFormattedValue:@"foo__" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[self addRangeInFormattedValue:NSMakeRange(2, 1) inFormattedValue:@"12345" etalonRangeInRawValue:NSMakeRange(2, 1)];
}

@end
