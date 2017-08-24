//
//  FormattingCoordinatorTestCase.m
//  GLaDOS
//
//  Created by Denis Morozov on 14/10/15.
//
//

@import XCTest;
@import FTCTextEntryFormatting;

@interface FormattingCoordinatorTestCase : XCTestCase
@end

@implementation FormattingCoordinatorTestCase
{
	FTCTextEntryFormatCoordinator *coordinator;
}

- (void)setUp
{
	[super setUp];

	coordinator = [[FTCTextEntryFormatCoordinator alloc] init];
}

- (void)tearDown
{
	[super tearDown];
}

- (void)testSetNilRawValue
{
	coordinator.rawValue = nil;
	
	XCTAssert( nil == coordinator.rawValue );
}

- (void)testSetEmptyRawValue
{
	[self checkRawValueAfterSetRawValue:@""];
}

- (void)testSetNotEmptyRawValue
{
	[self checkRawValueAfterSetRawValue:@"value"];
}

- (void)testFormattedValueForNilRawValue
{
	[self checkFormattedValue:@"" afterSetRawValue:nil];
}

- (void)testEmptyFormattedValue
{
	[self checkFormattedValue:@"" afterSetRawValue:@""];
}

- (void)testNotEmptyFormattedValue
{
	[self checkFormattedValue:@"value" afterSetRawValue:@"value"];
}

- (void)testAppendDataToNilRawValue
{
	NSString *replacement = @"value";
	NSString *etalonRawValue = @"value";
	
	coordinator.rawValue = nil;
	
	[coordinator beginEditing];
	
	[coordinator userReplacedInFormattedValueSubstringAtRange:NSMakeRange(0, 0) withString:replacement];
	
	[coordinator endEditing];
	
	XCTAssertEqualObjects(etalonRawValue, coordinator.rawValue);
}

- (void)testInsertToRawValue
{
	[self checkRawValue:@"1value2"
	  replaceInRawValue:@"12"
	            atRange:NSMakeRange(1, 0)
	    withReplacement:@"value"];
}

- (void)testReplaceInRawValue
{
	[self checkRawValue:@"1aaaa2"
	  replaceInRawValue:@"1value2"
	            atRange:NSMakeRange(1, 5)
	    withReplacement:@"aaaa"];
}

- (void)testRemoveInRawValue
{
	[self checkRawValue:@"12"
	  replaceInRawValue:@"1value2"
	            atRange:NSMakeRange(1, 5)
	    withReplacement:@""];
}

- (void)testInsertToFormateedValue
{
	[self checkFormattedValue:@"1value2"
	        replaceInRawValue:@"12"
	                  atRange:NSMakeRange(1, 0)
	          withReplacement:@"value"];
}

- (void)testReplaceInFormattedValue
{
	[self checkFormattedValue:@"1aaaa2"
	        replaceInRawValue:@"1value2"
	                  atRange:NSMakeRange(1, 5)
	          withReplacement:@"aaaa"];
}

- (void)testRemoveInFormattedValue
{
	[self checkFormattedValue:@"12"
	        replaceInRawValue:@"1value2"
	                  atRange:NSMakeRange(1, 5)
	          withReplacement:@""];
}

- (void)testSelection
{
	NSString *rawValue = @"1value2";
	NSRange range = NSMakeRange(1, 5);
	NSString *replacement = @"aaaa";
	NSRange etalonSelection = NSMakeRange(5, 0);
	
	[self doRaplaceInRawValue:rawValue atRange:range withReplacement:replacement];
	
	XCTAssert( NSEqualRanges(etalonSelection, coordinator.currentSelectionRangeInFormattedValue) );
}

- (void)checkRawValueAfterSetRawValue:(NSString *)rawValue
{
	coordinator.rawValue = rawValue;
	
	XCTAssertEqualObjects(rawValue, coordinator.rawValue);
}

- (void)checkFormattedValue:(NSString *)etalonFormattedValue afterSetRawValue:(NSString *)rawValue
{
	coordinator.rawValue = rawValue;
	
	XCTAssertEqualObjects(etalonFormattedValue, coordinator.formattedValue);
}

- (void)checkRawValue:(NSString *)etalonRawValue
    replaceInRawValue:(NSString *)rawValue
              atRange:(NSRange)range
      withReplacement:(NSString *)replacement
{
	[self doRaplaceInRawValue:rawValue atRange:range withReplacement:replacement];
	
	XCTAssertEqualObjects(etalonRawValue, coordinator.rawValue,
	                      @"\n resultRawValue: '%@'\n etalonRawValue: '%@'\n rawValue: '%@'\n range: '%@'\n replacement: '%@'",
	                      coordinator.rawValue, etalonRawValue, rawValue, NSStringFromRange(range), replacement);
}

- (void)checkFormattedValue:(NSString *)etalonFormattedValue
          replaceInRawValue:(NSString *)rawValue
                    atRange:(NSRange)range
            withReplacement:(NSString *)replacement
{
	[self doRaplaceInRawValue:rawValue atRange:range withReplacement:replacement];
	
	XCTAssertEqualObjects(etalonFormattedValue, coordinator.formattedValue,
	                      @"\n formattedValue: '%@'\n etalonFormattedValue: '%@'\n rawValue: '%@'\n range: '%@'\n replacement: '%@'",
	                      coordinator.formattedValue, etalonFormattedValue, rawValue, NSStringFromRange(range), replacement);
}

- (void)doRaplaceInRawValue:(NSString *)rawValue atRange:(NSRange)range withReplacement:(NSString *)replacement
{
	coordinator.rawValue = rawValue;
	
	[coordinator beginEditing];
	
	[coordinator userReplacedInFormattedValueSubstringAtRange:range withString:replacement];
	
	[coordinator endEditing];
}

@end
