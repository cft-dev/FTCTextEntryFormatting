//
//  FTCMaskFormatterGenericConfig.h
//  GLaDOS
//
//  Created by Denis Morozov on 13/10/15.
//
//

@import XCTest;
@import FTCTextEntryFormatting;

@interface FTCMaskFormatterGenericConfig : NSObject<FTCMaskFormatterConfig>

@property (nonatomic, strong) NSString *format;
@property (nonatomic, assign) unichar maskCharacter;
@property (nonatomic, assign) BOOL cutTail;

@end
