//
//  LGFFreePTView.h
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFFreePTStyle.h"
#import "LGFFreePTLine.h"
#import "LGFFreePTTitle.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LGFFreePTDelegate <NSObject>
@required
- (void)lgf_SelectFreePTTitle:(NSInteger)selectIndex;// 返回选中的标
@optional
// 自定义 line 动画
- (void)lgf_FreePTViewCustomizeLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle line:(LGFFreePTLine *)line progress:(CGFloat)progress;
@end
@interface LGFFreePTView : UIScrollView
@property (weak, nonatomic) id<LGFFreePTDelegate>lgf_FreePTDelegate;
@property (strong, nonatomic) LGFFreePTStyle *lgf_Style;// 配置用模型
@property (assign, nonatomic) NSInteger lgf_SelectIndex;// 将要选中下标
#pragma mark - 初始化
+ (instancetype)lgf;
#pragma mark - 刷新所有标
/**
 @param isExecutionDelegate 是否执行点击代理
 @param isReloadPageCV 是否刷新外部子控制器分页容器（CV）
 @param selectIndex 需要默认选中的下标
 @param animated 默认选中的下标是否需要动画
 */
- (void)lgf_ReloadTitleAndSelectIndex:(NSInteger)selectIndex isExecutionDelegate:(BOOL)isExecutionDelegate isReloadPageCV:(BOOL)isReloadPageCV animated:(BOOL)animated;
- (void)lgf_ReloadTitleAndSelectIndex:(NSInteger)selectIndex isExecutionDelegate:(BOOL)isExecutionDelegate animated:(BOOL)animated;
- (void)lgf_ReloadTitleAndSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated;
- (void)lgf_ReloadTitle;
#pragma mark - 手动选中某个标（如果关联外部 CV 外部 CV 请手动滚动）
/**
 @param index 要选中的下标
 @param duration 选中动画的时间
 @param autoScrollDuration 跟随动画的时间
 @param isExecutionDelegate 是否执行点击代理
 */
- (void)lgf_SelectIndex:(NSInteger)index duration:(CGFloat)duration autoScrollDuration:(CGFloat)autoScrollDuration isExecutionDelegate:(BOOL)isExecutionDelegate;
- (void)lgf_SelectIndex:(NSInteger)index duration:(CGFloat)duration autoScrollDuration:(CGFloat)autoScrollDuration;
- (void)lgf_SelectIndex:(NSInteger)index isExecutionDelegate:(BOOL)isExecutionDelegate;
- (void)lgf_SelectIndex:(NSInteger)index;
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
