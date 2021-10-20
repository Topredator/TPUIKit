//
//  TPBannerVC.m
//  TPUIKit_Example
//
//  Created by Topredator on 2021/10/20.
//  Copyright © 2021 Topredator. All rights reserved.
//

#import "TPBannerVC.h"
#import "TPBannerPage.h"
@interface TPBannerVC () <TPUIBannerViewDelegate>
@property (nonatomic, strong) TPUIBannerView *banner;
@property (nonatomic, strong) TPUIBannerView *vBanner;
@property (nonatomic, copy) NSArray *titles;
@end

@implementation TPBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Banner";
    self.titles = @[
        @"test data 1",
        @"test data 2",
        @"test data 3"
    ];
    [self setupSubviews];
    [self.banner reloadData];
    [self.banner startTimerWithTimeInterval:4];
    
    [self.vBanner reloadData];
    [self.vBanner startTimerWithTimeInterval:4];
}
- (void)setupSubviews {
    [self.view addSubview:self.banner];
    [self.banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(200);
    }];
    
    [self.view addSubview:self.vBanner];
    [self.vBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.banner.mas_bottom).offset(100);
        make.height.mas_equalTo(50);
    }];
}
#pragma mark ------------------------  TPUIBannerViewDelegate  ---------------------------
- (NSInteger)numberOfPagesForBannerView:(TPUIBannerView *)bannerView {
    return self.titles.count;
}
- (TPUIBannerPageView *)bannerView:(TPUIBannerView *)banner viewForPageIndex:(NSInteger)pageIndex {
    if (banner == self.banner) {
        TPBannerPage *page = [banner dequeueReusablePageWithIdentifier:@"page"];
        if (!page) {
            page = [[TPBannerPage alloc] initWithReuseIdentifier:@"page"];
        }
        page.backgroundColor = [TPUI tp_randomColor];
        [page configText:self.titles[pageIndex]];
        return page;
    } else {
        TPBannerPage *page = [banner dequeueReusablePageWithIdentifier:@"vPage"];
        if (!page) {
            page = [[TPBannerPage alloc] initWithReuseIdentifier:@"vPage"];
        }
        page.backgroundColor = [TPUI tp_randomColor];
        [page configText:self.titles[pageIndex]];
        return page;
    }
}
#pragma mark ------------------------  lazy method  ---------------------------
- (TPUIBannerView *)banner {
    if (!_banner) {
        _banner = [[TPUIBannerView alloc] initWithFrame:CGRectZero];
        _banner.delegate = self;
        _banner.isCarousel = YES;
    }
    return _banner;
}

- (TPUIBannerView *)vBanner {
    if (!_vBanner) {
        _vBanner = [[TPUIBannerView alloc] initWithFrame:CGRectZero];
        _vBanner.delegate = self;
        _vBanner.isCarousel = YES;
        _vBanner.scrollDirection = TPUIBannerDirectionVertical;
    }
    return _vBanner;
}
@end
