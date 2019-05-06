//
//  UIView+LGFCornerRadius.m
//  LGFOCTool
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIView+LGFCornerRadius.h"

@implementation UIView (LGFCornerRadius)

#pragma mark - 给某个角设置圆角
/**
 @param rectCorner 设置圆角的角
 UIRectCornerTopLeft     = 1 << 0,
 UIRectCornerTopRight    = 1 << 1,
 UIRectCornerBottomLeft  = 1 << 2,
 UIRectCornerBottomRight = 1 << 3,
 UIRectCornerAllCorners  = ~0UL
 @param cornerRadii 圆角度数
 */
- (void)lgf_CornerRadius:(UIRectCorner)rectCorner cornerRadii:(CGFloat)cornerRadii {
    [self.superview setNeedsLayout];
    [self.superview layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
