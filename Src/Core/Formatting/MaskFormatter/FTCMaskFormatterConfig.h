//
// Created by Lukovnikova Ekaterina on 10/8/15.
// Copyright (c) 2015 CFT. All rights reserved.
//


@protocol FTCMaskFormatterConfig<NSObject>

@property (nonatomic, readonly) NSString *format;
@property (nonatomic, readonly) unichar maskCharacter;
@property (nonatomic, readonly) BOOL cutTail;

@end