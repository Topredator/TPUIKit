//
//  TPTextDisplayView.h
//  TPUIKit
//
//  Created by Topredator on 2021/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol TPTextDisplayViewDelegate <NSObject>
@optional
@end

/// 富文本 展示视图
@interface TPTextDisplayView : UIView
@property (nonatomic, weak) id <TPTextDisplayViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
