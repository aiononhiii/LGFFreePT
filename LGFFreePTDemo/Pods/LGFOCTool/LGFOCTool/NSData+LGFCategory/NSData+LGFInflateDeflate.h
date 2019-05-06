//
//  NSData+LGFInflateDeflate.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (LGFInflateDeflate) // nsdata 压缩解压

#pragma mark - gzip 解压缩
/**
 @return 解压的数据.
 */
- (nullable NSData *)lgf_GzipInflate;

#pragma mark - gzip 压缩
/**
 @return 压缩的数据.
 */
- (nullable NSData *)lgf_GzipDeflate;

#pragma mark - zlib 解压缩
/**
 @return 解压的数据.
 */
- (nullable NSData *)lgf_ZlibInflate;

#pragma mark - zlib 压缩
/**
 @return 压缩的数据.
 */
- (nullable NSData *)lgf_ZlibDeflate;

@end

NS_ASSUME_NONNULL_END
