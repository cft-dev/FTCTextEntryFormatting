//
//  FTCTextInputFilter.m
//  FTCTextEntryFormatting
//
//  Created by Бабинцев Павел on 04.09.17.
//  Copyright © 2017 FTC. All rights reserved.
//

@import XCTest;
@import FTCTextEntryFormatting;


@interface FTCDigitsInputFilterTestCaseWithZeroMaxLength : XCTestCase
@end

@implementation FTCDigitsInputFilterTestCaseWithZeroMaxLength
{
    FTCDigitsValueFilter *filter;
}

- (void)setUp
{
    [super setUp];
    
    filter = [[FTCDigitsValueFilter alloc] initWithMaxLength:0];
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
    NSString *filteredString = [filter filterString:string];
    
    XCTAssertEqualObjects(string, filteredString);
}

- (void)test_filter_non_empty_string
{
    NSString *string = @"asdsdf33223dd";
    NSString *etalon = @"33223";
    NSString *filteredString = [filter filterString:string];

    XCTAssertEqualObjects(etalon, filteredString);
}

- (void)test_filter_digits_string_with_comma_delemiter
{
    NSString *string = @"332,23";
    NSString *etalon = @"33223";
    NSString *filteredString = [filter filterString:string];
    
    XCTAssertEqualObjects(etalon, filteredString);
}

@end
