//
//  NSData+LGFEncryptDecrypt.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (LGFEncryptDecrypt)

#pragma mark - 使用AES返回加密的NSData
/**
 @param key   密钥长度为16,24或32（128,192或256位）
 @param iv    初始化向量长度为16（128位）当你不想使用iv时忽略nil.
 @return      加密后的NSData，如果发生错误则为nil。
 */
- (nullable NSData *)lgf_Aes256EncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

#pragma mark - 使用AES返回解密的NSData
/**
 @param key   密钥长度为16,24或32（128,192或256位）
 @param iv    初始化向量长度为16（128位）当你不想使用iv时忽略nil.
 @return      解密后的NSData，如果发生错误则为nil。
 */
- (nullable NSData *)lgf_Aes256DecryptWithkey:(NSData *)key iv:(nullable NSData *)iv;

@end

NS_ASSUME_NONNULL_END
