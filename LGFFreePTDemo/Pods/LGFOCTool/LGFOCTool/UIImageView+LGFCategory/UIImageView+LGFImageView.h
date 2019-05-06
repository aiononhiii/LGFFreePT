//
//  UIImageView+LGFImageView.h
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIImageView (LGFImageView)

#pragma mark - 网络加载切图名字

@property (copy, nonatomic) IBInspectable NSString *lgf_NetImageName;

#pragma mark - 创建imageview动画
/**
 *  @param imageArray 图片名称数组
 *  @param duration   动画时间
 */
- (void)lgf_AnimationWithImageArray:(NSArray*)imageArray duration:(NSTimeInterval)duration;

#pragma mark - 添加可伸缩图片
- (void)lgf_SetImageWithStretchableImage:(UIImage*)image;

#pragma mark - 给 ImageView 添加图片的同时 在某个区域添加 水印
/**
 @param image 图片
 @param waterMark 水印
 @param rect 水印添加区域
 */
- (void)lgf_SetImage:(UIImage *)image withWaterMark:(UIImage *)waterMark inRect:(CGRect)rect;

#pragma mark - 给 ImageView 添加图片的同时 在某个区域添加 文字水印
/**
 @param image 图片
 @param waterMarkString 水印文字
 @param rect 水印添加区域
 @param color 文字颜色
 @param font 文字字体
 */
- (void)lgf_SetImage:(UIImage *)image withStringWaterMark:(NSString *)waterMarkString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;

#pragma mark - 给 ImageView 添加图片的同时 在某个点添加 文字水印
/**
 @param image 图片
 @param waterMarkString 水印文字
 @param point 水印添加点
 @param color 文字颜色
 @param font 文字字体
 */
- (void)lgf_SetImage:(UIImage *)image withWaterMarkString:(NSString *)waterMarkString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;

@end
