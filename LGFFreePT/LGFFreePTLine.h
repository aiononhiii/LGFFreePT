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
@protocol LGFFreePTLineDelegate <NSObject>
@optional
#pragma mark - 加载 line 网络图片代理，具体加载框架我的 Demo 不做约束，请自己选择图片加载框架，使用前请打开 lgf_IsNetImage
/**
 @param imageView 要加载网络图片的 imageView
 @param imageUrl 网络图片的 Url
 */
- (void)lgf_GetLineNetImage:(UIImageView *)imageView imageUrl:(NSURL *)imageUrl;
#pragma mark - 实现这个代理来对 LGFFreePTLine 生成时某些系统属性进行配置 backgroundColor/borderColor/CornerRadius等等
/**
 @param lgf_FreePTLine LGFFreePTLine 本体
 @param style LGFFreePTStyle
 */
- (void)lgf_GetLine:(UIImageView *)lgf_FreePTLine style:(LGFFreePTStyle *)style;
@end
@interface LGFFreePTLine : UIImageView
@property (strong, nonatomic) LGFFreePTStyle *lgf_Style;// 配置用模型
@property (weak, nonatomic) id<LGFFreePTLineDelegate>lgf_FreePTLineDelegate;

#pragma mark - 初始化
+ (instancetype)lgf;

#pragma mark - 标底部滚动条配置
- (void)lgf_AllocLine:(LGFFreePTStyle *)style delegate:(id<LGFFreePTLineDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
