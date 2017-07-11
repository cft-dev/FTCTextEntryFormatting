//
// Created by Denis Morozov on 11/07/2017.
//

#import <Foundation/Foundation.h>

@class FTCTextEntryFormattingConfig;

NS_ASSUME_NONNULL_BEGIN

@interface FTCTextFieldFormatCoordinator : NSObject

@property (nonatomic, weak) id<UITextFieldDelegate> textFieldDelegate;

@property (nonatomic, nullable, copy) void (^didChangeValueHandler)();
@property (nonatomic, nullable, copy) NSString *rawValue;
@property (nonatomic, nullable, readonly) NSString *formattedValue;

/*!
 * Устанавливает delegate у textField. Используйте поле textFieldDelegate если необходим delegate.
 * Если textField уже имеет delegate, то он будет установлен в поле textFieldDelegate.
 **/
- (instancetype)initWithTextField:(UITextField *)textField;

- (void)applyFormattingConfig:(FTCTextEntryFormattingConfig *)config NS_SWIFT_NAME( apply(formattingConfig:) );

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
