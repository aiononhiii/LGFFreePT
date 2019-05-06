//
//  NSString+LGFRegex.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

/**
 *  正则表达式简单说明
 *  语法：
 .       匹配除换行符以外的任意字符
 \w      匹配字母或数字或下划线或汉字
 \s      匹配任意的空白符
 \d      匹配数字
 \b      匹配单词的开始或结束
 ^       匹配字符串的开始
 $       匹配字符串的结束
 *       重复零次或更多次
 +       重复一次或更多次
 ?       重复零次或一次
 {n}     重复n次
 {n,}     重复n次或更多次
 {n,m}     重复n到m次
 \W      匹配任意不是字母，数字，下划线，汉字的字符
 \S      匹配任意不是空白符的字符
 \D      匹配任意非数字的字符
 \B      匹配不是单词开头或结束的位置
 [^x]     匹配除了x以外的任意字符
 [^aeiou]匹配除了aeiou这几个字母以外的任意字符
 *?      重复任意次，但尽可能少重复
 +?      重复1次或更多次，但尽可能少重复
 ??      重复0次或1次，但尽可能少重复
 {n,m}?     重复n到m次，但尽可能少重复
 {n,}?     重复n次以上，但尽可能少重复
 \a      报警字符(打印它的效果是电脑嘀一声)
 \b      通常是单词分界位置，但如果在字符类里使用代表退格
 \t      制表符，Tab
 \r      回车
 \v      竖向制表符
 \f      换页符
 \n      换行符
 \e      Escape
 \0nn     ASCII代码中八进制代码为nn的字符
 \xnn     ASCII代码中十六进制代码为nn的字符
 \unnnn     Unicode代码中十六进制代码为nnnn的字符
 \cN     ASCII控制字符。比如\cC代表Ctrl+C
 \A      字符串开头(类似^，但不受处理多行选项的影响)
 \Z      字符串结尾或行尾(不受处理多行选项的影响)
 \z      字符串结尾(类似$，但不受处理多行选项的影响)
 \G      当前搜索的开头
 \p{name}     Unicode中命名为name的字符类，例如\p{IsGreek}
 (?>exp)     贪婪子表达式
 (?<x>-<y>exp)     平衡组
 (?im-nsx:exp)     在子表达式exp中改变处理选项
 (?im-nsx)       为表达式后面的部分改变处理选项
 (?(exp)yes|no)     把exp当作零宽正向先行断言，如果在这个位置能匹配，使用yes作为此组的表达式；否则使用no
 (?(exp)yes)     同上，只是使用空表达式作为no
 (?(name)yes|no) 如果命名为name的组捕获到了内容，使用yes作为表达式；否则使用no
 (?(name)yes)     同上，只是使用空表达式作为no
 
 捕获
 (exp)               匹配exp,并捕获文本到自动命名的组里
 (?<name>exp)        匹配exp,并捕获文本到名称为name的组里，也可以写成(?'name'exp)
 (?:exp)             匹配exp,不捕获匹配的文本，也不给此分组分配组号
 零宽断言
 (?=exp)             匹配exp前面的位置
 (?<=exp)            匹配exp后面的位置
 (?!exp)             匹配后面跟的不是exp的位置
 (?<!exp)            匹配前面不是exp的位置
 注释
 (?#comment)         这种类型的分组不对正则表达式的处理产生任何影响，用于提供注释让人阅读
 
 *  表达式：\(?0\d{2}[) -]?\d{8}
 *  这个表达式可以匹配几种格式的电话号码，像(010)88886666，或022-22334455，或02912345678等。
 *  我们对它进行一些分析吧：
 *  首先是一个转义字符\(,它能出现0次或1次(?),然后是一个0，后面跟着2个数字(\d{2})，然后是)或-或空格中的一个，它出现1次或不出现(?)，
 *  最后是8个数字(\d{8})
 */

#import <Foundation/Foundation.h>

@interface NSString (LGFRegex)

#pragma mark - 手机号有效性
- (BOOL)lgf_IsMobilePhoneNumber;

#pragma mark - 固定电话有效性
- (BOOL)lgf_IsTelephoneNumeber;

#pragma mark - 邮箱的有效性
- (BOOL)lgf_IsEmailAddress;

#pragma mark - 身份证有效性
- (BOOL)lgf_IsIdentityCardNum;

#pragma mark - 精确的身份证号码有效性检测
/**
 *  @param value 身份证号
 */
+ (BOOL)lgf_AccurateVerifyIDCardNumber:(NSString *)value;

#pragma mark - 车牌号的有效性
- (BOOL)lgf_IsCarNumber;

#pragma mark - 银行卡的有效性
- (BOOL)lgf_IsBankCardNum;

#pragma mark - IP地址有效性
- (BOOL)lgf_IsIPAddress;

#pragma mark - Mac地址有效性
- (BOOL)lgf_IsMacAddress;

#pragma mark - 网址有效性
- (BOOL)lgf_IsValidUrl;

#pragma mark - 字符串全部是汉字
- (BOOL)lgf_IsValidChinese;

#pragma mark - 邮政编码有效性
- (BOOL)lgf_IsValidPostalcode;

#pragma mark - 工商税号有效性
- (BOOL)lgf_IsValidTaxNo;

#pragma mark - 账号特殊判断 是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)lgf_IsValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

#pragma mark - 账号特殊判断 是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)lgf_IsValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

#pragma mark - 是否是整型
- (BOOL)lgf_IsPureInt;

#pragma mark - 是否是浮点型
- (BOOL)lgf_IsPureFloat;

#pragma mark - 是否可以匹配某个正则表达式
/**
 @param regex  正则表达式
 @param options  要报告的匹配选项.
 @return 如果可以匹配正则表达式 返回 YES 反之 NO.
 */
- (BOOL)lgf_MatchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options;

#pragma mark - 匹配正则表达式，并使用匹配中的每个对象执行给定的块
/**
 @param regex    正则表达式
 @param options  要报告的匹配选项
 @param block    要应用于匹配数组中元素的块
 该块有四个参数:
 match: 匹配子字符串.
 matchRange: 匹配选项.
 stop: 对布尔值的引用。 该块可以设置值
   设置为YES以停止进一步处理阵列。 停止
   论点是一个唯一的论点。 你只应该设置
   这个布尔值在块内为YES.
 */
- (void)lgf_EnumerateRegexMatches:(NSString *)regex
                      options:(NSRegularExpressionOptions)options
                   usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block;

#pragma mark - 返回一个新的字符串，其中包含用模板字符串替换的正则表达式
/**
 @param regex       正则表达式
 @param options     要报告的匹配选项
 @param replacement 替换匹配实例时使用的替换模板
 @return 匹配正则表达式的字符串，由模板字符串替换
 */
- (NSString *)lgf_StringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement;

@end
