//
//  UILabel+LGFLable.h
//  LGFOCTool
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LGFLable)

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
