//
//  TPUIRefreshConfig.h
//  TPUIKit
//
//  Created by Topredator on 2021/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 上拉、下滑配置信息 对象
@interface TPUIRefreshMaker : NSObject
/// 闲置状态title
@property (nonatomic, copy) NSString *headerIdleTitle;
@property (nonatomic, copy) NSString *footerIdleTitle;
/// 拉动状态title
@property (nonatomic, copy) NSString *headerPullTitle;
@property (nonatomic, copy) NSString *footerPullTitle;
/// 刷新中状态title
@property (nonatomic, copy) NSString *headerRefreshTitle;
@property (nonatomic, copy) NSString *footerRefreshTitle;
/// 将要刷新状态title
@property (nonatomic, copy) NSString *willRefreshTitle;
/// 没有更多数据状态title
@property (nonatomic, copy) NSString *noMoreTitle;
/// 图片资源地址
@property (nonatomic, copy) NSString *resoursePath;

@property (nonatomic, copy) NSArray <UIImage *> *idleImgs;
@property (nonatomic, copy) NSArray <UIImage *> *refreshImgs;
@property (nonatomic, copy) NSArray <UIImage *> *willRefreshImgs;

- (TPUIRefreshMaker *(^)(NSString *))headerIdle;
- (TPUIRefreshMaker *(^)(NSString *))footerIdle;
- (TPUIRefreshMaker *(^)(NSString *))headerPull;
- (TPUIRefreshMaker *(^)(NSString *))footerPull;
- (TPUIRefreshMaker *(^)(NSString *))headerRefresh;
- (TPUIRefreshMaker *(^)(NSString *))footerRefresh;
- (TPUIRefreshMaker *(^)(NSString *))willRefresh;
- (TPUIRefreshMaker *(^)(NSString *))noMore;
- (TPUIRefreshMaker *(^)(NSString *))sourcePath;

@end




/// 刷新配置项
@interface TPUIRefreshConfig : NSObject
@property (nonatomic, strong, readonly) TPUIRefreshMaker *refreshMaker;
+ (instancetype)config;
+ (instancetype)refreshConfig:(void (^)(TPUIRefreshMaker *make))maker;
@end

NS_ASSUME_NONNULL_END
