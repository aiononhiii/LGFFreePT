//
//  UIImage+LGFPDFImage.h
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LGFPDFImage)

#pragma mark - PDF 转图片 设置 高
/**
 @param PDFNamed PDF 文件名
 @param height 高度设置
 @return 图片
 */
+ (UIImage *)lgf_ImageWithPDFNamed:(NSString *)PDFNamed forHeight:(CGFloat)height;

#pragma mark - PDF 转图片 设置 高 颜色
/**
 @param PDFNamed PDF 文件名
 @param tintColor 颜色设置
 @param height 高度设置
 @return 图片
 */
+ (UIImage *)lgf_ImageWithPDFNamed:(NSString *)PDFNamed withTintColor:(UIColor *)tintColor forHeight:(CGFloat)height;

#pragma mark - PDF 转图片 设置 Size 颜色
/**
 @param PDFFile pdf 文件路径
 @param tintColor 颜色设置
 @param size Size设置
 @return 图片
 */
+ (UIImage *)lgf_ImageWithPDFFile:(NSString *)PDFFile withTintColor:(UIColor *)tintColor forSize:(CGSize)size;

+ (UIImage *)lgf_IconWithFont:(UIFont *)font named:(NSString *)iconNamed withTintColor:(UIColor *)tintColor clipToBounds:(BOOL)clipToBounds forSize:(CGFloat)fontSize;

@end
