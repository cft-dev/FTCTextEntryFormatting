//
//  FormatterGenericTestCase.m
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

#import "FormatterGenericTestCase.h"

@interface Pair : NSObject

@property (nonatomic, strong, nonnull) NSString *key;
@property (nonatomic, strong, nonnull) NSString *value;

+ (instancetype)pairForKey:(nonnull NSString *)key value:(nonnull NSString *)value;

@end

@implementation Pair

+ (instancetype)pairForKey:(nonnull NSString *)key value:(nonnull NSString *)value
{
	Pair *pair = [Pair new];
	pair.key = key;
	pair.value = value;

	return pair;
}

@end

@implementation FormatterGenericTestCase
{
	NSMutableArray *formattedAndRawPairs;
	NSMutableArray *rawAndFormattedPairs;
	NSMutableArray *rawAndFormattedRanges;
	NSMutableArray *formattedAndRawRanges;
}

- (instancetype)init
{
	self = [super init];

	rawAndFormattedPairs = [NSMutableArray new];
	formattedAndRawPairs = [NSMutableArray new];
	rawAndFormattedRanges = [NSMutableArray new];
	formattedAndRawRanges = [NSMutableArray new];

	return self;
}

- (void)addFormattedInputValue:(NSString *)formattedInputValue etalonRawOutputValue:(NSString *)etalonRawOutputValue
{
	assert( nil != formattedInputValue );
	assert( nil != etalonRawOutputValue );
	
	Pair *pair = [Pair pairForKey:formattedInputValue value:etalonRawOutputValue];
	
	[formattedAndRawPairs addObject:pair];
}

- (void)addRawInputValue:(NSString *)rawInputValue etalonFormattedOutputValue:(NSString *)etalonFormattedOutputValue
{
	assert( nil != rawInputValue );
	assert( nil != etalonFormattedOutputValue );
	
	Pair *pair = [Pair pairForKey:rawInputValue value:etalonFormattedOutputValue];
	
	[rawAndFormattedPairs addObject:pair];
}

- (void)addRangeInRawValue:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue etalonRangeInFormattedValue:(NSRange)etalon
{
	[rawAndFormattedRanges addObject:@
	{
		@"rangeInRawValue" : NSStringFromRange(rangeInRawValue),
		@"rawValue" : rawValue,
		@"etalon" : NSStringFromRange(etalon),
	}];
}

- (void)addRangeInFormattedValue:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue etalonRangeInRawValue:(NSRange)etalon
{
	[formattedAndRawRanges addObject:@
	{
		@"rangeInFormattedValue" : NSStringFromRange(rangeInFormattedValue),
		@"formattedValue" : formattedValue,
		@"etalon" : NSStringFromRange(etalon),
	}];
}

- (void)testToRawFromFormatted
{
	for( Pair *pair in formattedAndRawPairs )
	{
		NSString *formattedInputValue = pair.key;
		NSString *etalonRawOutputValue = pair.value;
		
		NSString *rawOutputValue = [_formatter toRawFromFormatted:formattedInputValue];
		
		XCTAssertEqualObjects(etalonRawOutputValue, rawOutputValue, @"formattedInputValue: '%@', etalonRawOutputValue: '%@'", formattedInputValue, etalonRawOutputValue);
	}
}

- (void)testToFormattedFromRaw
{
	for( Pair *pair in rawAndFormattedPairs )
	{
		NSString *rawInputValue = pair.key;
		NSString *etalonFormattedOutputValue = pair.value;
		
		NSString *formattedOutputValue = [_formatter toFormattedFromRaw:rawInputValue];
		
		XCTAssertEqualObjects(etalonFormattedOutputValue, formattedOutputValue, @"rawInputValue: '%@', etalonFormattedOutputValue: '%@'", rawInputValue, etalonFormattedOutputValue);
	}
}

- (void)testGetRangeInFormattedValueFromRangeInRawValue
{
	for( NSDictionary *dict in rawAndFormattedRanges )
	{
		NSRange rangeInRawValue = NSRangeFromString(dict[@"rangeInRawValue"]);
		NSString *rawValue = dict[@"rawValue"];
		NSRange etalon = NSRangeFromString(dict[@"etalon"]);
		
		NSRange rangeInFormattedValue = [_formatter getRangeInFormattedValueForRange:rangeInRawValue inRawValue:rawValue];
		
		XCTAssert( NSEqualRanges(etalon, rangeInFormattedValue), @"%@ rangeInFormattedValue: '%@'", dict, NSStringFromRange(rangeInFormattedValue) );
	}
}

- (void)testGetRangeInRawValueFromRangeInFormattedValue
{
	for( NSDictionary *dict in formattedAndRawRanges )
	{
		NSRange rangeInFormattedValue = NSRangeFromString(dict[@"rangeInFormattedValue"]);
		NSString *formattedValue = dict[@"formattedValue"];
		NSRange etalon = NSRangeFromString(dict[@"etalon"]);
		
		NSRange rangeInRawValue = [_formatter getRangeInRawValueForRange:rangeInFormattedValue inFormattedValue:formattedValue];
		
		XCTAssert( NSEqualRanges(etalon, rangeInRawValue), @"%@ rangeInRawValue: '%@'", dict, NSStringFromRange(rangeInRawValue) );
	}
}


@end
