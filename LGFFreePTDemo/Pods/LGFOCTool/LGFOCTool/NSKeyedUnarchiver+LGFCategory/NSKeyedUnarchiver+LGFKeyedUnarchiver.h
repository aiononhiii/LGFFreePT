//
//  NSKeyedUnarchiver+LGFKeyedUnarchiver.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSKeyedUnarchiver (LGFKeyedUnarchiver)

#pragma mark - 和unarchiveObjectWithData一样, 但通过引用返回异常
/**
 // [NSKeyedArchiver archivedDataWithRootObject:data]
 @param data       归档对象数据.
 @param exception  如果发生异常，将在返回时返回指针
   所述指针不为NULL，指向所述NSException
 */
+ (nullable id)lgf_UnarchiveObjectWithData:(NSData *)data
                             exception:(NSException *_Nullable *_Nullable)exception;

#pragma mark - 和unarchiveObjectWithFile一样, 但通过引用返回异常
/**
 @param path       归档对象文件的路径.
 @param exception  如果发生异常，将在返回时返回指针
   所述指针不为NULL，指向所述NSException
 */
+ (nullable id)lgf_UnarchiveObjectWithFile:(NSString *)path
                             exception:(NSException *_Nullable *_Nullable)exception;

@end

NS_ASSUME_NONNULL_END
