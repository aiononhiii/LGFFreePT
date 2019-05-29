//
//  UIViewController+LGFViewController.h
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LGFViewController)

#pragma mark - 判断某个视图控制器 是否可见

- (BOOL)lgf_IsVisible;

#pragma mark - 删除所有子控制器
- (void)lgf_RemoveAllChildViewController;

@end
