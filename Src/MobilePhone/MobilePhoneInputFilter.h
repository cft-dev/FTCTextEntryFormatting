//
// Created by Дирша Андрей Александрович on 09.11.16.
// Copyright (c) 2016 FTC. All rights reserved.
//



#import "FTCTextEntryEditingInputFilter.h"
#import "FTCTextEntryNotEditingInputFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MobilePhoneInputFilter : NSObject<FTCTextEntryEditingInputFilter, FTCTextEntryNotEditingInputFilter>

@property (nonatomic, readonly) NSUInteger maxLength;

- (instancetype)initWithMaxLength:(NSUInteger)length;//set '0' for infinite length

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
