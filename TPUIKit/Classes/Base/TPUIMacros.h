//
//  TPUIMacros.h
//  TPUIKit
//
//  Created by Topredator on 2020/8/19.
//

#ifndef TPUIMacros_h
#define TPUIMacros_h

#define TPUIRGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define TPUIRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define TPUIT(t) [UIColor colorWithRed:(t)/255.0f green:(t)/255.0f blue:(t)/255.0f alpha:1]
#define TPUIT(t, a) [UIColor colorWithRed:(t)/255.0f green:(t)/255.0f blue:(t)/255.0f alpha:(a)]


#define TPUIHEXColor(v) TPUIRGB((v & 0xFF0000) >> 16, (v & 0xFF00) >> 8, (v & 0xFF))
///hex alpha
#define TPUIHEXColorAlpha(v,a) TPUIRGBA((v & 0xFF0000) >> 16, (v & 0xFF00) >> 8, (v & 0xFF),a)
/// 随机色
#define TPUIRandomColor TPUIRGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))


#endif /* TPUIMacros_h */
