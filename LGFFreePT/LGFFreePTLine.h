//
//  LGFFreePTLine.h
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFFreePTStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGFFreePTLine : UIImageView
@property (strong, nonatomic) LGFFreePTStyle *lgf_Style;// 配置用模型
+ (instancetype)lgf_AllocLine:(LGFFreePTStyle *)style;// 标底部滚动条初始化
@end

NS_ASSUME_NONNULL_END
