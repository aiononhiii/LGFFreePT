//
//  UIView+LGFGSView.h
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LGFGSView)

#pragma mark - 控件唯一名字(通常用于确定某一个特殊的view)

@property (copy, nonatomic) IBInspectable NSString *lgf_ViewName;

#pragma mark - 圆角

@property (assign , nonatomic) IBInspectable CGFloat lgf_CornerRadius;

#pragma mark - 边框颜色

@property (strong , nonatomic) IBInspectable UIColor *lgf_BorderColor;

#pragma mark - 边框宽度

@property (assign , nonatomic) IBInspectable CGFloat lgf_BorderWidth;

#pragma mark - 阴影颜色

@property (strong , nonatomic) IBInspectable UIColor *lgf_ShadowColor;

#pragma mark - 阴影圆角

@property (assign , nonatomic) IBInspectable CGFloat lgf_ShadowRadius;

#pragma mark - 阴影偏移量

@property (assign , nonatomic) IBInspectable CGSize lgf_ShadowOffset;

#pragma mark - 阴影透明度

@property (assign , nonatomic) IBInspectable float lgf_ShadowOpacity;

#pragma mark - 是否随机背景色 通常用于调试UI

@property (assign , nonatomic) IBInspectable BOOL lgf_IsRandomBackColor;

#pragma mark - 是否使用渐变背景色

@property (strong , nonatomic) IBInspectable UIColor *lgf_GFromColor;

@property (strong , nonatomic) IBInspectable UIColor *lgf_GToColor;

@property (assign , nonatomic) IBInspectable CGFloat lgf_GWidth;

@property (assign , nonatomic) IBInspectable CGFloat lgf_GHeight;

@property (assign , nonatomic) IBInspectable CGPoint lgf_GStartPoint;

@property (assign , nonatomic) IBInspectable CGPoint lgf_GEndPoint;

@end

