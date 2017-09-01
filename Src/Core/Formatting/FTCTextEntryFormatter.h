//
// Created by Sechko Artem Sergeevich on 05/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@protocol FTCTextEntryFormatter<NSObject>

- (NSString *)rawFromFormatted:(nullable NSString *)formattedValue;
- (NSString *)formattedFromRaw:(nullable NSString *)rawValue;

- (NSRange)rangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(nullable NSString *)rawValue;
- (NSRange)rangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(nullable NSString *)formattedValue;

@end

NS_ASSUME_NONNULL_END
