//
//  UIColor+LGFGradient.h
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LGFGradient)

#pragma mark -  上下 竖渐变
/**
 @param fromColor 渐变 开始色
 @param toColor 渐变 结束色
 @param height 渐变高度
 @return 渐变后的颜色
 */
+ (UIColor *)lgf_GradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor height:(int)height;

#pragma mark -  左右 横渐变
/**
 @param fromColor 渐变 开始色
 @param toColor 渐变 结束色
 @param width 渐变 宽度
 @return 渐变后的颜色
 */
+ (UIColor *)lgf_GradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor width:(int)width;

#pragma mark -  左右 横渐变 返回图片
/**
 @param fromColor 渐变 开始色
 @param toColor 渐变 结束色
 @param width 渐变 宽度
 @param allWidth 总 宽度
 @return 渐变后的颜色图片
 */
+ (UIImage *)lgf_GradientFromColorReturnImage:(UIColor *)fromColor toColor:(UIColor *)toColor withGradientWidth:(CGFloat)width withAllWidth:(int)allWidth;
@end
