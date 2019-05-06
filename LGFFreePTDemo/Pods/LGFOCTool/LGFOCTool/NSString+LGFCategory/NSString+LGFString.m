//
//  NSString+LGFString.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "NSString+LGFString.h"
#import "NSNumber+LGFNumber.h"
#import "NSString+LGFRegex.h"
#import "NSData+LGFEncodeDecode.h"

@implementation NSString (LGFString)

#pragma mark - string是否不为真
+ (BOOL)lgf_IsNull:(id)obj{
    BOOL result = NO;
    if ([obj isEqual:[NSNull null]] || obj == nil) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)obj;
        if (!string || [string isEqualToString:@""] || 0 == string.length) {
            result = YES;
        } else if ([string isEqualToString:@"null"]) {
            result = YES;
        }
    }
    return result;
}

#pragma mark - 获取当前时间的 时间戳
+ (NSInteger)lgf_GetNowTimeStamp {
    NSInteger timeSp = [[NSDate date] timeIntervalSince1970];
    NSLog(@"获取当前时间的 时间戳----timeSp:%ld", (long)timeSp);
    return timeSp;
}

#pragma mark - 将某个时间字符串转化成 时间戳
/**
 @param timeStr 要格式化的时间字符串
 @param format 格式化类型
 @return 时间戳
 */
+ (NSInteger)lgf_TimeStrSwitchTimeStamp:(NSString *)timeStr format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:timeStr];
    NSInteger timeSp = [date timeIntervalSince1970];
    NSLog(@"将某个时间字符串转化成 时间戳----timeSp:%ld", (long)timeSp);
    return timeSp;
}
#define aYeay  (3600. * 24 * 365)
#define aMonth (3600. * 24 * 30)
#define aWeek  (3600. * 24 * 7)
#define aDay1  (3600. * 24)
#define anHour  3600.
#define aMinute 60.
#pragma mark - 将某个时间戳转化成 发布距离当前时间的字符串
/**
 @param timeStamp 要转换的时间戳
 @return 发布距离当前时间的字符串:@"1年前" @"1个月前" @"1周前" @"1天前" @"1小时前" @"1分钟前" @"刚刚"
 */
+ (NSString *)lgf_TimeStampSwitchPublishTimeStr:(NSInteger)timeStamp {
    if (timeStamp < 0) {
        return @"时间错误";
    }
    NSInteger currentDateStamp = [self lgf_GetNowTimeStamp];
    NSInteger interval = currentDateStamp - timeStamp;
    if (interval < 60) {
        return @"刚刚";
    } else if (interval < 3600) {
        return [NSString stringWithFormat:@"%ld分钟前", (long)(interval / 60)];
    } else if (interval < 3600 * 24 && interval >= 3600) {
        return [NSString stringWithFormat:@"%ld小时前", (long)(interval / 3600)];
    }else if (interval < 3600 * 24 * 2 && interval >= 3600 * 24) {
        return @"昨天";
    } else if (interval < 3600 * 24 * 7 && interval > 3600 * 24 * 2) {
        return [NSString stringWithFormat:@"%ld天前", (long)(interval / (3600 * 24))];
    }  else if (interval < 3600 * 24 * 30 && interval >= 3600 * 24 * 7) {
        return [NSString stringWithFormat:@"%ld周前", (long)(interval / (3600 * 24 * 7))];
    } else if (interval < 3600 * 24 * 365 && interval >= 3600 * 24 * 30) {
        return [NSString stringWithFormat:@"%ld个月前", (long)(interval / (3600 * 24 * 30))];
    } else if (interval >= 3600 * 24 * 365) {
        return [NSString stringWithFormat:@"%ld年前", (long)(interval / (3600 * 24 * 365))];
    }
    return @"";
}

#pragma mark - 将某个时间戳转化成 时间字符串
/**
 @param timeStamp 要转换的时间戳
 @param format 格式化类型
 @return 时间字符串
 */
