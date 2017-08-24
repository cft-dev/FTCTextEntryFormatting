//
// Created by Sechko Artem Sergeevich on 05/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

@protocol FTCTextEntryFormatter<NSObject>

- (NSString *)rawFromFormatted:(NSString *)formattedValue;
- (NSString *)formattedFromRaw:(NSString *)rawValue;

- (NSRange)rangeInFormattedValueForRange:(NSRange)rangeInRawValue inRawValue:(NSString *)rawValue;
- (NSRange)rangeInRawValueForRange:(NSRange)rangeInFormattedValue inFormattedValue:(NSString *)formattedValue;

@end
