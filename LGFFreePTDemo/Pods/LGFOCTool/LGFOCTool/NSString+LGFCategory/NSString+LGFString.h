//
//  NSString+LGFString.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFPch.h"

typedef NS_ENUM(NSUInteger, lgf_UnitStrType) {
    lgf_SmallPinyin,// 小写拼音 (q w y)
    lgf_BigPinyin,// 大写拼音 (Q W Y)
    lgf_CCharacter,// 汉字 (千 万 亿)
};

typedef NS_ENUM(NSUInteger, lgf_UnitType) {
    lgf_OnlyWan,// 只带 万（0.5万 10万 10000万）
    lgf_OnlyQian,// 只带 千 (5千 100千 100000千）
    lgf_QianAndWan,// 带 千和万 (5千 10万 10000万）
    lgf_WanAndYi,// 带 万和亿 (0.5万 10万 10000万）
    lgf_QianAndWanAndYi,// 带 千和万和亿 (5千 10万 1亿）
};

typedef NS_ENUM(NSUInteger, lgf_TimeFormatType) {
    lgf_MS, // 00:00
    lgf_HMS,// 00:00:00
    lgf_CCharacterMS,// 00分00秒
    lgf_CCharacterHMS,// 00点00分00秒
};

@interface NSString (LGFString)

#pragma mark - 判断字符串类型 只包含中文/大写字母/小写字母/数字
- (BOOL)lgf_IsOnlyHaveChinese;
- (BOOL)lgf_IsOnlyHaveNumber;
- (BOOL)lgf_IsOnlyHaveSmallLetters;
- (BOOL)lgf_IsOnlyHaveCapitalLetters;

#pragma mark - string是否不为真
+ (BOOL)lgf_IsNull:(NSString *)string;

#pragma mark - 获取当前时间的 时间戳
+ (NSInteger)lgf_GetNowTimeStamp;

#pragma mark - 将某个时间字符串转化成 时间戳
/**
 @param timeStr 要转换的时间字符串
 @param format 格式化类型
 @return 时间戳
 */
+ (NSInteger)lgf_TimeStrSwitchTimeStamp:(NSString *)timeStr format:(NSString *)format;

#pragma mark - 将某个时间戳转化成 发布距离当前时间的字符串
/**
 @param timestamp 要转换的时间戳
 @return 发布距离当前时间的字符串:@"1年前" @"1个月前" @"1周前" @"1天前" @"1小时前" @"1分钟前" @"刚刚"
 */
+ (NSString *)lgf_TimeStampSwitchPublishTimeStr:(NSInteger)timestamp;

#pragma mark - 将某个时间戳转化成 时间字符串
/**
 @param timestamp 要转换的时间戳
 @param format 格式化类型
 @return 时间字符串
 */
+ (NSString *)lgf_TimeStampSwitchTimeStr:(NSInteger)timestamp format:(NSString *)format;

#pragma mark - 根据数字返回带单位字符串
/**
 @param num 要转换的数字
 @param unitType 单位范围类型
 @param unitStrType 单位类字符型 拼音还是汉子
 @return 带单位的数字符串
 */
+ (NSString *)lgf_GetNumStrWithNum:(NSUInteger)num unitType:(lgf_UnitType)unitType unitStrType:(lgf_UnitStrType)unitStrType;

#pragma mark - 根据视屏时长秒数返回时间字符串
/**
 @param timeLength 要转换的视屏秒数
 @param delimit 间隔符号 如果 TimeFormatType 为 lgf_CCharacterMS 或 lgf_CCharacterHMS 此项无效
 @param TimeFormatType 格式化类型
 @return 转换后的字符串
 */
+ (NSString *)lgf_GetVideoTimeLength:(NSUInteger)timeLength delimit:(NSString *)delimit TimeFormatType:(lgf_TimeFormatType)TimeFormatType;

#pragma mark - 格式化系统内存容量显示 B KB MB GB
+ (NSString *)lgf_FileSizeFormat:(CGFloat)bsize;

#pragma mark - 判断字符串是否包含 中文
- (BOOL)lgf_IsContainChinese;

#pragma mark - 判断字符串是否包含 空格
- (BOOL)lgf_IsContainBlank;

#pragma mark - url Encode
- (NSString*)lgf_UrlEncodedString;

#pragma mark - url Decoded
- (NSString*)lgf_UrlDecodedString;

#pragma mark - 返回修剪头部和尾部的空白字符（空格和换行符）
- (NSString *)lgf_StringByTrim;

#pragma mark - 字符串如果前面有0，保留去掉0之后的字符串
- (NSString *)lgf_GetTheCorrectNum;

#pragma MARK - 返回一个新的UUID NSString
/**
 e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 */
