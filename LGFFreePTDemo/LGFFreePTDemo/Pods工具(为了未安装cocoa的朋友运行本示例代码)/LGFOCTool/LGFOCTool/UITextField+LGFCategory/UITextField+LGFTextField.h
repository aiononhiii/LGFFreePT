//
//  UITextField+LGFTextField.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (LGFTextField)

#pragma mark - 左侧距离
@property (assign , nonatomic) IBInspectable CGFloat lgf_LeftSpace;

@property (assign , nonatomic) IBInspectable CGFloat lgf_RightSpace;

#pragma mark - UITextField输入长度限制
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

#pragma mark - 设置所有选中的文字
- (void)lgf_SelectAllText;

#pragma mark - 在所选范围内设置文本
/**
   @param range 文档中选定文本的范围。
 */
- (void)lgf_SetSelectedRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
