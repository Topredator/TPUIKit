//
//  UITextView+TPPlaceholder.h
//  TPUIKit
//
//  Created by Topredator on 2025/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (TPPlaceholder)
@property (nonatomic,strong,nullable) NSString *tp_placeHolder;
/**
 *  place holder Label
 */
@property (nonatomic,strong,readonly,nullable) UILabel *tp_placeHolderLabel;

/**
 *  The font of placeHolder. If null it's equal to the font of UITextView
 */
@property (nonatomic,strong,nullable)  UIFont *tp_placeHolderFont;

/**
 *  The color of placeHolder.Default is light gray. Not be null.
 */
@property (nonatomic,strong,nonnull) UIColor *tp_placeHolderColor;
@end

NS_ASSUME_NONNULL_END
