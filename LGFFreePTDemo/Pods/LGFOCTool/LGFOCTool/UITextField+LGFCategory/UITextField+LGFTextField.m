//
//  UITextField+LGFTextField.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UITextField+LGFTextField.h"
#import <objc/runtime.h>

static const char *lgf_LeftSpaceKey = "lgf_LeftSpaceKey";
static const char *lgf_RightSpaceKey = "lgf_RightSpaceKey";

@implementation UITextField (LGFTextField)

@dynamic lgf_LeftSpace;

#pragma mark - 左侧距离
- (void)setLgf_LeftSpace:(CGFloat)lgf_LeftSpace {
    objc_setAssociatedObject(self, &lgf_LeftSpaceKey, [NSNumber numberWithFloat:lgf_LeftSpace], OBJC_ASSOCIATION_ASSIGN);
    if (lgf_LeftSpace && lgf_LeftSpace > 0) {
        [self.leftView removeFromSuperview];
        self.leftView = nil;
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, lgf_LeftSpace, self.frame.size.height)];
        leftView.backgroundColor = [UIColor clearColor];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
}

- (CGFloat)lgf_LeftSpace {
    return [objc_getAssociatedObject(self, &lgf_LeftSpaceKey) floatValue];
}

- (void)setLgf_RightSpace:(CGFloat)lgf_RightSpace {
    objc_setAssociatedObject(self, &lgf_RightSpaceKey, [NSNumber numberWithFloat:lgf_RightSpace], OBJC_ASSOCIATION_ASSIGN);
    if (lgf_RightSpace && lgf_RightSpace > 0) {
        [self.rightView removeFromSuperview];
        self.rightView = nil;
        UILabel *rightView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, lgf_RightSpace, self.frame.size.height)];
        rightView.backgroundColor = [UIColor clearColor];
        self.rightView = rightView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}

- (CGFloat)lgf_RightSpace {
    return [objc_getAssociatedObject(self, &lgf_RightSpaceKey) floatValue];
}

#pragma mark - UITextField输入长度限制
/**
 @param maxLength 限制的长度
 */
- (void)lgf_LimitIncludeForLength:(NSUInteger)maxLength {
    NSString *toBeString = self.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > maxLength) {
                self.text = [toBeString substringToIndex:maxLength];
            }
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > maxLength) {
            self.text = [toBeString substringToIndex:maxLength];
        }
    }
}

#pragma mark - 关键字高亮
/**
 @param color 关键字高亮颜色
 @param text 高亮关键字
 */
- (void)lgf_KeywordHighlightColor:(UIColor *)color text:(NSString *)text {
    return [self lgf_KeywordHighlightColor:color font:self.font text:text];
}
/**
 @param color 关键字高亮颜色
 @param font 关键字字体
 @param text 高亮关键字
 */
- (void)lgf_KeywordHighlightColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text {
    // 获取关键字的位置
    NSRange range = [self.text rangeOfString:text];
    // 转换成可以操作的字符串类型.
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.text];
    // 添加属性(粗体)
    [attribute addAttribute:NSFontAttributeName value:font range:range];
    // 关键字高亮
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    // 将带属性的字符串添加到cell.textLabel上.
    [self setAttributedText:attribute];
}

- (void)lgf_SelectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)lgf_SetSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end