+ (NSString *)lgf_StringWithUUID;

#pragma mark - 返回包含给定UTF32Char中字符的字符串
/**
 Returns a string containing the characters in a given UTF32Char.
 @param char32 A UTF-32 字符.
 @return 新字符串, 如果字符无效则为nil.
 */
+ (NSString *)lgf_StringWithUTF32Char:(UTF32Char)char32;

#pragma mark - 返回包含给定UTF32Char数组中字符的字符串
/**
 @param char32 An array of UTF-32 character.
 @param length The character count in array.
 @return A new string, or nil if an error occurs.
 */
+ (NSString *)lgf_StringWithUTF32Chars:(const UTF32Char *)char32 length:(NSUInteger)length;

#pragma mark - 枚举字符串指定范围内的Unicode字符（UTF-32）
/**
 @param range 要枚举子串的字符串范围.
 @param block 为枚举执行的块。 该块有四个参数:
 char32: Unicode字符.
 range: 接收器的范围。 如果range.length是1，则字符在BMP中;
 否则（range.length为2）字符在非BMP平面中并存储
   通过接收器中的代理对.
 stop: 对块可用于停止枚举的布尔值的引用
   通过设置* stop = YES; 它不应该触摸*否则停止.
 */
- (void)lgf_EnumerateUTF32CharInRange:(NSRange)range usingBlock:(void (^)(UTF32Char char32, NSRange range, BOOL *stop))block;

#pragma mark - 将比例修饰符添加到文件名（不带路径扩展名）
/**
 From @"name" to @"name@2x".
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon.top" </td><td>"icon.top@2x" </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale 资源规模
 @return 字符串通过添加比例修饰符，或者如果它不以文件名结尾则返回
 */
- (NSString *)lgf_StringByAppendingNameScale:(CGFloat)scale;

#pragma mark - 将比例修饰符添加到文件路径（带路径扩展名）
/**
 From @"name.png" to @"name@2x.png".
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon.png" </td><td>"icon@2x.png" </td></tr>
 <tr><td>"icon..png"</td><td>"icon.@2x.png"</td></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon."    </td><td>"icon.@2x"    </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale 资源规模.
 @return 字符串通过添加比例修饰符，或者如果它不以文件名结尾则返回.
 */
- (NSString *)lgf_StringByAppendingPathScale:(CGFloat)scale;

#pragma mark - 返回路径比例
/**
 e.g.
 <table>
 <tr><th>Path            </th><th>Scale </th></tr>
 <tr><td>"icon.png"      </td><td>1     </td></tr>
 <tr><td>"icon@2x.png"   </td><td>2     </td></tr>
 <tr><td>"icon@2.5x.png" </td><td>2.5   </td></tr>
 <tr><td>"icon@2x"       </td><td>1     </td></tr>
 <tr><td>"icon@2x..png"  </td><td>1     </td></tr>
 <tr><td>"icon@2x.png/"  </td><td>1     </td></tr>
 </table>
 */
- (CGFloat)lgf_PathScale;

#pragma mark - 字符串是否为空
/**
 nil, @"", @"  ", @"\n" will Returns YES; otherwise Returns NO.
 */
- (BOOL)lgf_IsBlank;
+ (BOOL)lgf_IsBlank:(NSString *)text;

#pragma mark - 字符串是否包含某个字符串
/**
 @param string 传入字符串.
 @discussion 苹果已经在iOS8中实现了这种方法.
 */
- (BOOL)lgf_ContainsString:(NSString *)string;

#pragma mark - 字符串是否包含某个NSCharacterSet
/**
 @param set 传入NSCharacterSet
 */
- (BOOL)lgf_ContainsCharacterSet:(NSCharacterSet *)set;

#pragma mark - 试着解析这个字符串并返回一个NSNumber
/**
 @return 如果解析成功, 则返回NSNumber, 如果发生错误则返回nil。
 */
- (NSNumber *)lgf_NumberValue;

#pragma mark - 使用UTF-8编码返回一个NSData
/**
 */
- (NSData *)lgf_DataValue;

#pragma mark - 返回NSMakeRange（0，self.length）
- (NSRange)lgf_RangeOfAll;

#pragma mark - 返回从接收器解码的NSDictionary / NSArray, 如果发生错误则返回nil
/**
 e.g. NSString: @"{"name":"a","count":2}"  => NSDictionary: @[@"name":@"a",@"count":@2]
 */
- (id)lgf_JsonValueDecoded;

#pragma mark - 从主包中的文件创建一个字符串（类似于[UIImage imageNamed：]）
/**
 @param name 文件名称 (在主包中).
 @return 用UTF-8字符编码从文件中创建一个新字符串.
 */
+ (NSString *)lgf_StringNamed:(NSString *)name;

@end