+ (NSString *)lgf_TimeStampSwitchTimeStr:(NSInteger)timeStamp format:(NSString *)format {
    format = [NSString lgf_IsNull:format] ? @"YYYY-MM-dd HH:mm:ss" : format;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    if (timeStamp > 1000000000) {
        timeStamp = timeStamp / 1000;
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"将某个时间戳转化成 时间字符串----confromTimespStr:%@", confromTimespStr);
    return confromTimespStr;
}

#pragma mark - 根据数字返回带单位字符串
/**
 @param num 要转换的数字
 @param unitType 单位范围类型
 @param unitStrType 单位类字符型 拼音还是汉子
 @return 带单位的数字符串
 */
+ (NSString *)lgf_GetNumStrWithNum:(NSUInteger)num unitType:(lgf_UnitType)unitType unitStrType:(lgf_UnitStrType)unitStrType {
    NSString *str = @"";
    if (unitType == lgf_OnlyQian) {
        if (num < 1000) {
            str = [NSString stringWithFormat:@"%ld",(long)num];
        } else {
            CGFloat countUse = num / 1000.0;
            str = [NSString stringWithFormat:@"%.1f%@",countUse ,unitStrType == lgf_SmallPinyin ? @"q" : unitStrType == lgf_BigPinyin ? @"Q" : @"千"];
        }
    } else if (unitType == lgf_OnlyWan) {
        if (num < 10000) {
            str = [NSString stringWithFormat:@"%ld",(long)num];
        } else {
            CGFloat countUse = num / 10000.0;
            str = [NSString stringWithFormat:@"%.1f%@",countUse ,unitStrType == lgf_SmallPinyin ? @"w" : unitStrType == lgf_BigPinyin ? @"W" : @"万"];
        }
    } else if (unitType == lgf_QianAndWan) {
        if (num < 1000) {
            str = [NSString stringWithFormat:@"%ld",(long)num];
        } else if (num < 10000) {
            CGFloat countUse = num / 1000.0;
            str = [NSString stringWithFormat:@"%.1f%@",countUse ,unitStrType == lgf_SmallPinyin ? @"q" : unitStrType == lgf_BigPinyin ? @"Q" : @"千"];
        } else {
            CGFloat countUse = num / 10000.0;
            str = [NSString stringWithFormat:@"%.1f%@",countUse ,unitStrType == lgf_SmallPinyin ? @"w" : unitStrType == lgf_BigPinyin ? @"W" : @"万"];
        }
    } else if (unitType == lgf_WanAndYi) {
        if (num < 10000) {
            str = [NSString stringWithFormat:@"%ld",(long)num];
        } else if (num < 100000000) {
            CGFloat countUse = num / 10000.0;
            str = [NSString stringWithFormat:@"%.1f%@",countUse ,unitStrType == lgf_SmallPinyin ? @"w" : unitStrType == lgf_BigPinyin ? @"W" : @"万"];
        } else {
            CGFloat countUse = num / 100000000;
            str = [NSString stringWithFormat:@"%.1f%@",countUse ,unitStrType == lgf_SmallPinyin ? @"y" : unitStrType == lgf_BigPinyin ? @"Y" : @"亿"];
        }
    } else if (unitType == lgf_QianAndWanAndYi) {
        if (num < 1000) {
            str = [NSString stringWithFormat:@"%ld",(long)num];
        } else if (num < 10000) {
            CGFloat countUse = num / 1000.0;
            str = [NSString stringWithFormat:@"%.1f%@",countUse ,unitStrType == lgf_SmallPinyin ? @"q" : unitStrType == lgf_BigPinyin ? @"Q" : @"千"];
        } else if (num < 100000000) {
            CGFloat countUse = num / 10000.0;
            str = [NSString stringWithFormat:@"%.1f%@",countUse ,unitStrType == lgf_SmallPinyin ? @"w" : unitStrType == lgf_BigPinyin ? @"W" : @"万"];
        } else {
            CGFloat countUse = num / 100000000;
            str = [NSString stringWithFormat:@"%.1f%@",countUse ,unitStrType == lgf_SmallPinyin ? @"y" : unitStrType == lgf_BigPinyin ? @"Y" : @"亿"];
        }
    }
    return str;
}

