// Copyright (c) 2017 CFT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

@import UIKit;

@class FTCTextEntryFormattingConfig;

NS_ASSUME_NONNULL_BEGIN

@interface FTCTextFieldFormatCoordinator : NSObject

@property (nonatomic, weak) id<UITextFieldDelegate> textFieldDelegate;

@property (nonatomic, nullable, copy) void (^didChangeValueHandler)();
@property (nonatomic, nullable, copy) NSString *rawValue;
@property (nonatomic, readonly) NSString *formattedValue;

/*!
 * Устанавливает delegate у textField. Используйте поле textFieldDelegate если необходим delegate.
 * Если textField уже имеет delegate, то он будет установлен в поле textFieldDelegate.
 **/
- (instancetype)initWithTextField:(UITextField *)textField;

- (void)applyFormattingConfig:(FTCTextEntryFormattingConfig *)config NS_SWIFT_NAME( apply(formattingConfig:) );

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
