//
//  TPLimitTextField.m
//  TPUIKit
//
//  Created by Topredator on 2024/10/15.
//

#import "TPLimitTextField.h"
@interface TPLimitTextField ()

@property (nonatomic, strong) TPLimitTextFieldProxyObject *proxyObject;

@end

@implementation TPLimitTextField

- (id)initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *) inCoder {
    self = [super initWithCoder:inCoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _proxyObject = [[TPLimitTextFieldProxyObject alloc] init];
    _proxyObject.textField = self;
    [self setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.delegate = _proxyObject;
    [self addTarget:_proxyObject action:@selector(actionTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setText:(NSString *)text {
    BOOL isAtEnd = YES;
    UITextPosition *pos = self.curCursorPosition;
    if (self.isEditing && self.curCursorPosition) {
        isAtEnd = [self comparePosition:self.curCursorPosition toPosition:self.endOfDocument] == NSOrderedSame;
    }
    [super setText:text];
    
    if (!isAtEnd && [self offsetFromPosition:pos toPosition:self.endOfDocument] > 0) {
        self.selectedTextRange = [self textRangeFromPosition:pos toPosition:pos];
    }
}

///在当前光标位置插入text
- (void)insertText:(NSString *)text
{
    text = text ? text : @"";
    UITextPosition *pos = self.selectedTextRange.start;
    BOOL isAtEnd = YES;
    if (self.isEditing && pos) {
        isAtEnd = [self comparePosition:pos toPosition:self.endOfDocument] == NSOrderedSame;
    }
    if (!isAtEnd) {
        NSInteger offset = [self offsetFromPosition:self.beginningOfDocument toPosition:pos];
        [super setText:[self.text stringByReplacingCharactersInRange:NSMakeRange(offset , 0) withString:text]];
        pos = [self positionFromPosition:pos offset:[text length]];
        self.selectedTextRange = [self textRangeFromPosition:pos toPosition:pos];
    }
    else if (self.text) {
        [super setText:[self.text stringByAppendingString:text]];
    }
    else {
        [super setText:text];
    }
    if (!_proxyObject.isTextChanging) {
        [_proxyObject actionTextDidChanged:self];
    }
}
@end

@interface TPLimitTextFieldProxyObject ()
@property (nonatomic, strong) NSString *oldText;
@property (nonatomic, strong, readonly) UITextPosition *oldCursorPosition;
@property (nonatomic, strong) NSString *oldReplacement;
@end
@implementation TPLimitTextFieldProxyObject

- (void)actionTextDidChanged:(TPLimitTextField *)textField
{
    _isTextChanging = YES;
    _textField.curCursorPosition = textField.selectedTextRange.start;

    UITextRange *markedRange = textField.markedTextRange;
    BOOL isAtEnd = [textField comparePosition:_textField.curCursorPosition toPosition:textField.endOfDocument] == NSOrderedSame;
    
    if (!markedRange) {
        if (_textField.regexpPattern) {
            NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:_textField.regexpPattern
                                                                                    options:0 error:nil];
            NSTextCheckingResult *rst = [regexp firstMatchInString:textField.text options:0 range:NSMakeRange(0, textField.text.length)];
            if (rst.range.location == NSNotFound) {
                textField.text = self.oldText;
                _textField.curCursorPosition = self.oldCursorPosition;
            }
            else {
                textField.text = [textField.text substringWithRange:rst.range];
                _textField.curCursorPosition = textField.endOfDocument;
            }
        }
        if (_textField.textChangingBlock) {
            _textField.textChangingBlock(textField, self.oldReplacement);
        }
        if (_textField.textLimit > 0 && _textField.textLimit < textField.text.length) {
            textField.text = [textField.text substringToIndex:_textField.textLimit];
            NSInteger diffOffset = [textField offsetFromPosition:_textField.curCursorPosition toPosition:textField.endOfDocument];
            if (!isAtEnd && diffOffset > 0) {
                textField.selectedTextRange = [textField textRangeFromPosition:_textField.curCursorPosition toPosition:_textField.curCursorPosition];
            }
            
            [self performSelector:@selector(_callEditingChangedActions:) withObject:textField];
        } else {
            NSInteger diffOffset = [textField offsetFromPosition:_textField.curCursorPosition toPosition:textField.endOfDocument];
            if (!isAtEnd && diffOffset > 0) {
                textField.selectedTextRange = [textField textRangeFromPosition:_textField.curCursorPosition toPosition:_textField.curCursorPosition];
            }
            if (_textField.textDidChangedBlock) {
                _textField.textDidChangedBlock(textField);
            }
        }
    }

    _isTextChanging = NO;
}

- (void)_callEditingChangedActions:(TPLimitTextField *)textfield
{
    [textfield sendActionsForControlEvents:UIControlEventEditingChanged];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_textField.didBeginEditingBlock) {
        _textField.didBeginEditingBlock(_textField);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _oldCursorPosition = nil;
    if (_textField.didEndEditingBlock) {
        _textField.didEndEditingBlock(_textField);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextPosition *cursorPos = textField.selectedTextRange.start;
    UITextRange *markedRange = textField.markedTextRange;
    _oldCursorPosition = markedRange ? markedRange.start : cursorPos;
    _oldText = textField.text;
    _oldReplacement = string;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_textField.shouldReturnKeyboard) {
        // 收回键盘
        BOOL result = [_textField resignFirstResponder];
        if (_textField.didReturnBlock) {
            _textField.didReturnBlock(_textField);
        }
        return result;
    } else {
        return NO;
    }
}

@end
