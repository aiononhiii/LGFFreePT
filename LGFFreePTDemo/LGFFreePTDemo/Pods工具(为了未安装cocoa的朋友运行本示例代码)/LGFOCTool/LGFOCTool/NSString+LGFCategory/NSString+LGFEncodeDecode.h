//
//  NSString+LGFEncodeDecode.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LGFEncodeDecode)

#pragma mark - 返回base64编码的NSString
- (nullable NSString *)lgf_Base64EncodedString;

#pragma mark - 从base64编码的字符串返回一个NSString。
/**
 @param base64EncodedString base64编码的字符串
 */
+ (nullable NSString *)lgf_StringWithBase64EncodedString:(NSString *)base64EncodedString;

#pragma mark - URL以utf-8编码一个字符串
- (NSString *)lgf_StringByURLEncode;

#pragma mark - URL以utf-8解码一个字符串
- (NSString *)lgf_StringByURLDecode;

#pragma mark - 将常见的HTML转义为实体
/**
 示例: "a>b" will be escape to "a&gt;b".
 */
- (NSString *)lgf_StringByEscapingHTML;

@end

NS_ASSUME_NONNULL_END
