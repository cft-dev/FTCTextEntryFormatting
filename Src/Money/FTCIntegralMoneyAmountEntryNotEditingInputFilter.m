//
// Created by Sechko Artem Sergeevich on 29/07/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCIntegralMoneyAmountEntryNotEditingInputFilter.h"
#import "FTCMoneyEntryFormatUtils.h"

@implementation FTCIntegralMoneyAmountEntryNotEditingInputFilter

- (instancetype)init
{
	self = [super init];

	return self;
}

- (NSString *)filterString:(NSString *)string
{
	assert( nil != string );

	if( 0 == string.length )
	{
		return [FTCMoneyEntryFormatUtils emptyString];
	}

	string = [FTCMoneyEntryFormatUtils removeFractionalPartFromString:string];
	string = [FTCMoneyEntryFormatUtils trimZeroHeadFromString:string];
	string = [FTCMoneyEntryFormatUtils removeNonMoneyEntryCharactersFromString:string];

	return string;
}

- (BOOL)isEqual:(id)object
{
	return ( (self == object) || [object isMemberOfClass:self.class] );
}

@end
