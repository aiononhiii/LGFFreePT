//
//  LGFFreePTMethod.h
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LGFFreePTStyle.h"
#import "LGFFreePTLine.h"
#import "LGFFreePTTitle.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGFFreePTMethod : NSObject
#pragma mark - 获取文字size
+ (CGSize)lgf_SizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

#pragma mark - UIColorRGB 转颜色数组
+ (NSArray *)lgf_GetColorRGBA:(UIColor *)color;

// 我自己原配的 line 滚动动画逻辑代码(部分重复为了方便观看理解我控件的用法)(你可以参考我的来实现独一无二的自定义，当然你可以在我的GitHub首页把这些珍贵的动效代码分享给大家)
#pragma mark - lgf_PageLineAnimationDefult
+ (void)lgf_PageLineAnimationDefultScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress;

#pragma mark - lgf_PageLineAnimationShortToLong
+ (void)lgf_PageLineAnimationShortToLongScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress;

#pragma mark - lgf_PageLineAnimationHideShow
+ (void)lgf_PageLineAnimationHideShowScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress;

#pragma mark - lgf_PageLineAnimationSmallToBig
+ (void)lgf_PageLineAnimationSmallToBigScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress;

#pragma mark - lgf_PageLineAnimationTortoiseDown
+ (void)lgf_PageLineAnimationTortoiseDownScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress;

#pragma mark - lgf_PageLineAnimationTortoiseUp
+ (void)lgf_PageLineAnimationTortoiseUpScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress;

// 我自己原配的 line 点击动画逻辑代码(部分重复为了方便观看理解我控件的用法)(你可以参考我的来实现独一无二的自定义，当然你可以在我的GitHub首页把这些珍贵的动效代码分享给大家)
#pragma mark - lgf_PageLineAnimationDefult
+ (void)lgf_PageLineAnimationDefultClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration;

#pragma mark - lgf_PageLineAnimationShortToLong
+ (void)lgf_PageLineAnimationShortToLongClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration;

#pragma mark - lgf_PageLineAnimationHideShow
+ (void)lgf_PageLineAnimationHideShowClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration;

#pragma mark - lgf_PageLineAnimationSmallToBig
+ (void)lgf_PageLineAnimationSmallToBigClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration;

#pragma mark - lgf_PageLineAnimationTortoiseDown
+ (void)lgf_PageLineAnimationTortoiseDownClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration;

#pragma mark - lgf_PageLineAnimationTortoiseUp
+ (void)lgf_PageLineAnimationTortoiseUpClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration;

// 我自己原配的选中结束后标的回位模式(你可以参考我的来实现独一无二的自定义，当然你可以在我的GitHub首页把这些珍贵的代码分享给大家)
#pragma mark - lgf_TitleScrollFollowDefult
+ (void)lgf_TitleScrollFollowDefultAnimationConfig:(LGFFreePTStyle *)style lgf_TitleButtons:(NSMutableArray <LGFFreePTTitle *> *)lgf_TitleButtons unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex duration:(NSTimeInterval)duration;

#pragma mark - lgf_TitleScrollFollowLeftRight
+ (void)lgf_TitleScrollFollowLeftRightAnimationConfig:(LGFFreePTStyle *)style lgf_TitleButtons:(NSMutableArray <LGFFreePTTitle *> *)lgf_TitleButtons unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex duration:(NSTimeInterval)duration;

// 我自己原配分页动画(你可以参考我的来实现独一无二的自定义，当然你可以在我的GitHub首页把这些珍贵的代码分享给大家)
#pragma mark - lgf_PageViewAnimationTopToBottom
+ (void)lgf_FreePageViewTopToBottomAnimationConfig:(NSArray *)attributes flowLayout:(UICollectionViewFlowLayout *)flowLayout;

#pragma mark - lgf_PageViewAnimationSmallToBig
+ (void)lgf_FreePageViewSmallToBigAnimationConfig:(NSArray *)attributes flowLayout:(UICollectionViewFlowLayout *)flowLayout;
@end

NS_ASSUME_NONNULL_END
