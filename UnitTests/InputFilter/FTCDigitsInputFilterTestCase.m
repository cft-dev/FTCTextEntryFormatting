//
//  FTCDigitsInputFilterTestCase.m
//  FTCTextEntryFormatting
//
//  Created by Бабинцев Павел on 05.09.17.
//  Copyright © 2017 FTC. All rights reserved.
//

@import XCTest;
@import FTCTextEntryFormatting;

static const NSUInteger MAX_LENGTH = 5;

@interface FTCDigitsInputFilterTestCase : XCTestCase
@end

@implementation FTCDigitsInputFilterTestCase
{
    FTCDigitsValueFilter *filter;
}

- (void)setUp
{
    [super setUp];
   
    filter = [[FTCDigitsValueFilter alloc] initWithMaxLength:MAX_LENGTH];
}

- (void)test_filter_should_trim_empty_string
{
    NSString *string = @"";
    NSString *filteredString = [filter filterString:string];
    XCTAssertEqual(filteredString.length, 0);
}

- (void)test_filter_trim_string_case
{
    NSString *string = @"123456";
    NSString *filteredString = [filter filterString:string];
    XCTAssertEqual(filteredString.length, MAX_LENGTH);
}

- (void)test_filter_empty_string
{
    NSString *string = @"";
    NSString *filteredString = [filter filterString:string];
    
    XCTAssertEqualObjects(string, filteredString);
}

- (void)test_filter_non_empty_digits_only_string
{
    NSString *string = @"233223";
    NSString *etalon = @"23322";
    NSString *filteredString = [filter filterString:string];
    
    XCTAssertEqualObjects(etalon, filteredString);
}

- (void)test_filter_non_empty_string
{
    NSString *string = @"asdsdf33223dd";
    NSString *etalon = @"33223";
    NSString *filteredString = [filter filterString:string];
    
    XCTAssertEqualObjects(etalon, filteredString);
    XCTAssertEqual(filteredString.length, MAX_LENGTH);
}

- (void)test_filter_digits_string_with_comma_delemiter
{
    NSString *string = @"332,23";
    NSString *etalon = @"33223";
    NSString *filteredString = [filter filterString:string];
    
    XCTAssertEqualObjects(etalon, filteredString);
    XCTAssertEqual(filteredString.length, MAX_LENGTH);
}

@end
