//
//  UILabel+LGFLable.m
//  LGFOCTool
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UILabel+LGFLable.h"
#import "LGFOCTool.h"

@implementation UILabel (LGFLable)

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
    [attribute addAttribute:NSForegroundColorAttributeName value:self.textColor range:[self.text rangeOfString:self.text]];
    // 添加属性(粗体)
    [attribute addAttribute:NSFontAttributeName value:font range:range];
    // 关键字高亮
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    // 将带属性的字符串添加到cell.textLabel上.
    [self setAttributedText:attribute];
}
/**
 @param texts 高亮关键字数组
 */
- (void)lgf_KeywordHighlightTexts:(NSArray *)texts {
    // 获取关键字的位置
    NSArray *ranges = [self rangeOfSubString:texts inString:self.text];
    // 转换成可以操作的字符串类型.
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.text];
    [ranges enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 添加属性(粗体)
        [attribute addAttribute:NSFontAttributeName value:[UIFont fontWithName:self.font.fontName size:[obj[@"font"] floatValue]] range:[obj[@"range"] rangeValue]];
        // 关键字高亮
        [attribute addAttribute:NSForegroundColorAttributeName value:lgf_HexColor(obj[@"color"]) range:[obj[@"range"] rangeValue]];
    }];
    // 将带属性的字符串添加到cell.textLabel上.
    [self setAttributedText:attribute];
}

- (NSArray*)rangeOfSubString:(NSArray *)texts inString:(NSString*)string {
    NSMutableArray *rangeArray = [NSMutableArray array];
    [texts enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull subStrDict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *subStr = subStrDict[@"text"];
        NSString *string1 = [string stringByAppendingString:subStr];
        
        NSString *temp;
        for(int i = 0; i < string.length; i ++) {
            temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
            if ([temp isEqualToString:subStr]) {
                NSRange range = {i, subStr.length};
                [rangeArray addObject:@{@"range" : [NSValue valueWithRange:range], @"color" : subStrDict[@"color"], @"font" : (subStrDict[@"font"] ? subStrDict[@"font"] : @(self.font.pointSize))}];
            }
        }
        // @""字符串高亮
        if ([subStr isEqualToString:@"@(\"([^\"]*)\")"]) {
            NSError *error = nil;
            NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:subStr options:NSRegularExpressionCaseInsensitive error:&error];
            [regularExp enumerateMatchesInString:self.text options:NSMatchingReportProgress range:NSMakeRange(0, self.text.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                if (result) {
                    [rangeArray addObject:@{@"range" : [NSValue valueWithRange:result.range], @"color" : subStrDict[@"color"], @"font" : (subStrDict[@"font"] ? subStrDict[@"font"] : @(self.font.pointSize))}];
                }
            }];
        }
        
    }];
    return rangeArray;
}
@end