#pragma mark - 根据视屏时长秒数返回时间字符串
/**
 @param timeLength 要转换的视屏秒数
 @param delimit 间隔符号 如果 TimeFormatType 为 lgf_CCharacterMS 或 lgf_CCharacterHMS 此项无效
 @param TimeFormatType 格式化类型
 @return 转换后的字符串
 */
+ (NSString *)lgf_GetVideoTimeLength:(NSUInteger)timeLength delimit:(NSString *)delimit TimeFormatType:(lgf_TimeFormatType)TimeFormatType {
    NSString *str = @"";
    if (TimeFormatType == lgf_MS) {
        str = [NSString stringWithFormat:@"%02ld%@%02ld", (long)(timeLength / 60), delimit, (long)(timeLength % 60)];
    } else if (TimeFormatType == lgf_HMS) {
        str = [NSString stringWithFormat:@"%02ld%@%02ld%@%02ld", (long)(timeLength / 3600), delimit, (long)((timeLength % 3600) / 60), delimit, (long)(timeLength % 60)];
    } else if (TimeFormatType == lgf_CCharacterMS) {
        str = [NSString stringWithFormat:@"%02ld分%02ld秒", (long)(timeLength / 60) , (long)(timeLength % 60)];
    } else if (TimeFormatType == lgf_CCharacterHMS) {
        str = [NSString stringWithFormat:@"%02ld点%02ld分%02ld秒", (long)(timeLength / 3600), (long)((timeLength % 3600) / 60), (long)(timeLength % 60)];
    }
    return str;
}

#pragma mark - 判断字符串类型 只包含中文/大写字母/小写字母/数字
- (BOOL)lgf_IsOnlyHaveChinese {
    return YES;
}
- (BOOL)lgf_IsOnlyHaveNumber; {
    return YES;
}
- (BOOL)lgf_IsOnlyHaveSmallLetters {
    NSInteger alength = [self length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [self characterAtIndex:i];
        if ((commitChar > 64) && (commitChar < 91)) {
            NSLog(@"字符串中含有大写英文字母");
            return NO;
        }
    }
    return YES;
}
- (BOOL)lgf_IsOnlyHaveCapitalLetters {
    NSInteger alength = [self length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [self characterAtIndex:i];
        if ((commitChar > 96) && (commitChar < 123)) {
            NSLog(@"字符串中含有小写英文字母");
            return NO;
        }
    }
    return YES;
}

#pragma mark - 字符串如果前面有0，保留去掉0之后的字符串
- (NSString *)lgf_GetTheCorrectNum {
    NSString *CorrectNumStr = self;
    while ([CorrectNumStr hasPrefix:@"0"]) {
        CorrectNumStr = [CorrectNumStr substringFromIndex:1];
    }
    return CorrectNumStr;
}

#pragma mark - 格式化系统内存容量显示
+ (NSString *)lgf_FileSizeFormat:(CGFloat)bsize {
    if (bsize < 1024) {
        return [NSString stringWithFormat:@"%0.1fB", bsize];
    } else if (bsize < 1024 * 1024) {
        return [NSString stringWithFormat:@"%0.1fKB", bsize / 1024];
    } else if (bsize < 1024 * 1024 * 1024) {
        return [NSString stringWithFormat:@"%0.1fMB", bsize / (1024 * 1024)];
    }
    return [NSString stringWithFormat:@"%0.1fGB", bsize / (1024 * 1024 * 1024)];
}

