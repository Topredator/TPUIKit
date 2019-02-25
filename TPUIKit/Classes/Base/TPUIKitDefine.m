//
//  TPUIKitDefine.m
//  TPUIKit
//
//  Created by Topredator on 2019/2/22.
//

#import "TPUIKitDefine.h"


@implementation TPUIKitDefine
+ (UIImage *)imageName:(NSString *)imageName {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}
@end
