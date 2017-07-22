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

@interface FTCMaskFormatterTestCase3 : FormatterGenericTestCase
@end

@implementation FTCMaskFormatterTestCase3

- (void)setUp
{
	[super setUp];
	
	FTCMaskFormatterGenericConfig *config = [FTCMaskFormatterGenericConfig new];
	config.format = @" ___ ___";
	config.maskCharacter = '_';
	config.cutTail = NO;
	
	self.formatter = [[FTCMaskFormatter alloc] initWithConfig:config];
	
	[self addFormattedInputValue:@" ___ ___" etalonRawOutputValue:@""];
	[self addFormattedInputValue:@" foo ___" etalonRawOutputValue:@"foo"];
	[self addFormattedInputValue:@" foo 123" etalonRawOutputValue:@"foo123"];
	
	[self addRawInputValue:@"" etalonFormattedOutputValue:@" ___ ___"];
	[self addRawInputValue:@"foo" etalonFormattedOutputValue:@" foo ___"];
	[self addRawInputValue:@"foo123" etalonFormattedOutputValue:@" foo 123"];

	[self addRangeInRawValue:NSMakeRange(0, 0) inRawValue:@"" etalonRangeInFormattedValue:NSMakeRange(1, 0)];
	[self addRangeInRawValue:NSMakeRange(0, 3) inRawValue:@"foo" etalonRangeInFormattedValue:NSMakeRange(1, 4)];
	[self addRangeInRawValue:NSMakeRange(3, 3) inRawValue:@"foo123" etalonRangeInFormattedValue:NSMakeRange(4, 4)];

	[self addRangeInFormattedValue:NSMakeRange(0, 0) inFormattedValue:@" ___ ___" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[self addRangeInFormattedValue:NSMakeRange(0, 8) inFormattedValue:@" ___ ___" etalonRangeInRawValue:NSMakeRange(0, 0)];
	[self addRangeInFormattedValue:NSMakeRange(1, 3) inFormattedValue:@" foo ___" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[self addRangeInFormattedValue:NSMakeRange(0, 4) inFormattedValue:@" foo ___" etalonRangeInRawValue:NSMakeRange(0, 3)];
	[self addRangeInFormattedValue:NSMakeRange(4, 4) inFormattedValue:@" foo ___" etalonRangeInRawValue:NSMakeRange(3, 0)];
	[self addRangeInFormattedValue:NSMakeRange(0, 8) inFormattedValue:@" 123 456" etalonRangeInRawValue:NSMakeRange(0, 6)];
	[self addRangeInFormattedValue:NSMakeRange(3, 3) inFormattedValue:@" 123 456" etalonRangeInRawValue:NSMakeRange(2, 2)];
}

@end
