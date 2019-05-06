//
//  UIView+LGFRotateAnimation.h
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LGFRotateAnimation)

#pragma mark - 添加旋转动画
/**
 @param view 添加旋转动画的view
 @param duration 一圈的时间
 */
+ (void)lgf_AddRotateAnimation:(UIView *)view duration:(CFTimeInterval)duration;

#pragma mark - 移除旋转动画
/**
 @param view 添加旋转动画的view
 */
+ (void)lgf_RemoveRotateAnimation:(UIView *)view;

#pragma mark - 暂停旋转动画
/**
 @param view 添加旋转动画的view
 */
+ (void)lgf_PauseRotate:(UIView *)view;

#pragma mark - 继续旋转动画
/**
 @param view 添加旋转动画的view
 */
+ (void)lgf_StartRotate:(UIView *)view;

@end
