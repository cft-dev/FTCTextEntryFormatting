//
// Created by Denis Morozov on 10/05/2017.
// Copyright (c) 2017 FTC. All rights reserved.
//


#import "NSString+FTCTextEntryFormatting.h"


@implementation NSString (FTCTextEntryFormatting)

- (BOOL)textEntryFormatting_isEmpty
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0;
}

@end