#pragma mark - 判断字符串是否包含 中文
- (BOOL)lgf_IsContainChinese {
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 判断字符串是否包含 空格
- (BOOL)lgf_IsContainBlank {
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

#pragma mark - url Encode

- (NSString*)lgf_UrlEncodedString {
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    if(!encodedString)
        encodedString = @"";
    return encodedString;
}

#pragma mark - url Decoded

- (NSString*)lgf_UrlDecodedString {
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

- (NSString *)lgf_StringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

+ (NSString *)lgf_StringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *)lgf_StringWithUTF32Char:(UTF32Char)char32 {
    char32 = NSSwapHostIntToLittle(char32);
    return [[NSString alloc] initWithBytes:&char32 length:4 encoding:NSUTF32LittleEndianStringEncoding];
}

+ (NSString *)lgf_StringWithUTF32Chars:(const UTF32Char *)char32 length:(NSUInteger)length {
    return [[NSString alloc] initWithBytes:(const void *)char32
                                    length:length * 4
                                  encoding:NSUTF32LittleEndianStringEncoding];
}

- (void)lgf_EnumerateUTF32CharInRange:(NSRange)range usingBlock:(void (^)(UTF32Char char32, NSRange range, BOOL *stop))block {
    NSString *str = self;
    if (range.location != 0 || range.length != self.length) {
        str = [self substringWithRange:range];
    }
    NSUInteger len = [str lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4;
    UTF32Char *char32 = (UTF32Char *)[str cStringUsingEncoding:NSUTF32LittleEndianStringEncoding];
    if (len == 0 || char32 == NULL) return;
    
    NSUInteger location = 0;
    BOOL stop = NO;
    NSRange subRange;
    UTF32Char oneChar;
    
    for (NSUInteger i = 0; i < len; i++) {
        oneChar = char32[i];
        subRange = NSMakeRange(location, oneChar > 0xFFFF ? 2 : 1);
        block(oneChar, subRange, &stop);
        if (stop) return;
        location += subRange.length;
    }
}

- (NSString *)lgf_StringByAppendingNameScale:(CGFloat)scale {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    return [self stringByAppendingFormat:@"@%@x", @(scale)];
}

- (NSString *)lgf_StringByAppendingPathScale:(CGFloat)scale {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    NSString *ext = self.pathExtension;
    NSRange extRange = NSMakeRange(self.length - ext.length, 0);
    if (ext.length > 0) extRange.location -= 1;
    NSString *scaleStr = [NSString stringWithFormat:@"@%@x", @(scale)];
    return [self stringByReplacingCharactersInRange:extRange withString:scaleStr];
}

- (CGFloat)lgf_PathScale {
    if (self.length == 0 || [self hasSuffix:@"/"]) return 1;
    NSString *name = self.stringByDeletingPathExtension;
    __block CGFloat scale = 1;
    [name lgf_EnumerateRegexMatches:@"@[0-9]+\\.?[0-9]*x$" options:NSRegularExpressionAnchorsMatchLines usingBlock: ^(NSString *match, NSRange matchRange, BOOL *stop) {
        scale = [match substringWithRange:NSMakeRange(1, match.length - 2)].doubleValue;
    }];
    return scale;
}

+ (BOOL)lgf_IsBlank:(NSString *)text {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < text.length; ++i) {
        unichar c = [text characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)lgf_IsBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)lgf_ContainsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)lgf_ContainsCharacterSet:(NSCharacterSet *)set {
    if (set == nil) return NO;
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

- (NSNumber *)lgf_NumberValue {
    return [NSNumber lgf_NumberWithString:self];
}

- (NSData *)lgf_DataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSRange)lgf_RangeOfAll {
    return NSMakeRange(0, self.length);
}

- (id)lgf_JsonValueDecoded {
    return [[self lgf_DataValue] lgf_JsonValueDecoded];
}

+ (NSString *)lgf_StringNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}

@end
