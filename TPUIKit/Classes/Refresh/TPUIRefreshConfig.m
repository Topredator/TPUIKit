//
//  TPUIRefreshConfig.m
//  TPUIKit
//
//  Created by Topredator on 2021/11/17.
//

#import "TPUIRefreshConfig.h"
#import "TPUI.h"

static NSString *TPUIRefreshBundleName = @"TPUIKitRefresh";
@implementation TPUIRefreshMaker
- (instancetype)init {
    self = [super init];
    if (self) {
        self.headerIdleTitle = @"刷新成功";
        self.footerIdleTitle = @"上拉加载";
        self.headerPullTitle = @"松开进行刷新";
        self.footerPullTitle = @"松开加载";
        self.headerRefreshTitle = @"正在刷新";
        self.footerRefreshTitle = @"加载中...";
        self.willRefreshTitle = @"即将刷新";
        self.noMoreTitle = @"已经到底了哦";
    }
    return self;
}

- (NSArray<UIImage *> *)idleImgs {
    if (!self.resoursePath.length) {
        return @[[TPUI tp_imageName:@"loading1_00049" bundleName:TPUIRefreshBundleName]];
    }
    NSString *imagePath = [self.resoursePath stringByAppendingPathComponent:@"/refresh"];
    NSArray *imageNames = [TPUIRefreshMaker fetchFileListWithPath:imagePath];
    if (!imageNames.count) return nil;
    // 图片统一命名规则 refresh_loading01@2x.png
    NSString *fileName = imageNames[0];
    if (![fileName containsString:@"refresh_loading"]) {
        @throw [NSException exceptionWithName:@"file name error" reason:@"自定义下拉图片命名不符合规则" userInfo:nil];
    }
    UIImage *idleImage = [UIImage imageWithContentsOfFile:[imagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"refresh_loading%02ld@2x.png", imageNames.count]]];
    return @[idleImage];
}
- (NSArray<UIImage *> *)refreshImgs {
    if (!self.resoursePath.length) {
        NSMutableArray *refreshingingImages = [NSMutableArray array];
        for (NSUInteger i = 0; i<=49; i++) {
            UIImage *image = [TPUI tp_imageName:[NSString stringWithFormat:@"loading1_000%02ld", i]
                    bundleName:TPUIRefreshBundleName];
            [refreshingingImages addObject:image];
        }
        return refreshingingImages.copy;
    }
    NSString *imagePath = [self.resoursePath stringByAppendingPathComponent:@"/refresh"];
    NSArray *imageNames = [TPUIRefreshMaker fetchFileListWithPath:imagePath];
    if (!imageNames.count) return nil;
    // 图片统一命名规则 refresh_loading01@2x.png
    NSString *fileName = imageNames[0];
    if (![fileName containsString:@"refresh_loading"]) {
        @throw [NSException exceptionWithName:@"file name error" reason:@"自定义下拉图片命名不符合规则" userInfo:nil];
    }
    NSMutableArray *refreshImages = @[].mutableCopy;
    for (NSUInteger i = 1; i <= imageNames.count - 1; i++) {
        UIImage *refreshImage = [UIImage imageWithContentsOfFile:[imagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"refresh_loading%02ld@2x.png", i]]];
        [refreshImages addObject:refreshImage];
    }
    return refreshImages.copy;
}
- (NSArray<UIImage *> *)willRefreshImgs {
    if (!self.resoursePath.length) {
        return @[[TPUI tp_imageName:@"loading1_00000" bundleName:TPUIRefreshBundleName]];
    }
    NSString *imagePath = [self.resoursePath stringByAppendingPathComponent:@"/refresh"];
    NSArray *imageNames = [TPUIRefreshMaker fetchFileListWithPath:imagePath];
    if (!imageNames.count) return nil;
    // 图片统一命名规则 refresh_loading01@2x.png
    NSString *fileName = imageNames[0];
    if (![fileName containsString:@"refresh_loading"]) {
        @throw [NSException exceptionWithName:@"file name error" reason:@"自定义下拉图片命名不符合规则" userInfo:nil];
    }
    UIImage *willImage = [UIImage imageWithContentsOfFile:[imagePath stringByAppendingPathComponent:@"refresh_loading01@2x.png"]];
    return @[willImage];
}
- (TPUIRefreshMaker *(^)(NSString *))headerIdle {
    return ^ TPUIRefreshMaker *(NSString *str) {
        self.headerIdleTitle = str;
        return self;
    };
}
- (TPUIRefreshMaker *(^)(NSString *))footerIdle {
    return ^ TPUIRefreshMaker *(NSString *str) {
        self.footerIdleTitle = str;
        return self;
    };
}
- (TPUIRefreshMaker *(^)(NSString *))headerPull {
    return ^ TPUIRefreshMaker *(NSString *str) {
        self.headerPullTitle = str;
        return self;
    };
}
- (TPUIRefreshMaker *(^)(NSString *))footerPull {
    return ^ TPUIRefreshMaker *(NSString *str) {
        self.footerPullTitle = str;
        return self;
    };
}
- (TPUIRefreshMaker *(^)(NSString *))headerRefresh {
    return ^ TPUIRefreshMaker *(NSString *str) {
        self.headerRefreshTitle = str;
        return self;
    };
}
- (TPUIRefreshMaker *(^)(NSString *))footerRefresh {
    return ^ TPUIRefreshMaker *(NSString *str) {
        self.footerRefreshTitle = str;
        return self;
    };
}
- (TPUIRefreshMaker *(^)(NSString *))willRefresh {
    return ^ TPUIRefreshMaker *(NSString *str) {
        self.willRefreshTitle = str;
        return self;
    };
}
- (TPUIRefreshMaker *(^)(NSString *))noMore {
    return ^ TPUIRefreshMaker *(NSString *str) {
        self.noMoreTitle = str;
        return self;
    };
}
- (TPUIRefreshMaker *(^)(NSString *))sourcePath {
    return ^ TPUIRefreshMaker *(NSString *str) {
        self.resoursePath = str;
        return self;
    };
}
+ (NSArray <NSString *>*)fetchFileListWithPath:(NSString *)path {
    if (!path.length) return nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:path error:&error];
    if (error) {
        NSLog(@"getFileList Failed:%@",[error localizedDescription]);
    }
    return fileList;
}

@end

@interface TPUIRefreshConfig ()
@property (nonatomic, strong) TPUIRefreshMaker *refreshMaker;
@end

@implementation TPUIRefreshConfig
+ (instancetype)config {
    static TPUIRefreshConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [TPUIRefreshConfig new];
    });
    return config;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.refreshMaker = [TPUIRefreshMaker new];
    }
    return self;
}
+ (instancetype)refreshConfig:(void (^)(TPUIRefreshMaker *make))maker {
    TPUIRefreshConfig *config = [TPUIRefreshConfig config];
    if (maker) maker(config.refreshMaker);
    return config;
}
@end
