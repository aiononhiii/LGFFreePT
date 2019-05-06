//
//  NSData+EncodeDecode.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (LGFEncodeDecode)// nsdata 编码解码

#pragma mark - 返回 UTF8 解码后的字符串
- (nullable NSString *)lgf_Utf8String;

#pragma mark - 返回 十六进制(HEX)大写字符串
- (nullable NSString *)lgf_HexString;

#pragma mark - 十六进制(HEX)字符串转NSData数据
/**
 @param hexString 十六进制(HEX)字符串
 @return 转换后的数据
 */
+ (nullable NSData *)lgf_DataWithHexString:(NSString *)hexString;

#pragma mark - 返回 base64 编码字符串
- (nullable NSString *)lgf_Base64EncodedString;

#pragma mark - base64 编码字符串 转 NSData数据
/**
 @warning 此方法已在iOS7中使用.
 @param  base64EncodedString base64 编码字符串.
 @return NSData数据
 */
+ (nullable NSData *)lgf_DataWithBase64EncodedString:(NSString *)base64EncodedString;

#pragma mark - 解码自己(self) 返回NSDictionary或NSArray 如果发生错误返回nil
- (nullable id)lgf_JsonValueDecoded;

@end

NS_ASSUME_NONNULL_END
