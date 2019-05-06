//
//  NSMutableArray+LGFMutableArray.h
//  LGFOCTool
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (LGFMutableArray)

#pragma mark - 数组填充 column - (self.count % column) 个空占位字符串
/**
 @param column 列数
 */
- (void)lgf_ArraySupplementInteger:(int)column;

#pragma mark - 从指定的属性列表plist文件数据创建和返回数组
/**
 @param plist 根目录为数组的plist文件.
 @return 从根目录为数组的plist文件创建的新数组，如果发生错误则返回nil.
 */
+ (nullable NSMutableArray *)lgf_ArrayWithPlistData:(NSData *)plist;

#pragma mark - 从指定的属性列表XML字符串创建并返回数组
/**
 @param plist xml属性列表字符串，其根对象是数组.
 @return 从xml属性列表字符串创建的新数组，如果发生错误则返回nil.
 */
+ (nullable NSMutableArray *)lgf_ArrayWithPlistString:(NSString *)plist;

#pragma mark - 移除数组中具有最低值索引的对象 如果数组为空，则此方法无效
/**
 @discussion Apple已经实施了这一方法，但没有公开.
 安全覆盖.
 */
- (void)lgf_RemoveFirstObject;

#pragma mark - 移除数组中具有最高值索引的对象 如果数组为空，则此方法无效
/**
 @discussion Apple的实现称，如果数组是空的，但实际上什么都不会发生.
 安全覆盖.
 */
- (void)lgf_RemoveLastObject;

#pragma mark - 移除并返回数组中具有最低值索引的对象 如果数组是空的，返回nil
/**
 @return 最低值索引的对象 或者 nil.
 */
- (nullable id)lgf_PopFirstObject;

#pragma mark - 移除并返回数组中具有最高值索引的对象 如果数组是空的，返回nil
/**
 @return 最高值索引的对象 或者 nil.
 */
- (nullable id)lgf_PopLastObject;

#pragma mark - 在数组的末尾插入给定的对象
/**
 @param anObject 添加到数组内容末尾的对象.
 此值不得为nil.如果对象为nil，则引发NSimuldAguMutEnter异常.
 */
- (void)lgf_AppendObject:(id)anObject;

#pragma mark - 在数组的开头插入给定的对象
/**
 @param anObject 添加到数组内容开头的对象.
 此值不得为nil.如果对象为nil，则引发NSimuldAguMutEnter异常.
 */
- (void)lgf_PrependObject:(id)anObject;

#pragma mark - 在数组的末尾插入给定的对象数组
/**
 @param objects 要添加到接收数组末尾的对象数组.
 如果对象为nil或count为0，则此方法没有效果.
 */
- (void)lgf_AppendObjects:(NSArray *)objects;

#pragma mark - 在数组的开头插入给定的对象数组
/**
 @param objects 要添加到接收数组开头的对象数组.
 如果对象为nil或count为0，则此方法没有效果.
 */
- (void)lgf_PrependObjects:(NSArray *)objects;

#pragma mark - 在接收数组的索引中添加另一个对象数组中包含的对象
/**
 @param objects 要添加到接收数组指定索引的对象数组.
 @param index 数组中插入对象的索引.
 这个值必须不大于数组中元素的计数.提出一个
 如果索引大于数组中元素的数量，则NSRangeExp异常.
 */
- (void)lgf_InsertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

#pragma mark - 在这个数组中反转对象的索引
/**
 例子: Before @[ @1, @2, @3 ], After @[ @3, @2, @1 ].
 */
- (void)lgf_Reverse;

#pragma mark - 对数组中的对象进行随机排序
- (void)lgf_Shuffle;

#pragma mark - 快速创建一个相同元素的数组
- (NSMutableArray *)lgf_CreatDentical:(id)object count:(NSInteger)count;

#pragma mark - 创建一个index数组
- (NSMutableArray *)lgf_CreatIndexArr:(NSInteger)count;
- (NSMutableArray *)lgf_CreatNumberIndexArr:(NSInteger)count;

#pragma mark - 删除数组中所有该元素
- (void)lgf_RemoveAllThisObject:(id)object;
@end

NS_ASSUME_NONNULL_END
