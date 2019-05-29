//
//  NSMutableDictionary+LGFMutableDictionary.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (LGFMutableDictionary)

#pragma mark - 从指定的属性列表plist文件数据创建和返回字典
/**
 @param plist 根目录为字典的plist文件.
 @return 从根目录为数组的plist文件创建的新字典，如果发生错误则返回nil.
 */
+ (nullable NSMutableDictionary *)lgf_DictionaryWithPlistData:(NSData *)plist;

#pragma mark - 从指定的属性列表XML字符串创建并返回字典
/**
 @param plist 属性列表XML字符串，其根对象是字典.
 @return 从属性列表XML字符串创建的新字典，如果发生错误则返回nil.
 */
+ (nullable NSMutableDictionary *)lgf_DictionaryWithPlistString:(NSString *)plist;


/**
 Removes and returns the value associated with a given key.
 
 @param aKey The key for which to return and remove the corresponding value.
 @return The value associated with aKey, or nil if no value is associated with aKey.
 */
- (nullable id)lgf_PopObjectForKey:(id)aKey;

/**
 Returns a new dictionary containing the entries for keys, and remove these
 entries from reciever. If the keys is empty or nil, it just returns an
 empty dictionary.
 
 @param keys The keys.
 @return The entries for the keys.
 */
- (NSDictionary *)lgf_PopEntriesForKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END
