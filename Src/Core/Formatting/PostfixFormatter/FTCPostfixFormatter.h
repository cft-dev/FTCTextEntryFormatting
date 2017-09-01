//
// Created by Sechko Artem Sergeevich on 25/03/15.
// Copyright (c) 2015 CFT. All rights reserved.
//

#import "FTCTextEntryFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTCPostfixFormatter : NSObject<FTCTextEntryFormatter>

@property (nonatomic, nullable, readonly) NSString *postfix;

- (instancetype)initWithPostfix:(nullable NSString *)postfix;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
