//
//  LGFFreePTMethod.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFFreePTMethod.h"
#import "UIView+LGFFreePT.h"

@implementation LGFFreePTMethod

#pragma mark - 获取文字size
+ (CGSize)lgf_SizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize size = [str boundingRectWithSize:maxSize
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:dict
                                    context:nil].size;
    return CGSizeMake(size.width, size.height);
}

#pragma mark - UIColorRGB 转颜色数组
+ (NSArray *)lgf_GetColorRGBA:(UIColor *)color {
    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbaComponents;
    if (numOfcomponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbaComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), @(components[3]), nil];
    }
    return rgbaComponents;
}

//--------------- 我自己原配的 line 滚动动画逻辑代码
+ (void)lgf_PageLineAnimationDefultScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress {
    line.lgfpt_X = selectX * progress + unSelectX * (1.0 - progress);
    line.lgfpt_Width = selectWidth * progress + unSelectWidth * (1.0 - progress);
}

+ (void)lgf_PageLineAnimationShortToLongScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress {
    CGFloat space = (unSelectTitle.lgfpt_Width / unSelectTitle.lgf_CurrentTransformSX - unSelectWidth) / 2 + (selectTitle.lgfpt_Width / selectTitle.lgf_CurrentTransformSX - selectWidth) / 2;
    if (progress > 0.5) {
        if (unSelectIndex < selectIndex) {
            line.lgfpt_X = selectX - (space + unSelectWidth) * 2 * (1.0 - progress);
        } else {
            line.lgfpt_X = selectX;
        }
    } else {
        if (unSelectIndex > selectIndex) {
            line.lgfpt_X = unSelectX - (space + selectWidth) * 2 * progress;
        } else {
            line.lgfpt_X = unSelectX;
        }
    }
    if (progress > 0.5) {
        line.lgfpt_Width = selectWidth  + (unSelectWidth + space) * 2 * (1.0 - progress);
    } else {
        line.lgfpt_Width = unSelectWidth + (selectWidth + space) * 2 * progress;
    }
}

+ (void)lgf_PageLineAnimationHideShowScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress {
    if (progress > 0.5) {
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
        line.alpha = 1.0 - (2.0 * (1.0 - progress));
    } else {
        line.lgfpt_X = unSelectX;
        line.lgfpt_Width = unSelectWidth;
        line.alpha = 1.0 - (2.0 * progress);
    }
}

+ (void)lgf_PageLineAnimationSmallToBigScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress {
    line.transform = CGAffineTransformIdentity;
    if (progress > 0.5) {
        CGFloat num = 1.0 - (2.0 * (1.0 - progress));
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
        line.transform = CGAffineTransformMakeScale(num, num);
    } else {
        CGFloat num = 1.0 - (2.0 * progress);
        line.lgfpt_X = unSelectX;
        line.lgfpt_Width = unSelectWidth;
        line.transform = CGAffineTransformMakeScale(num, num);
    }
}

+ (void)lgf_PageLineAnimationTortoiseDownScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress {
    CGFloat space = style.lgf_LineBottom + line.lgfpt_Height;
    if (progress > 0.5) {
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
        line.transform = CGAffineTransformIdentity;
        line.transform = CGAffineTransformMakeTranslation(0, space * (2.0 * (1.0 - progress)));
    } else {
        line.lgfpt_X = unSelectX;
        line.lgfpt_Width = unSelectWidth;
        line.transform = CGAffineTransformIdentity;
        line.transform = CGAffineTransformMakeTranslation(0, space + space * (1.0 - (2.0 * (1.0 - progress))));
    }
}

+ (void)lgf_PageLineAnimationTortoiseUpScrollLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line progress:(CGFloat)progress {
    CGFloat space = style.lgf_LineBottom + -style.lgf_PVTitleView.lgfpt_Height;
    if (progress > 0.5) {
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
        line.transform = CGAffineTransformIdentity;
        line.transform = CGAffineTransformMakeTranslation(0, space * (2.0 * (1.0 - progress)));
    } else {
        line.lgfpt_X = unSelectX;
        line.lgfpt_Width = unSelectWidth;
        line.transform = CGAffineTransformIdentity;
        line.transform = CGAffineTransformMakeTranslation(0, space + space * (1.0 - (2.0 * (1.0 - progress))));
    }
}

