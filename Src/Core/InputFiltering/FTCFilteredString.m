//
// Created by Sechko Artem Sergeevich on 06/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCFilteredString.h"

@implementation FTCFilteredString

- (instancetype)initWithString:(NSString *)string range:(NSRange)range
{
	self = [super init];

	if(nil == self)
	{
		return nil;
	}

	_string = string;
	_range = range;

	return self;
}

@end
