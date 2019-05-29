//
//  UITextView+LGFTextView.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LGFTextView)

#pragma mark - 是否取消默认边距离

@property (assign , nonatomic) IBInspectable BOOL lgf_IsZeroInset;

#pragma mark - UITextView输入长度限制
/**
 @param maxLength 限制的长度
 */
- (void)lgf_LimitIncludeForLength:(NSUInteger)maxLength;

#pragma mark - 关键字高亮
/**
 @param color 关键字高亮颜色
 @param text 高亮关键字
 */
- (void)lgf_KeywordHighlightColor:(UIColor *)color text:(NSString *)text;
/**
 @param color 关键字高亮颜色
 @param font 关键字字体
 @param text 高亮关键字
 */
- (void)lgf_KeywordHighlightColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text;
/**
 @param texts 高亮关键字数组
 */
- (void)lgf_KeywordHighlightTexts:(NSArray *)texts;// @[@{@"text" : @"style", @"color" : @"FFFFFF", @"font" : @"8"}]
@end
