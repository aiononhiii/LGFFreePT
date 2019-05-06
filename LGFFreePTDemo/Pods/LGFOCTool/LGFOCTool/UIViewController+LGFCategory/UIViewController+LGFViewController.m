//
//  UIViewController+LGFViewController.m
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UIViewController+LGFViewController.h"

@implementation UIViewController (LGFViewController)

#pragma mark - 判断某个视图控制器 是否可见

- (BOOL)lgf_IsVisible {
    return [self isViewLoaded] && self.view.window;
}

- (void)lgf_RemoveAllChildViewController {
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}

@end
