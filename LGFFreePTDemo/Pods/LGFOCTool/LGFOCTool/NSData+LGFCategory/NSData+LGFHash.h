//
//  NSData+LGFHash.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (LGFHash) // nsdata 加密

#pragma mark - 返回 md2 加密字符串
- (NSString *)lgf_Md2String;

#pragma mark - 返回 md2 加密数据
- (NSData *)lgf_Md2Data;

#pragma mark - 返回 md4 加密字符串
- (NSString *)lgf_Md4String;

#pragma mark - 返回 md4 加密数据
- (NSData *)lgf_Md4Data;

#pragma mark - 返回 md5 加密字符串
- (NSString *)lgf_Md5String;

#pragma mark - 返回 md5 加密数据
- (NSData *)lgf_Md5Data;

#pragma mark - 返回 sha1 加密字符串
- (NSString *)lgf_Sha1String;

#pragma mark - 返回 sha1 加密数据
- (NSData *)lgf_Sha1Data;

#pragma mark - 返回 sha224 加密字符串
- (NSString *)lgf_Sha224String;

#pragma mark - 返回 sha224 加密数据
- (NSData *)lgf_Sha224Data;

#pragma mark - 返回 sha256 加密字符串
- (NSString *)lgf_Sha256String;

#pragma mark - 返回 sha256 加密数据
- (NSData *)lgf_Sha256Data;

#pragma mark - 返回 sha384 加密字符串
- (NSString *)lgf_Sha384String;

#pragma mark - 返回 sha384 加密数据
- (NSData *)lgf_Sha384Data;

#pragma mark - 返回 sha512 加密字符串
- (NSString *)lgf_Sha512String;

#pragma mark - 返回 sha512 加密数据
- (NSData *)lgf_Sha512Data;

#pragma mark - 返回 hmac+md5 加密字符串
/**
 @param key hmac 密匙.
 */
- (NSString *)lgf_HmacMD5StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+md5 加密数据
/**
 @param key hmac 密匙.
 */
- (NSData *)lgf_HmacMD5DataWithKey:(NSData *)key;

#pragma mark - 返回 hmac+sha1 加密字符串
/**
 @param key hmac 密匙.
 */
- (NSString *)lgf_HmacSHA1StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha1 加密数据
/**
 @param key hmac 密匙.
 */
- (NSData *)lgf_HmacSHA1DataWithKey:(NSData *)key;

#pragma mark - 返回 hmac+sha224 加密字符串
/**
 @param key hmac 密匙.
 */
- (NSString *)lgf_HmacSHA224StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha224 加密数据
/**
 @param key hmac 密匙.
 */
- (NSData *)lgf_HmacSHA224DataWithKey:(NSData *)key;

#pragma mark - 返回 hmac+sha256 加密字符串
/**
 @param key hmac 密匙.
 */
- (NSString *)lgf_HmacSHA256StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha256 加密数据
/**
 @param key hmac 密匙.
 */
- (NSData *)lgf_HmacSHA256DataWithKey:(NSData *)key;

#pragma mark - 返回 hmac+sha384 加密字符串
/**
 @param key hmac 密匙.
 */
- (NSString *)lgf_HmacSHA384StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha384 加密数据
/**
 @param key hmac 密匙.
 */
- (NSData *)lgf_HmacSHA384DataWithKey:(NSData *)key;

#pragma mark - 返回 hmac+sha512 加密字符串
/**
 @param key hmac 密匙.
 */
- (NSString *)lgf_HmacSHA512StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha512 加密数据
/**
 @param key hmac 密匙.
 */
- (NSData *)lgf_HmacSHA512DataWithKey:(NSData *)key;

#pragma mark - 返回 crc32 加密字符串
- (NSString *)lgf_Crc32String;

#pragma mark - 返回 crc32 加密数据
- (uint32_t)lgf_Crc32;

@end
