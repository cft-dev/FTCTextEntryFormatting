//
//  FormatterGenericTestCase.h
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import XCTest;
@import FTCTextEntryFormatting;

@interface FormatterGenericTestCase : NSObject

@property (nonatomic, strong) id<FTCTextEntryFormatter> formatter;

- (void)addFormattedInputValue:(NSString *)formattedInputValue etalonRawOutputValue:(NSString *)etalonRawOutputValue;
- (void)addRawInputValue:(NSString *)rawInputValue etalonFormattedOutputValue:(NSString *)etalonFormattedOutputValue;
- (void)addRangeInRawValue:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue etalonRangeInFormattedValue:(NSRange)etalon;
- (void)addRangeInFormattedValue:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue etalonRangeInRawValue:(NSRange)etalon;

- (void)testToRawFromFormatted;
- (void)testToFormattedFromRaw;
- (void)testGetRangeInFormattedValueFromRangeInRawValue;
- (void)testGetRangeInRawValueFromRangeInFormattedValue;

@end
