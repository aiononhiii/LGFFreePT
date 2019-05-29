//
//  NSString+LGFTrims.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGFTrims)

#pragma mark - 清除html标签
- (NSString *)lgf_StringByStrippingHTML;

#pragma mark - 清除js脚本
- (NSString *)lgf_StringByRemovingScriptsAndStrippingHTML;

#pragma mark - 去除空格
- (NSString *)lgf_TrimmingWhitespace;

#pragma mark - 去除字符串与空行
- (NSString *)lgf_TrimmingWhitespaceAndNewlines;

@end
