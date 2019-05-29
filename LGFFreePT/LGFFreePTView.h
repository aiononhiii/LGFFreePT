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
#pragma mark -  标动画完全结束后的选中标回调代理
- (void)lgf_SelectFreePTTitle:(NSInteger)selectIndex;

@optional
#pragma mark -  以 contentOffsetX 匹配最精确的选中标回调代理
- (void)lgf_RealSelectFreePTTitle:(NSInteger)selectIndex;

#pragma mark -  加载网络图片代理，具体加载框架我的 Demo 不做约束，请自己选择图片加载框架，使用前请打开 lgf_IsNetImage
/**
 @param imageView 要加载网络图片的 imageView
 @param imageUrl 网络图片的 Url
 */
- (void)lgf_GetNetImage:(UIImageView *)imageView imageUrl:(NSURL *)imageUrl;

#pragma mark - 实现这个代理来对 LGFFreePTTitle 初始化时某些系统属性进行配置 backgroundColor/borderColor/CornerRadius等等 注意：这些新配置如果和 LGFFreePTStyle 冲突将覆盖 LGFFreePTStyle 的效果
/**
 @param lgf_FreePTTitle LGFFreePTTitle 本体
 @param index 所在的 index
 @param style LGFFreePTStyle
 */
- (void)lgf_GetLGFFreePTTitle:(UIView *)lgf_FreePTTitle index:(NSInteger)index style:(LGFFreePTStyle *)style;
#pragma mark - 实现这个代理来对 LGFFreePTLine 初始化时某些系统属性进行配置 backgroundColor/borderColor/CornerRadius等等 注意：这些新配置如果和 LGFFreePTStyle 冲突将覆盖 LGFFreePTStyle 的效果
/**
 @param lgf_FreePTLine LGFFreePTLine 本体
 @param style LGFFreePTStyle
 */
- (void)lgf_GetLGFFreePTLine:(UIImageView *)lgf_FreePTLine style:(LGFFreePTStyle *)style;

#pragma mark - 如果我原配的动画满足不了你，那么请使用这个自定义 line 动画代理（自定义配置滚动后 line 的动画）
/**
 @param style LGFFreePTStyle
 @param selectX 选中标的 X
 @param selectWidth 选中标的 Width
 @param unSelectX 未选中标的 X
 @param unSelectWidth 未选中标的 Width
 @param unSelectTitle 未选中标本体
 @param selectTitle 选中标本体
 @param unSelectIndex 未选中 index
 @param selectIndex 选中 index
 @param line line 本体
 @param progress 进度参数(运行项目可查看 progress 改变的 log 输出 然后自行设计动画吧)
 */
- (void)lgf_FreePTViewCustomizeScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress;

#pragma mark - 自定义配置点击后 line 的动画
/**
 @param style LGFFreePTStyle
 @param selectX 选中标的 X
 @param selectWidth 选中标的 Width
 @param unSelectX 未选中标的 X
 @param unSelectWidth 未选中标的 Width
 @param unSelectTitle 未选中标本体
 @param selectTitle 选中标本体
 @param unSelectIndex 未选中 index
 @param selectIndex 选中 index
 @param line line 本体
 @param duration 点击动画时长
 */
- (void)lgf_FreePTViewCustomizeClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration;

#pragma mark - 自定义配置选中结束后标的回位模式
/**
 @param style LGFFreePTStyle
 @param lgf_TitleButtons 所有标数组
 @param unSelectIndex 未选中 index
 @param selectIndex 选中 index
 @param duration 回位动画时长
 */
- (void)lgf_TitleScrollFollowCustomizeAnimationConfig:(LGFFreePTStyle *)style lgf_TitleButtons:(NSMutableArray <LGFFreePTTitle *> *)lgf_TitleButtons unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex duration:(NSTimeInterval)duration;
#pragma mark - 自定义分页动画（我这里提供一个配置入口，也可以自己在外面配置 UICollectionViewFlowLayout 原理一样）
/**
 @param attributes UICollectionViewLayoutAttributes
 @param flowLayout UICollectionViewFlowLayout
 */
- (void)lgf_FreePageViewCustomizeAnimationConfig:(NSArray *)attributes flowLayout:(UICollectionViewFlowLayout *)flowLayout;
@end
@interface LGFFreePTView : UIScrollView
@property (weak, nonatomic) id<LGFFreePTDelegate>lgf_FreePTDelegate;
@property (strong, nonatomic) LGFFreePTLine * _Nullable lgf_TitleLine;// 底部滚动条(决定开在 .h 方便配合代理实现某些特殊需求)
@property (strong, nonatomic) LGFFreePTStyle *lgf_Style;// 配置用模型
@property (strong, nonatomic) NSMutableArray <LGFFreePTTitle *> *lgf_TitleButtons;// 所有标数组
@property (assign, nonatomic) NSInteger lgf_SelectIndex;// 选中下标

#pragma mark - 初始化
+ (instancetype)lgf;

#pragma mark - 刷新所有标
/**
 @param isExecutionDelegate 是否执行 lgf_SelectFreePTTitle 代理
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
 @param isExecutionDelegate 是否执行 lgf_SelectFreePTTitle 代理
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
