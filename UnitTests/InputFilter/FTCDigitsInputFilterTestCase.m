// Copyright (c) 2017 CFT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
