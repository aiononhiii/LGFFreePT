//
//  NSString+LGFTextSize.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFOCTool.h"

@interface NSString (LGFTextSize)

#pragma mark - 计算文字的高度
/**
 @param font  字体(默认为系统字体)
 @param width 约束宽度
 */
- (CGFloat)lgf_HeightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

#pragma mark - 计算文字的宽度
/**
 @param font   字体(默认为系统字体)
 @param height 约束高度
 */
- (CGFloat)lgf_WidthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

#pragma mark - 计算文字的CGSize
/**
 @param font  字体(默认为系统字体)
 @param width 约束宽度
 */
- (CGSize)lgf_SizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

#pragma mark - 计算文字的CGSize
/**
 @param font   字体(默认为系统字体)
 @param height 约束高度
 */
- (CGSize)lgf_SizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

#pragma mark - 计算文字的高度
/**
 @param strSrc 被反转字符串
 @return 反转后字符串
 */
+ (NSString *)lgf_ReverseString:(NSString *)strSrc;

@end
