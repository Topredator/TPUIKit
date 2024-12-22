//
//  TPWaterfallLayout.h
//  TPUIKit
//
//  Created by Topredator on 2024/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// CollectionView 自定义瀑布流布局
@interface TPWaterfallLayout : UICollectionViewFlowLayout
/// collectionView 内容最小高度
@property (nonatomic, assign) CGFloat minimumContentHeight;
@end

NS_ASSUME_NONNULL_END
