//
//  UIImage+LGFColorImage.m
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UIImage+LGFColorImage.h"

@implementation UIImage (LGFColorImage)

#pragma mark - 生成一个颜色可缩放图像
+ (UIImage *)lgf_ColorImageWithFillColor:(UIColor *)fillColor {
    return [self lgf_ColorImageWithCornerRadius:0.0
                                    cornerColor:nil
                                      fillColor:fillColor
                                    borderColor:nil
                                    borderWidth:0.0
                                 roundedCorners:UIRectCornerAllCorners
                                          scale:0.0];
}

#pragma mark - 生成一个平面颜色圆角可缩放图像
/**
 @param cornerRadius 圆角半径
 @param cornerColor  圆角被截取部分填充色
 @param fillColor    背景填充色
 */
+ (UIImage *)lgf_ColorImageWithCornerRadius:(CGFloat)cornerRadius
                                          cornerColor:(UIColor *)cornerColor
                                            fillColor:(UIColor *)fillColor {
    return [self lgf_ColorImageWithCornerRadius:cornerRadius
                                              cornerColor:cornerColor
                                                fillColor:fillColor
                                              borderColor:nil
                                              borderWidth:1.0
                                           roundedCorners:UIRectCornerAllCorners
                                                    scale:0.0];
}

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
                                          borderWidth:(CGFloat)borderWidth {
    return [self lgf_ColorImageWithCornerRadius:cornerRadius
                                              cornerColor:cornerColor
                                                fillColor:fillColor
                                              borderColor:borderColor
                                              borderWidth:borderWidth
                                           roundedCorners:UIRectCornerAllCorners
                                                    scale:0.0];
}

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
                                                scale:(CGFloat)scale {
    static NSCache *__pathCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __pathCache = [[NSCache alloc] init];
        __pathCache.countLimit = 20;
    });
    
    if ([cornerColor isEqual:[UIColor clearColor]]) {
        cornerColor = nil;
    }
    
    CGFloat dimension = (cornerRadius * 2) + 1;
    CGRect bounds = CGRectMake(0, 0, dimension, dimension);
    
    typedef struct {
        UIRectCorner corners;
        CGFloat radius;
    } PathKey;
    PathKey key = { roundedCorners, cornerRadius };
    NSValue *pathKeyObject = [[NSValue alloc] initWithBytes:&key objCType:@encode(PathKey)];
    
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *path = [__pathCache objectForKey:pathKeyObject];
    if (path == nil) {
        path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:roundedCorners cornerRadii:cornerRadii];
        [__pathCache setObject:path forKey:pathKeyObject];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, cornerColor != nil, scale);
    BOOL contextIsClean = YES;
    if (cornerColor) {
        contextIsClean = NO;
        [cornerColor setFill];
        UIRectFillUsingBlendMode(bounds, kCGBlendModeCopy);
    }
    
    BOOL canUseCopy = contextIsClean || (CGColorGetAlpha(fillColor.CGColor) == 1);
    [fillColor setFill];
    [path fillWithBlendMode:(canUseCopy ? kCGBlendModeCopy : kCGBlendModeNormal) alpha:1];
    
    if (borderColor) {
        [borderColor setStroke];
        CGRect strokeRect = CGRectInset(bounds, borderWidth / 2.0, borderWidth / 2.0);
        UIBezierPath *strokePath = [UIBezierPath bezierPathWithRoundedRect:strokeRect
                                                         byRoundingCorners:roundedCorners
                                                               cornerRadii:cornerRadii];
        [strokePath setLineWidth:borderWidth];
        BOOL canUseCopy = (CGColorGetAlpha(borderColor.CGColor) == 1);
        [strokePath strokeWithBlendMode:(canUseCopy ? kCGBlendModeCopy : kCGBlendModeNormal) alpha:1];
    }
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIEdgeInsets capInsets = UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius);
    result = [result resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
    return result;
}

@end
