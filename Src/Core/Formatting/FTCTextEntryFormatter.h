//
// Created by Sechko Artem Sergeevich on 05/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//


@protocol FTCTextEntryFormatter<NSObject>

- (NSString *)toRawFromFormatted:(NSString *)formattedValue;
- (NSString *)toFormattedFromRaw:(NSString *)rawValue;

- (NSRange)getRangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue;
- (NSRange)getRangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue;

@end
