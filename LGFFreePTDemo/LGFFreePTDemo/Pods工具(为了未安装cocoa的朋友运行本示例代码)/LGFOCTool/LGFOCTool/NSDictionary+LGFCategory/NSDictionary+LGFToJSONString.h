//
//  NSDictionary+LGFToJSONString.h
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (LGFToJSONString)

#pragma mark - 字典转 JSON字符串

- (nullable NSString *)lgf_DictionaryToJson;

#pragma mark - 字典转 格式化JSON字符串
- (nullable NSString *)lgf_DictionaryToJsonPrettyString;

#pragma mark - 字典转 JSON字符串

- (nullable NSString *)lgf_DictionaryToJsonTwo;

#pragma mark - 字典转 urlEncoded字符串

- (nullable NSString *)lgf_UrlEncodedKeyValueString;

#pragma mark - JSON字符串转字典

+ (nullable NSDictionary *)lgf_DictFromString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
