//
//  LGFFreePTView.h
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFFreePTStyle.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LGFFreePTDelegate <NSObject>
- (void)lgf_SelectFreePTTitle:(NSInteger)selectIndex;// 返回选中的标
@end
@interface LGFFreePTView : UIScrollView
@property (weak, nonatomic) id<LGFFreePTDelegate>lgf_FreePTDelegate;
@property (strong, nonatomic) LGFFreePTStyle *lgf_Style;// 配置用模型
#pragma mark - 初始化
+ (instancetype)lgf;
#pragma mark - 刷新所有标
/**
 @param isExecution 是否走点击代理
 @param selectIndex 需要默认选中的下标
 */
- (void)lgf_ReloadTitleAndExecutionDelegate:(BOOL)isExecution selectIndex:(NSInteger)selectIndex;
- (void)lgf_ReloadTitleAndExecutionDelegate:(BOOL)isExecution;
- (void)lgf_ReloadTitleAndSelectIndex:(NSInteger)selectIndex;
- (void)lgf_ReloadTitle;
#pragma mark - 选中某个下标
/**
 @param index 要选中的下标
 @param duration 选中动画的时间
 */
- (void)lgf_SelectIndex:(NSInteger)index duration:(CGFloat)duration;
#pragma mark - 初始化配置
/**
 @param style 配置用模型
 @param SVC 父控制器
 @param SV 父控件
 @param PV 外部分页控件
 @return LGFFreePT
 */
- (instancetype)lgf_InitWithStyle:(LGFFreePTStyle *)style SVC:(UIViewController *)SVC SV:(UIView *)SV PV:(nullable UICollectionView *)PV;
@end

NS_ASSUME_NONNULL_END
