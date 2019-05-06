//
//  NSData+LGFData.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (LGFData)

#pragma mark - 从主包中的文件创建数据 (类似于 [UIImage imageNamed:]).
/**
 @param name 文件名称 (该文件必须在主包中).
 @return 文件数据.
 */
+ (nullable NSData *)lgf_DataNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
