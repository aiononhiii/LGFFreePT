//
//  UIButton+LGFIndicator.h
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LGFIndicator)

#pragma mark - 按钮显示白色菊花

- (void)lgf_ShowWhiteIndicator;

#pragma mark - 按钮显示灰色菊花

- (void)lgf_ShowGrayIndicator;

#pragma mark - 按钮隐藏菊花

- (void)lgf_HideIndicator;

@end
