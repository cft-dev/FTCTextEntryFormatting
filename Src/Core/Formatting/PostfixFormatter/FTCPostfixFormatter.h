//
// Created by Sechko Artem Sergeevich on 25/03/15.
// Copyright (c) 2015 CFT. All rights reserved.
//


#import "FTCTextEntryFormatter.h"

@interface FTCPostfixFormatter : NSObject<FTCTextEntryFormatter>

@property (nonatomic, readonly) NSString *postfix;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithPostfix:(NSString *)postfix;

@end
