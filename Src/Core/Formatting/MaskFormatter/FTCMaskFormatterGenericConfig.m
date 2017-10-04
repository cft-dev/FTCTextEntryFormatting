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

#import "FTCMaskFormatterGenericConfig.h"

@implementation FTCMaskFormatterGenericConfig

@synthesize mask = _mask;
@synthesize maskCharacter = _maskCharacter;
@synthesize countMaskCharacters = _countMaskCharacters;

- (instancetype)initWithMask:(NSString *)mask maskCharacter:(NSString *)maskCharacter
{
	assert( nil != mask );
	assert( maskCharacter.length == 1 );

	self = [super init];

	_mask = mask;
	_maskCharacter = [maskCharacter characterAtIndex:0];
	_cutTail = NO;

	NSUInteger countMaskCharacters = 0;
	for( NSUInteger i = 0; i < _mask.length; ++i )
	{
		if( [_mask characterAtIndex:i] == _maskCharacter )
		{
			++countMaskCharacters;
		}
	}

	_countMaskCharacters = countMaskCharacters;

	return self;
}

- (instancetype)init
{
	assert( false && @"Won't happen" );
	return nil;
}

@end
