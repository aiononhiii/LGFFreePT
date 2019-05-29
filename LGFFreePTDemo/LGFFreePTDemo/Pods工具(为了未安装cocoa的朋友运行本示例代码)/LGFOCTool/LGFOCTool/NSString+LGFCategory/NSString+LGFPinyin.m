//
//  NSString+LGFPinyin.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "NSString+LGFPinyin.h"

@implementation NSString (LGFPinyin)

#pragma mark - 取得字符串拼音带音标
- (NSString*)lgf_PinyinWithPhoneticSymbol{
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

#pragma mark - 取得字符串拼音
- (NSString*)lgf_Pinyin{
    NSMutableString *pinyin = [NSMutableString stringWithString:[self lgf_PinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

#pragma mark - 取得字符串拼音数组
- (NSArray*)lgf_PinyinArray{
    NSArray *array = [[self lgf_Pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return array;
}

#pragma mark - 去除字符串拼音中的空格
- (NSString*)lgf_PinyinWithoutBlank{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in [self lgf_PinyinArray]) {
        [string appendString:str];
    }
    return string;
}

#pragma mark - 取得字符串拼音首字母数组
- (NSArray*)lgf_PinyinInitialsArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in [self lgf_PinyinArray]) {
        if ([str length] > 0) {
            [array addObject:[str substringToIndex:1]];
        }
    }
    return array;
}

#pragma mark - 取得字符串拼音首字母字符串
- (NSString*)lgf_PinyinInitialsString{
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    for (NSString *str in [self lgf_PinyinArray]) {
        if ([str length] > 0) {
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    return pinyin;
}

@end
