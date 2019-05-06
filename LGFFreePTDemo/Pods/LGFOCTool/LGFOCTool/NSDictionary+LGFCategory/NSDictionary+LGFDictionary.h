//
//  NSDictionary+LGFDictionary.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (LGFDictionary)

#pragma mark - 从指定的属性列表plist文件数据创建和返回字典
/**
 @param plist 根目录为字典的plist文件.
 @return 从根目录为数组的plist文件创建的新字典，如果发生错误则返回nil.
 */
+ (nullable NSDictionary *)lgf_DictionaryWithPlistData:(NSData *)plist;

#pragma mark - 从指定的属性列表XML字符串创建并返回字典
/**
 @param plist 属性列表XML字符串，其根对象是字典.
 @return 从xml属性列表字符串创建的新字典，如果发生错误则返回nil.
 */
+ (nullable NSDictionary *)lgf_DictionaryWithPlistString:(NSString *)plist;

#pragma mark - 将字典序列化为二进制属性列表数据
/**
 @return bplist数据，如果发生错误则为nil.
 @discussion 苹果已经实施了这种方法，但并未公开.
 */
- (nullable NSData *)lgf_PlistData;

#pragma mark - 将字典序列化为xml属性列表字符串
/**
 @return xml属性列表字符串，如果发生错误则为ni.
 */
- (nullable NSString *)lgf_PlistString;

#pragma mark - 返回一个新数组，其中包含已排序的字典键, 键应该是NSString, 并且它们将按升序排序
/**
 @return 一个包含字典键的新数组, 或者如果字典没有项, 则为空数组
 */
- (NSArray *)lgf_AllKeysSorted;

#pragma mark - 返回包含按键排序的字典值的新数组
/**
 数组中值的顺序由键定义, 键应该是NSString, 并且它们将按升序排序
 @return 包含按键排序的字典值的新数组, 或者如果字典没有条目, 则为空数组
 */
- (NSArray *)lgf_AllValuesSortedByKeys;

#pragma mark - 返回一个BOOL值告诉字典是否有一个key的对象
/**
 @param key 要检测的 key
 */
- (BOOL)lgf_ContainsObjectForKey:(id)key;

#pragma mark - 返回包含键的条目的新字典, 如果键是空的或无, 它只是返回一个空字典
/**
 @param keys 键数组.
 @return 包含键的条目的新字典
 */
- (NSDictionary *)lgf_EntriesForKeys:(NSArray *)keys;

#pragma mark -  尝试解析XML并将其包装到字典中. 如果你只是想从一个小的XML获得一些价值, 试试这个.
/**
 // 例子
 example XML: "<config><a href="test.com">link</a></config>"
 example Return: @{@"_name":@"config", @"a":{@"_text":@"link",@"href":@"test.com"}}
 @param xmlDataOrString NSData或NSString格式的XML。
 @return 返回一个新的字典, 如果发生错误则返回nil
 */
+ (nullable NSDictionary *)lgf_DictionaryWithXML:(id)xmlDataOrString;

#pragma mark - Dictionary Value Getter
- (BOOL)lgf_BoolValueForKey:(NSString *)key default:(BOOL)def;

- (char)lgf_CharValueForKey:(NSString *)key default:(char)def;
- (unsigned char)lgf_UnsignedCharValueForKey:(NSString *)key default:(unsigned char)def;

- (short)lgf_ShortValueForKey:(NSString *)key default:(short)def;
- (unsigned short)lgf_UnsignedShortValueForKey:(NSString *)key default:(unsigned short)def;

- (int)lgf_IntValueForKey:(NSString *)key default:(int)def;
- (unsigned int)lgf_UnsignedIntValueForKey:(NSString *)key default:(unsigned int)def;

- (long)lgf_LongValueForKey:(NSString *)key default:(long)def;
- (unsigned long)lgf_UnsignedLongValueForKey:(NSString *)key default:(unsigned long)def;

- (long long)lgf_LongLongValueForKey:(NSString *)key default:(long long)def;
- (unsigned long long)lgf_UnsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def;

- (float)lgf_FloatValueForKey:(NSString *)key default:(float)def;
- (double)lgf_DoubleValueForKey:(NSString *)key default:(double)def;

- (NSInteger)lgf_IntegerValueForKey:(NSString *)key default:(NSInteger)def;
- (NSUInteger)lgf_UnsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def;

- (nullable NSNumber *)lgf_NumberValueForKey:(NSString *)key default:(nullable NSNumber *)def;
- (nullable NSString *)lgf_StringValueForKey:(NSString *)key default:(nullable NSString *)def;

@end

NS_ASSUME_NONNULL_END
