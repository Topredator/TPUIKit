//
//  UITextView+TPPlaceholder.m
//  TPUIKit
//
//  Created by Topredator on 2025/2/21.
//

#import "UITextView+TPPlaceholder.h"
#import <objc/runtime.h>

@implementation UITextView (TPPlaceholder)
#define tp_text_view_place_holder            @"text_view_place_holder_key"
#define tp_text_view_place_holder_label      @"text_view_place_holder_label_key"
#define tp_text_view_place_holder_font       @"text_view_place_holder_font_key"
#define tp_text_view_place_holder_color      @"text_view_place_holder_color_key"
+(void)load{
    [super load];
    //swap selecter
    [self swapSelecter:@selector(initWithFrame:) withSelecter:@selector(initWithFrame_placeHolder:)];
    [self swapSelecter:@selector(initWithCoder:) withSelecter:@selector(initWithCoder_placeHolder:)];
    [self swapSelecter:@selector(setText:) withSelecter:@selector(setText_placeHolder:)];
    [self swapSelecter:@selector(setFrame:) withSelecter:@selector(setFrame_placeHolder:)];
    
}



- (void)textChanged_placeHolder:(NSNotification *)notification{
    if (notification.object == self) {
        if ([self placeHolderExist]) {
            if (self.text.length > 0) {
                self.tp_placeHolderLabel.alpha = 0;
            }else{
                self.tp_placeHolderLabel.alpha = 1;
            }
        }
    }
    
    
}

/**
 *  swap selecter
 *
 *  @param selecter1 selecter1
 *  @param selecter2 selecter2
 */
+(void)swapSelecter:(SEL)selecter1 withSelecter:(SEL)selecter2{
    Method systemMethod = class_getInstanceMethod(self, selecter1);
    Method swizzMethod = class_getInstanceMethod(self, selecter2);
    
    method_exchangeImplementations(systemMethod, swizzMethod);
}

-(void)placeHolderResize{
    if ([self placeHolderExist]) {
        UILabel * placeHolderLabel = self.tp_placeHolderLabel;
        UIEdgeInsets edge = self.textContainerInset;
        edge.left += self.textContainer.lineFragmentPadding;
        edge.right += self.textContainer.lineFragmentPadding;
        
        
        CGRect rect = CGRectMake(edge.left, edge.top, self.bounds.size.width - edge.left - edge.right, 100);
        
        
        NSDictionary *attributes = @{NSFontAttributeName: placeHolderLabel.font};
        
        CGSize size = [placeHolderLabel.text boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT)
                       
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                       
                                                       attributes:attributes
                       
                                                          context:nil].size;
        
        if (size.height > 0) {
            rect.size.height = MIN(size.height, self.bounds.size.height - edge.top - edge.bottom);
        }else{
            rect.size.height = self.bounds.size.height - edge.top - edge.bottom;
        }
        
        
        
        placeHolderLabel.frame = rect;
        
    }
}

#pragma mark override selecters
- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self isKindOfClass:[UITextView class]]) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged_placeHolder:) name:UITextViewTextDidChangeNotification object:self];
            
        }
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [self placeHolderResize];
}


#pragma mark swapped selecters
- (instancetype)initWithFrame_placeHolder:(CGRect)frame
{
    self = [self initWithFrame_placeHolder:frame];
    if (self) {
        if ([self isKindOfClass:[UITextView class]]) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged_placeHolder:) name:UITextViewTextDidChangeNotification object:self];
            
        }
    }
    return self;
}

-(void)setFrame_placeHolder:(CGRect)frame{
    [self setFrame_placeHolder:frame];
    [self setNeedsDisplay];
}

- (instancetype)initWithCoder_placeHolder:(NSCoder *)coder
{
    self = [self initWithCoder_placeHolder:coder];
    if (self) {
        if ([self isKindOfClass:[UITextView class]]) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged_placeHolder:) name:UITextViewTextDidChangeNotification object:self];
            
        }
    }
    return self;
}



-(void)setText_placeHolder:(NSString *)text{
    [self setText_placeHolder:text];
    
    if ([self placeHolderExist]) {
        if (text.length > 0) {
            self.tp_placeHolderLabel.alpha = 0;
        }else{
            self.tp_placeHolderLabel.alpha = 1;
        }
    }
}

