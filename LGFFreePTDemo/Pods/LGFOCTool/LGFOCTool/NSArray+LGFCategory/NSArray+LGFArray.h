//
//  NSArray+LGFArray.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (LGFArray)

#pragma mark - 从指定的属性列表plist文件数据创建和返回数组
/**
 @param plist 根目录为数组的plist文件.
 @return 从根目录为数组的plist文件创建的新数组，如果发生错误则返回nil.
 */
+ (nullable NSArray *)lgf_ArrayWithPlistData:(NSData *)plist;

#pragma mark - 从指定的属性列表XML字符串创建并返回数组
/**
 @param plist xml属性列表字符串，其根对象是数组.
 @return 从xml属性列表字符串创建的新数组，如果发生错误则返回nil.
 */
+ (nullable NSArray *)lgf_ArrayWithPlistString:(NSString *)plist;

#pragma mark - 将数组序列化为二进制plist属性列表数据
/**
 @return Bplist数据，如果发生错误返回nil.
 */
- (nullable NSData *)lgf_PlistData;

#pragma mark - 将数组序列化为属性列表XML字符串
/**
 @return plist XML字符串, 如果发生错误则返回nil.
 */
- (nullable NSString *)lgf_PlistString;

#pragma mark - 返回位于数组中随机索引的对象
/**
 @return 数组中随机索引值的对象, 如果数组为空，则返回nil.
 */
- (nullable id)lgf_RandomObject;

#pragma mark - (防止越界)返回指定索引处的对象，或在越界时则返回nil. 它类似于'ObjtAtCurdie:'，但它从不抛出异常.
/**
 @param index 指定的索引.
 */
- (nullable id)lgf_ObjectOrNilAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
