//
// Created by Denis Morozov on 08/05/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


#import "FTCMobilePhoneFormatterConfig.h"


@implementation FTCMobilePhoneFormatterConfig
{
}

@synthesize format = _format;
@synthesize cutTail = _cutTail;

- (instancetype)init
{
	assert( false && @"Won't happen" );
	return nil;
}

- (instancetype)initWithFormat:(NSString *)format
{
	assert( nil != format );

	self = [super init];

	if( nil == self )
	{
		return nil;
	}

	_format = format;
	_maskCharacter = '_';
	_cutTail = NO;

	return self;
}


@end