-(void)setTextContainerInset_placeHolder:(UIEdgeInsets)textContainerInset{
    [self setTextContainerInset_placeHolder:textContainerInset];
    
    if ([self placeHolderExist]) {
        
        UILabel * label = self.tp_placeHolderLabel;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        
        for(NSLayoutConstraint * constraint in label.constraints){
            
            switch (constraint.firstAttribute) {
                case NSLayoutAttributeLeft:
                    constraint.constant = textContainerInset.left;
                    break;
                case NSLayoutAttributeRight:
                    constraint.constant = textContainerInset.right;
                    break;
                case NSLayoutAttributeTop:
                    constraint.constant = textContainerInset.top;
                    break;
                default:
                    break;
            }
        }
        
        label.translatesAutoresizingMaskIntoConstraints = YES;
    }
}

-(void)setFont_placeHolder:(UIFont *)font{
    [self setFont_placeHolder:font];
    if ([self placeHolderExist]) {
        //refresh placeHolderLabel font
        self.tp_placeHolderLabel.font = self.tp_placeHolderFont;
    }
}

#pragma mark getter placeHolderLabel
- (nullable UILabel *)tp_placeHolderLabel {
    UILabel * result = objc_getAssociatedObject(self, tp_text_view_place_holder_label);
    if (!result) {
        result = [[UILabel alloc] initWithFrame:(CGRect){0,0,100,100}];
        result.numberOfLines = NSIntegerMax;
        result.text = self.tp_placeHolder;
        result.font = self.tp_placeHolderFont;
        result.textColor = self.tp_placeHolderColor;
        result.userInteractionEnabled = NO;
        
        if (self.text.length > 0) {
            result.alpha = 0;
        }else{
            result.alpha = 1;
        }
        [self addSubview:result];
        
        
        
        objc_setAssociatedObject(self, tp_text_view_place_holder_label, result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self placeHolderResize];
    }
    return result;
}

-(BOOL)placeHolderExist{
    UILabel * result = objc_getAssociatedObject(self, tp_text_view_place_holder_label);
    return result;
}


#pragma mark setter/getter placeHolder
- (void)setTp_placeHolder:(NSString *)tp_placeHolder {
    NSString * _placeHolder = self.tp_placeHolder;
    if (![_placeHolder isEqualToString:tp_placeHolder]) {
        objc_setAssociatedObject(self, tp_text_view_place_holder, tp_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self placeHolderResize];
        
    }
    
    self.tp_placeHolderLabel.text = tp_placeHolder;
}

-(nullable NSString *)tp_placeHolder{
    NSString * result = objc_getAssociatedObject(self, tp_text_view_place_holder);
    return result;
}

#pragma mark setter/getter placeHolderFont
- (void)setTp_placeHolderFont:(nullable UIFont *)tp_placeHolderFont {
    UIFont * _placeHolderFont = self.tp_placeHolderFont;
    if (![_placeHolderFont isEqual:tp_placeHolderFont]) {
        objc_setAssociatedObject(self, tp_text_view_place_holder_font, tp_placeHolderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        if (!tp_placeHolderFont) {
            tp_placeHolderFont = self.font;
        }
        
        if ([self placeHolderExist]) {
            self.tp_placeHolderLabel.font = tp_placeHolderFont;
        }
    }
}

-(nullable UIFont *)tp_placeHolderFont{
    UIFont * result = objc_getAssociatedObject(self, tp_text_view_place_holder_font);
    if (!result) {
        result = self.font;
    }
    if (!result) {
        result = [UIFont systemFontOfSize:14];
    }
    return result;
}

#pragma mark setter/getter placeHolderColor
- (void)setTp_placeHolderColor:(nonnull UIColor *)tp_placeHolderColor {
    UIColor * _placeHolderColor = self.tp_placeHolderColor;
    if (![_placeHolderColor isEqual:tp_placeHolderColor]) {
        objc_setAssociatedObject(self, tp_text_view_place_holder_color, tp_placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        if ([self placeHolderExist]) {
            self.tp_placeHolderLabel.textColor = _placeHolderColor;
        }
    }
}

-(nonnull UIColor *)tp_placeHolderColor{
    UIColor * result = objc_getAssociatedObject(self, tp_text_view_place_holder_color);
    if (!result) {
        result = [UIColor lightGrayColor];
    }
    
    return result;
}

@end
