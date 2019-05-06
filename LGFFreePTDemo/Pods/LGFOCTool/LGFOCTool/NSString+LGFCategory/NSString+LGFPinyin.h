//
//  NSString+LGFPinyin.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGFPinyin)

#pragma mark - 取得字符串拼音带音标
- (NSString*)lgf_PinyinWithPhoneticSymbol;

#pragma mark - 取得字符串拼音
- (NSString*)lgf_Pinyin;

#pragma mark - 取得字符串拼音数组
- (NSArray*)lgf_PinyinArray;

#pragma mark - 去除字符串拼音中的空格
- (NSString*)lgf_PinyinWithoutBlank;

#pragma mark - 取得字符串拼音首字母数组
- (NSArray*)lgf_PinyinInitialsArray;

#pragma mark - 取得字符串拼音首字母字符串
- (NSString*)lgf_PinyinInitialsString;

@end
