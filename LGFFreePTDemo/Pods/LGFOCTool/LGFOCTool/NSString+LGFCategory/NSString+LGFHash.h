//
//  NSString+LGFHash.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LGFHash)

#pragma mark - 返回 md2 加密字符串
- (nullable NSString *)lgf_Md2String;

#pragma mark - 返回 md4 加密字符串
- (nullable NSString *)lgf_Md4String;

#pragma mark - 返回 md5 加密字符串
- (nullable NSString *)lgf_Md5String;

#pragma mark - 返回 sha1 加密字符串
- (nullable NSString *)lgf_Sha1String;

#pragma mark - 返回 sha224 加密字符串
- (nullable NSString *)lgf_Sha224String;

#pragma mark - 返回 sha256 加密字符串
- (nullable NSString *)lgf_Sha256String;

#pragma mark - 返回 sha384 加密字符串
- (nullable NSString *)lgf_Sha384String;

#pragma mark - 返回 sha512 加密字符串
- (nullable NSString *)lgf_Sha512String;

#pragma mark - 返回 hmac+md5 加密字符串
/**
 @param key hmac 密匙.
 */
- (nullable NSString *)lgf_HmacMD5StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha1 加密字符串
/**
 @param key hmac 密匙.
 */
- (nullable NSString *)lgf_HmacSHA1StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha224 加密字符串
/**
 @param key hmac 密匙.
 */
- (nullable NSString *)lgf_HmacSHA224StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha256 加密字符串
/**
 @param key hmac 密匙.
 */
- (nullable NSString *)lgf_HmacSHA256StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha384 加密字符串
/**
 @param key hmac 密匙.
 */
- (nullable NSString *)lgf_HmacSHA384StringWithKey:(NSString *)key;

#pragma mark - 返回 hmac+sha512 加密字符串
/**
 @param key hmac 密匙.
 */
- (nullable NSString *)lgf_HmacSHA512StringWithKey:(NSString *)key;

#pragma mark - 返回 crc32 加密字符串
- (nullable NSString *)lgf_Crc32String;

@end

NS_ASSUME_NONNULL_END
