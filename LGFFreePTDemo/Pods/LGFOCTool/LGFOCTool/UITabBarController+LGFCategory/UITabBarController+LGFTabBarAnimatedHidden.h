//
//  UITabBarController+LGFTabBarAnimatedHidden.h
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (LGFTabBarAnimatedHidden)

#pragma mark - 隐藏TabBar
/**
 @param hidden 隐藏还是显示
 @param animated 是否有动画
 */
- (void)lgf_SetTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
