//
// Created by Sechko Artem Sergeevich on 12/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@protocol FTCTextEntryNotEditingInputFilter<NSObject>

- (NSString *)filterString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