//--------------- 我自己原配的 line 点击动画逻辑代码
+ (void)lgf_PageLineAnimationDefultClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration {
    line.lgfpt_X = selectX;
    line.lgfpt_Width = selectWidth;
}

+ (void)lgf_PageLineAnimationShortToLongClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration {
    line.lgfpt_X = selectX;
    line.lgfpt_Width = selectWidth;
}

+ (void)lgf_PageLineAnimationHideShowClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration {
    // 通过关键帧动画配合我给你的 duration，你应该可以实现很多你想要的独有的效果
    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 - (0.0001 / duration)  animations:^{
        line.alpha = 0.0;
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 + (0.0001 / duration) relativeDuration:0.5 - (0.0001 / duration) animations:^{
        line.alpha = 1.0;
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 - (0.0001 / duration) relativeDuration:0.0002 / duration animations:^{
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
    }];
}

+ (void)lgf_PageLineAnimationSmallToBigClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration {
    // 通过关键帧动画配合我给你的 duration，你应该可以实现很多你想要的独有的效果
    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 - (0.0001 / duration)  animations:^{
        line.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 + (0.0001 / duration) relativeDuration:0.5 - (0.0001 / duration) animations:^{
        line.transform = CGAffineTransformIdentity;
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 - (0.0001 / duration) relativeDuration:0.0002 / duration animations:^{
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
    }];
}

+ (void)lgf_PageLineAnimationTortoiseDownClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration {
    CGFloat space = style.lgf_LineBottom + line.lgfpt_Height;
    // 通过关键帧动画配合我给你的 duration，你应该可以实现很多你想要的独有的效果
    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 - (0.0001 / duration)  animations:^{
        line.transform = CGAffineTransformMakeTranslation(0.0, space);
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 + (0.0001 / duration) relativeDuration:0.5 - (0.0001 / duration) animations:^{
        line.transform = CGAffineTransformIdentity;
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 - (0.0001 / duration) relativeDuration:0.0002 / duration animations:^{
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
    }];
}

+ (void)lgf_PageLineAnimationTortoiseUpClickLineAnimationConfig:(LGFFreePTStyle *)style selectX:(CGFloat)selectX selectWidth:(CGFloat)selectWidth unSelectX:(CGFloat)unSelectX unSelectWidth:(CGFloat)unSelectWidth unSelectTitle:(LGFFreePTTitle *)unSelectTitle selectTitle:(LGFFreePTTitle *)selectTitle unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex line:(LGFFreePTLine *)line duration:(NSTimeInterval)duration {
    CGFloat space = style.lgf_LineBottom - style.lgf_PVTitleView.lgfpt_Height;
    // 通过关键帧动画配合我给你的 duration，你应该可以实现很多你想要的独有的效果
    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 - (0.0001 / duration)  animations:^{
        line.transform = CGAffineTransformMakeTranslation(0.0, space);
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 + (0.0001 / duration) relativeDuration:0.5 - (0.0001 / duration) animations:^{
        line.transform = CGAffineTransformIdentity;
    }];
    [UIView addKeyframeWithRelativeStartTime:0.5 - (0.0001 / duration) relativeDuration:0.0002 / duration animations:^{
        line.lgfpt_X = selectX;
        line.lgfpt_Width = selectWidth;
    }];
}

//--------------- 我自己原配的 line 点击动画逻辑代码
+ (void)lgf_TitleScrollFollowDefultAnimationConfig:(LGFFreePTStyle *)style lgf_TitleButtons:(NSMutableArray <LGFFreePTTitle *> *)lgf_TitleButtons unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex duration:(NSTimeInterval)duration {
    LGFFreePTTitle *selectTitle = (LGFFreePTTitle *)lgf_TitleButtons[selectIndex];
    CGFloat offSetx = MIN(MAX(selectTitle.center.x - style.lgf_PVTitleView.lgfpt_Width * 0.5, 0.0), MAX(style.lgf_PVTitleView.contentSize.width - style.lgf_PVTitleView.lgfpt_Width, 0.0));
    [UIView animateWithDuration:duration animations:^{
        [style.lgf_PVTitleView setContentOffset:CGPointMake(offSetx, 0.0)];
    }];
}

+ (void)lgf_TitleScrollFollowLeftRightAnimationConfig:(LGFFreePTStyle *)style lgf_TitleButtons:(NSMutableArray <LGFFreePTTitle *> *)lgf_TitleButtons unSelectIndex:(NSInteger)unSelectIndex selectIndex:(NSInteger)selectIndex duration:(NSTimeInterval)duration {
    BOOL isRight = selectIndex > unSelectIndex;
    LGFFreePTTitle *title = (LGFFreePTTitle *)lgf_TitleButtons[isRight ? MIN(selectIndex + 1, lgf_TitleButtons.count - 1) : MAX(selectIndex - 1, 0)];
    [UIView animateWithDuration:duration animations:^{
        if (isRight) {
            if (selectIndex == (lgf_TitleButtons.count - 1)) {
                [style.lgf_PVTitleView setContentOffset:CGPointMake(style.lgf_PVTitleView.contentSize.width - style.lgf_PVTitleView.lgfpt_Width, 0.0)];
            } else {
                if ((title.lgfpt_X + title.lgfpt_Width) >= (style.lgf_PVTitleView.contentOffset.x + style.lgf_PVTitleView.lgfpt_Width)) {
                    [style.lgf_PVTitleView setContentOffset:CGPointMake(title.lgfpt_X + title.lgfpt_Width - style.lgf_PVTitleView.lgfpt_Width + (((selectIndex + 1) == (lgf_TitleButtons.count - 1)) ? style.lgf_PageLeftRightSpace : 0.0), 0.0)];
                }
            }
        } else {
            if (selectIndex == 0) {
                [style.lgf_PVTitleView setContentOffset:CGPointMake(0.0, 0.0)];
            } else {
                if (title.lgfpt_X < style.lgf_PVTitleView.contentOffset.x) {
                    [style.lgf_PVTitleView setContentOffset:CGPointMake(title.lgfpt_X - (((selectIndex - 1) == 0) ? style.lgf_PageLeftRightSpace : 0.0), 0.0)];
                }
            }
        }
    }];
}

// 我自己原配分页动画(你可以参考我的来实现独一无二的自定义，当然你可以在我的GitHub首页把这些珍贵的代码分享给大家)
+ (void)lgf_FreePageViewTopToBottomAnimationConfig:(NSArray *)attributes flowLayout:(UICollectionViewFlowLayout *)flowLayout {
    CGFloat contentOffsetX = flowLayout.collectionView.contentOffset.x;
    CGFloat collectionViewCenterX = flowLayout.collectionView.lgfpt_Width * 0.5;
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        CGFloat alpha = fabs(1.0 - fabs(attr.center.x - contentOffsetX - collectionViewCenterX) / flowLayout.collectionView.lgfpt_Width);
        CGFloat scale = -fabs(fabs(attr.center.x - contentOffsetX - collectionViewCenterX) /flowLayout.collectionView.lgfpt_Width) * 50.0;
        NSInteger index = fabs(flowLayout.collectionView.contentOffset.x / flowLayout.collectionView.lgfpt_Width);
        if ([flowLayout.collectionView.panGestureRecognizer translationInView:flowLayout.collectionView].x < 0.0) {
            if (attr.indexPath.item != index) {
                attr.alpha = alpha;
            }
        } else {
            if (attr.indexPath.item == index) {
                attr.alpha = alpha;
            }
        }
        attr.transform = CGAffineTransformMakeTranslation(0, scale);
    }
}

+ (void)lgf_FreePageViewSmallToBigAnimationConfig:(NSArray *)attributes flowLayout:(UICollectionViewFlowLayout *)flowLayout {
    CGFloat contentOffsetX = flowLayout.collectionView.contentOffset.x;
    CGFloat collectionViewCenterX = flowLayout.collectionView.lgfpt_Width * 0.5;
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        CGFloat scale = (1.0 - fabs(attr.center.x - contentOffsetX - collectionViewCenterX) /flowLayout.collectionView.lgfpt_Width * 0.8);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

@end
