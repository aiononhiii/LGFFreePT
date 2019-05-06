//
//  LGFCountDownButton.h
//  LGFOCTool
//
//  Created by apple on 2017/5/7.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGFCountDownButton : UIButton

#pragma mark - 提示 label

@property (strong, nonatomic) UILabel *lgf_Label;

#pragma mark - 设置倒计时秒数
/**
 @param timeCount 秒数
 */
- (void)lgf_TimeFailBeginFrom:(NSInteger)timeCount;

#pragma mark - 点击后的背景色 默认 [UIColor lightGrayColor]

@property (nonatomic , strong) IBInspectable UIColor *lgf_SelectColor;

#pragma mark - 点击后的文字颜色 默认 [UIColor darkGrayColor]

@property (nonatomic , strong) IBInspectable UIColor *lgf_SelectTextColor;

@end
