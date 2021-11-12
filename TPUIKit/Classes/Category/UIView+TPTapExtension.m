//
//  UIView+TPTapExtension.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/28.
//

#import "UIView+TPTapExtension.h"
#import <objc/runtime.h>

static char kTPUIViewTapKey;

@interface UIView (TPTapExtension)
@property (nonatomic, copy) void (^tapAction) (UIView *);
@end

@implementation UIView (TPTapExtension)
- (void)tp_addTapBlock:(void (^)(UIView *view))tapBlock {
    self.tapAction = tapBlock;
    if (!self.gestureRecognizers) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tapGR];
    }
}
- (void)tap {
    if (self.tapAction) self.tapAction(self);
}

- (void)setTapAction:(void (^)(UIView *))tapAction {
    objc_setAssociatedObject(self, &kTPUIViewTapKey, tapAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIView *))tapAction {
    return objc_getAssociatedObject(self, &kTPUIViewTapKey);
}
@end
