//
//  UITabBarController+LGFTabBarAnimatedHidden.m
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UITabBarController+LGFTabBarAnimatedHidden.h"
#import "LGFOCTool.h"

@implementation UITabBarController (LGFTabBarAnimatedHidden)

#pragma mark - 隐藏TabBar
/**
 @param hidden 隐藏还是显示
 @param animated 是否有动画
 */
- (void)lgf_SetTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    CGRect frame = self.tabBar.frame;
    if (hidden) {
        // 隐藏
        frame.origin.y = lgf_ScreenHeight;
    } else {
        // 展示
        frame.origin.y = lgf_ScreenHeight - 49;
    }
    
    if (animated) {
        [UIView animateWithDuration:.25 animations:^{
            self.tabBar.frame = frame;
        }];
    } else {
        self.tabBar.frame = frame;
    }
}

@end
