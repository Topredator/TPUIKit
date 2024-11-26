//
//  TPLimitTextField.h
//  TPUIKit
//
//  Created by Topredator on 2024/10/15.
//

#import <UIKit/UIKit.h>

@class TPLimitTextFieldProxyObject;

@interface TPLimitTextField : UITextField
/// 当前光标位置
@property (nonatomic, strong) UITextPosition *curCursorPosition;
/// `YES`：按return时收回键盘
@property (nonatomic, assign) BOOL shouldReturnKeyboard UI_APPEARANCE_SELECTOR;
/// 限制字数
@property (nonatomic, assign) NSInteger textLimit;
/// 正则过滤
@property (nonatomic, strong) NSString *regexpPattern;
/// 开始编辑
@property (nonatomic, copy) void (^didBeginEditingBlock)(TPLimitTextField *textField);
/// 结束编辑
@property (nonatomic, copy) void (^didEndEditingBlock)(TPLimitTextField *textField);
@property (nonatomic, copy) void (^textChangingBlock)(TPLimitTextField *textField, NSString *replacement);
@property (nonatomic, copy) void (^textDidChangedBlock)(TPLimitTextField *textField);
@property (nonatomic, copy) BOOL (^shouldChangeBlock)(TPLimitTextField *field, NSRange range, NSString *replaceStr);
@property (nonatomic, copy) void (^didReturnBlock)(TPLimitTextField *field);

///在当前光标位置插入text
- (void)insertText:(NSString *)text;
@end

@interface TPLimitTextFieldProxyObject : NSObject<UITextFieldDelegate>
@property (nonatomic, weak) TPLimitTextField *textField;
@property (nonatomic, assign, readonly) BOOL isTextChanging;

- (void)actionTextDidChanged:(TPLimitTextField *)textField;
@end

