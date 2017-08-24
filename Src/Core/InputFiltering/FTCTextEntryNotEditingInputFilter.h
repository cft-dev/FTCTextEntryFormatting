//
// Created by Sechko Artem Sergeevich on 12/03/15.
// Copyright (c) 2015 FTC. All rights reserved.
//

@import Foundation;

@protocol FTCTextEntryNotEditingInputFilter<NSObject>

- (NSString *)filterString:(NSString *)string;

@end
