//
// Created by Denis Morozov on 08/05/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

#import "FTCMaskFormatterGenericConfig.h"

@implementation FTCMaskFormatterGenericConfig

@synthesize format = _format;

- (instancetype)init
{
	assert( false && @"Won't happen" );
	return nil;
}

- (instancetype)initWithFormat:(NSString *)format
{
	assert( nil != format );

	self = [super init];

	_format = format;
	_maskCharacter = '_';
	_cutTail = NO;

	return self;
}

@end
