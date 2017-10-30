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

#import "FTCMaskFormatter.h"
#import "FTCMaskFormatterConfig.h"
#import "FTCTextEntryFormattingStringUtils.h"

@implementation FTCMaskFormatter
{
	id<FTCMaskFormatterConfig> config;
}

- (instancetype)initWithConfig:(id<FTCMaskFormatterConfig>)aConfig
{
	assert( nil != aConfig );

	self = [super init];

	config = aConfig;

	return self;
}

- (NSString *)rawFromFormatted:(NSString *)formattedValue
{
	return [self rawValueStringFromFormattedString:formattedValue
								  inFormattedRange:NSMakeRange(0, formattedValue.length)];
}

- (NSString *)formattedFromRaw:(NSString *)rawValue
{
	NSString * const mask = config.mask;

	NSMutableString *formattedValue = [[NSMutableString alloc] initWithCapacity:mask.length];

	for( NSUInteger indexInFormat = 0, indexInRawValue = 0; indexInFormat < mask.length; ++indexInFormat )
	{
		if( config.cutTail && indexInRawValue == rawValue.length )
		{
			break;
		}

		if( config.maskCharacter != [mask characterAtIndex:indexInFormat] || indexInRawValue >= rawValue.length )
		{
			unichar c = [mask characterAtIndex:indexInFormat];
			[formattedValue appendString:[FTCTextEntryFormattingStringUtils stringWithCharacter:c]];
		}
		else
		{
			unichar c = [rawValue characterAtIndex:indexInRawValue++];
			[formattedValue appendString:[FTCTextEntryFormattingStringUtils stringWithCharacter:c]];
		}
	}

	return [formattedValue copy];
}

- (NSRange)rangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue
{
	assert( (rawValue.length >= rangeInRawValue.location + rangeInRawValue.length) && "Argument 'rangeInRawValue' is out of bounds of 'rawValue'" );

	if( 0 == rangeInRawValue.location )
	{
		/*
		 * Если начало, то ставим каретку спереди первого raw-символа
		 */
		NSUInteger numberOfFirstRawSymbolInRange = 1;
		NSUInteger numberOfLastRawSymbolInRange = rangeInRawValue.length + 1;

		NSUInteger position = [self positionOfRawSymbolInFormattedValue:numberOfFirstRawSymbolInRange];
		NSUInteger positionLast = [self positionOfRawSymbolInFormattedValue:numberOfLastRawSymbolInRange];

		return NSMakeRange(position, positionLast - position);
	}
	else
	{
		/*
		 * Если не начало, то ставим каретку позади предыдущего raw-символа
		 */
		NSUInteger numberOfFirstRawSymbolInRange = rangeInRawValue.location;
		NSUInteger numberOfLastRawSymbolInRange = (rangeInRawValue.location + rangeInRawValue.length);

		NSUInteger position = [self positionOfRawSymbolInFormattedValue:numberOfFirstRawSymbolInRange] + 1;
		NSUInteger positionLast = [self positionOfRawSymbolInFormattedValue:numberOfLastRawSymbolInRange] + 1;

		return NSMakeRange(position, positionLast - position);
	}
}

- (NSRange)rangeInRawValueForRange:(NSRange)rangeInFormattedValue
                  inFormattedValue:(NSString *)formattedValue
{
	NSUInteger symbolsToLocation = [self countOfRawSymbolsInFormattedString:formattedValue
																	inRange:NSMakeRange(0, rangeInFormattedValue.location)];

	NSUInteger symbolsInRange = [self countOfRawSymbolsInFormattedString:formattedValue
																 inRange:rangeInFormattedValue];

	return NSMakeRange(symbolsToLocation, symbolsInRange);
}

- (NSUInteger)positionOfRawSymbolInFormattedValue:(const NSUInteger)rawNumber
{
	NSUInteger position = 0;

	NSUInteger currentPosition = 0;

	for( NSUInteger i = 0; i < config.mask.length; ++i )
	{
		if( config.maskCharacter != [config.mask characterAtIndex:i] )
		{
			continue;
		}

		++currentPosition;

		position = i;

		if( rawNumber == currentPosition )
		{
			break;
		}
	}

	return position;
}

- (nonnull NSString *)rawValueStringFromFormattedString:(nullable NSString *const)formattedString
                                       inFormattedRange:(const NSRange)range
{
	NSString * const mask = config.mask;

	NSMutableString *rawString = [[NSMutableString alloc] init];

	for( NSUInteger i = range.location; (i < range.location + range.length) && (i < formattedString.length); ++i )
	{
		if ( config.maskCharacter == [mask characterAtIndex:i] && config.maskCharacter != [formattedString characterAtIndex:i] )
		{
			unichar c = [formattedString characterAtIndex:i];
			[rawString appendString:[FTCTextEntryFormattingStringUtils stringWithCharacter:c]];
		}
	}

	return [rawString copy];
}

- (NSUInteger)countOfRawSymbolsInFormattedString:(nullable NSString *const)formattedString
										 inRange:(const NSRange)range
{
	NSString *rawString = [self rawValueStringFromFormattedString:formattedString
												 inFormattedRange:range];
	return rawString.length;
}

- (instancetype)init
{
	assert( false && "Won't happen" );
	return nil;
}

@end
