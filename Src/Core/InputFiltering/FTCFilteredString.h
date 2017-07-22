//
// Created by Sechko Artem Sergeevich on 06/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

@import Foundation;

@interface FTCFilteredString : NSObject

@property (nonatomic, readonly) NSString *string;
@property (nonatomic, readonly) NSRange range;

- (instancetype)initWithString:(NSString *)string range:(NSRange)range;

@end
