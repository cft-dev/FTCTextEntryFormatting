//
// Created by Lukovnikova Ekaterina on 10/8/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

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
	NSString * const format = config.format;

	NSMutableString *formattedValue = [[NSMutableString alloc] initWithCapacity:format.length];

	for( NSUInteger indexInFormat = 0, indexInRawValue = 0; indexInFormat < format.length; ++indexInFormat )
	{
		if( config.cutTail && indexInRawValue == rawValue.length )
		{
			break;
		}

		if( config.maskCharacter != [format characterAtIndex:indexInFormat] || indexInRawValue >= rawValue.length )
		{
			unichar c = [format characterAtIndex:indexInFormat];
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
	assert( (rawValue.length >= rangeInRawValue.location + rangeInRawValue.length) && @"Argument 'rangeInRawValue' is out of bounds of 'rawValue'" );

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

	for( NSUInteger i = 0; i < config.format.length; ++i )
	{
		if( config.maskCharacter != [config.format characterAtIndex:i] )
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

- (NSString *)rawValueStringFromFormattedString:(NSString *const)formattedString
							   inFormattedRange:(const NSRange)range
{
	NSString * const format = config.format;

	NSMutableString *rawString = [[NSMutableString alloc] init];

	for( NSUInteger i = range.location; (i < range.location + range.length) && (i < formattedString.length); ++i )
	{
		if ( config.maskCharacter == [format characterAtIndex:i] && config.maskCharacter != [formattedString characterAtIndex:i] )
		{
			unichar c = [formattedString characterAtIndex:i];
			[rawString appendString:[FTCTextEntryFormattingStringUtils stringWithCharacter:c]];
		}
	}

	return [rawString copy];
}

- (NSUInteger)countOfRawSymbolsInFormattedString:(NSString *const)formattedString
										 inRange:(const NSRange)range
{
	NSString *rawString = [self rawValueStringFromFormattedString:formattedString
												 inFormattedRange:range];
	return rawString.length;
}

- (instancetype)init
{
	assert( false && @"Won't happen" );
	return nil;
}

@end
