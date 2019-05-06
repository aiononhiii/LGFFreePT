//
//  UIScrollView+LGFScrollView.h
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (LGFScrollView)

#pragma mark - 使用动画将内容滚动到顶部
- (void)lgf_ScrollToTop;

#pragma mark - 使用动画将内容滚动到底部
- (void)lgf_ScrollToBottom;

#pragma mark - 使用动画将内容滚动到左边
- (void)lgf_ScrollToLeft;

#pragma mark - 使用动画将内容滚动到右边
- (void)lgf_ScrollToRight;

#pragma mark - 将内容滚动到顶部
/**
 @param animated  是否使用动画
 */
- (void)lgf_ScrollToTopAnimated:(BOOL)animated;

#pragma mark - 将内容滚动到底部
/**
 @param animated  是否使用动画
 */
- (void)lgf_ScrollToBottomAnimated:(BOOL)animated;

#pragma mark - 将内容滚动到左边
/**
 @param animated  是否使用动画
 */
- (void)lgf_ScrollToLeftAnimated:(BOOL)animated;

#pragma mark - 将内容滚动到右边
/**
 @param animated  是否使用动画
 */
- (void)lgf_ScrollToRightAnimated:(BOOL)animated;

#pragma mark - 取得 UIScrollView 分页 index
- (NSInteger)lgf_GetScrollPageIndex;
@end

NS_ASSUME_NONNULL_END
