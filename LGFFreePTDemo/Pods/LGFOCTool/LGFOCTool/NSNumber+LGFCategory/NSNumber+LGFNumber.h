//
//  NSNumber+LGFNumber.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (LGFNumber)

#pragma mark - 从字符串中创建并返回一个NSNumber对象
/**
 有效的格式: @"12", @"12.345", @" -0xFF", @" .23e99 "...
 @param string 该字符串描述了一个数字
 @return 解析成功时为NSNumber, 如果发生错误则为nil.
 */
+ (nullable NSNumber *)lgf_NumberWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
