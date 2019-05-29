//
//  UIImage+LGFColorImage.h
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LGFColorImage)

#pragma mark - 生成一个颜色可缩放图像
+ (UIImage *)lgf_ColorImageWithFillColor:(UIColor *)fillColor;

#pragma mark - 生成一个平面颜色圆角可缩放图像
/**
 @param cornerRadius 圆角半径
 @param cornerColor  圆角被截取部分填充色
 @param fillColor    背景填充色
 */
+ (UIImage *)lgf_ColorImageWithCornerRadius:(CGFloat)cornerRadius
                                          cornerColor:(UIColor *)cornerColor
                                            fillColor:(UIColor *)fillColor;

#pragma mark - 生成具有边框的平面颜色圆角可缩放图像
/**
 @param cornerRadius 圆角半径
 @param cornerColor  圆角被截取部分填充色
 @param fillColor    背景填充色
 @param borderColor  边框颜色
 @param borderWidth  边框宽度
 */
+ (UIImage *)lgf_ColorImageWithCornerRadius:(CGFloat)cornerRadius
                                          cornerColor:(UIColor *)cornerColor
                                            fillColor:(UIColor *)fillColor
                                          borderColor:(UIColor *)borderColor
                                          borderWidth:(CGFloat)borderWidth;

#pragma mark - 生成具有边框的平面颜色圆角可缩放图像
/**
 @param cornerRadius    圆角半径
 @param cornerColor     圆角被截取部分填充色
 @param fillColor       背景填充色
 @param borderColor     边框颜色
 @param borderWidth     边框宽度
 @param roundedCorners  设置圆角个数 和 位置 (UIRectCornerTopLeft | UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft)
 @param scale           每个点的缩放像素密度. 设置 0 为和当前屏幕一样.
 */
+ (UIImage *)lgf_ColorImageWithCornerRadius:(CGFloat)cornerRadius
                                          cornerColor:(UIColor *)cornerColor
                                            fillColor:(UIColor *)fillColor
                                          borderColor:(UIColor *)borderColor
                                          borderWidth:(CGFloat)borderWidth
                                       roundedCorners:(UIRectCorner)roundedCorners
                                                scale:(CGFloat)scale;

@end

