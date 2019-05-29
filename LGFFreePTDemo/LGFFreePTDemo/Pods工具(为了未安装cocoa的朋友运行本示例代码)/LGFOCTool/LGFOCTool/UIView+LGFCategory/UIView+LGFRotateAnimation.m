//
//  UIView+LGFRotateAnimation.m
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIView+LGFRotateAnimation.h"

@implementation UIView (LGFRotateAnimation)

#pragma mark - 添加旋转动画
/**
 @param view 添加旋转动画的view
 @param duration 一圈的时间
 */
+ (void)lgf_AddRotateAnimation:(UIView *)view duration:(CFTimeInterval)duration {
    [view.layer removeAllAnimations];
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    CFTimeInterval pausedTime = [view.layer timeOffset];
    view.layer.speed = 1.0;
    view.layer.timeOffset = 0.0;
    view.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [view.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    view.layer.beginTime = timeSincePause;
}

#pragma mark - 移除旋转动画
/**
 @param view 添加旋转动画的view
 */
+ (void)lgf_PauseRotate:(UIView *)view {
    if (view.layer.speed > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CFTimeInterval pausedTime = [view.layer convertTime:CACurrentMediaTime() fromLayer:nil];
            view.layer.speed = 0.0;
            view.layer.timeOffset = pausedTime;
        });
    }
}

#pragma mark - 暂停旋转动画
/**
 @param view 添加旋转动画的view
 */
+ (void)lgf_StartRotate:(UIView *)view {
    if (view.layer.speed == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CFTimeInterval pausedTime = [view.layer timeOffset];
            view.layer.speed = 1.0;
            view.layer.timeOffset = 0.0;
            view.layer.beginTime = 0.0;
            CFTimeInterval timeSincePause = [view.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
            view.layer.beginTime = timeSincePause;
        });
    }
}

#pragma mark - 继续旋转动画
/**
 @param view 添加旋转动画的view
 */
+ (void)lgf_RemoveRotateAnimation:(UIView *)view {
    [view.layer removeAllAnimations];
}

@end
