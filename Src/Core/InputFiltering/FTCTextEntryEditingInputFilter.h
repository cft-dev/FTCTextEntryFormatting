//
// Created by Sechko Artem Sergeevich on 06/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

@class FTCFilteredString;

NS_ASSUME_NONNULL_BEGIN

@protocol FTCTextEntryEditingInputFilter<NSObject>

- (FTCFilteredString *)replaceSubstringInString:(NSString *)originalString
                                        atRange:(NSRange)range
                                     withString:(NSString *)replacement;

@end

NS_ASSUME_NONNULL_END
