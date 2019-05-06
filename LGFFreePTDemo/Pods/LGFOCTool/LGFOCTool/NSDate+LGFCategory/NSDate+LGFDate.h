//
//  NSData+LGFDate.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

#define lgf_Components (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define lgf_Calendar [NSCalendar currentCalendar]

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LGFDate)

#pragma mark - 自动格式化字符串
/**
 @param DateFormat 格式化类型
 @param date 传入时间 NSDate 或 NSString（如果传的是字符串 DateFormat 必须和该字符串一致）
 @return 传入 NSDate 返回 NSString， 传入 NSString 返回 NSDate
 */
+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat date:(id)date;
/**
 @param timeZone timeZone
 */
+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat timeZone:(nullable NSTimeZone *)timeZone date:(id)date;
/**
 @param locale locale
 */
+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat timeZone:(nullable NSTimeZone *)timeZone locale:(nullable NSLocale *)locale date:(id)date;

#pragma mark - 根据时间戳自动格式化字符串
/**
 @param DateFormat 格式化类型
 @param timeInterval 传入时间戳
 @return 时间字符串
 */
+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat timeInterval:(double)timeInterval;
/**
 @param timeZone timeZone
 */
+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat timeZone:(nullable NSTimeZone *)timeZone timeInterval:(double)timeInterval;
/**
 @param locale locale
 */
+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat timeZone:(nullable NSTimeZone *)timeZone locale:(nullable NSLocale *)locale timeInterval:(double)timeInterval;

#pragma mark - 添加年数
/**
 @param years  要添加的年数.
 @return 添加年数后的日期.
 */
- (nullable NSDate *)lgf_DateByAddingYears:(NSInteger)years;

#pragma mark - 添加月份数
/**
 @param months 要添加的月份数.
 @return 添加月份数后的日期.
 */
- (nullable NSDate *)lgf_DateByAddingMonths:(NSInteger)months;

#pragma mark - 添加周数
/**
 @param weeks 要添加的周数.
 @return 添加周数后的日期.
 */
- (nullable NSDate *)lgf_DateByAddingWeeks:(NSInteger)weeks;

#pragma mark - 添加天数
/**
 @param days 要添加的天数.
 @return 添加天数后的日期.
 */
- (nullable NSDate *)lgf_DateByAddingDays:(NSInteger)days;

#pragma mark - 添加小时数
/**
 @param hours 要添加的小时数.
 @return 添加小时数后的日期.
 */
- (nullable NSDate *)lgf_DateByAddingHours:(NSInteger)hours;

#pragma mark - 添加分钟数
/**
 @param minutes 要添加的分钟数.
 @return 添加分钟数后的日期.
 */
- (nullable NSDate *)lgf_DateByAddingMinutes:(NSInteger)minutes;

#pragma mark - 添加秒数
/**
 @param seconds 要添加的秒数.
 @return 添加秒数后的日期.
 */
- (nullable NSDate *)lgf_DateByAddingSeconds:(NSInteger)seconds;

#pragma mark - 返回ISO8601格式日期字符串中解析的日期。
+ (nullable NSDate *)lgf_DateWithISOFormatString:(NSString *)dateString;

#pragma mark - 返回以ISO8601格式返回表示此日期的字符串
/**
 "2010-07-09T16:13:30+12:00"
 */
- (nullable NSString *)lgf_StringWithISOFormat;

#pragma mark - 返回当前时间戳
+ (NSInteger)lgf_GetNowTimeStamp;

#pragma mark - 当前时间是否是工作日
- (BOOL)lgf_IsWorkDay;
#pragma mark - 当前时间是否是未来时间
- (BOOL)lgf_IsInFuture;
#pragma mark - 当前时间是否是过去时间
- (BOOL)lgf_IsInPast;
#pragma mark - 当前时间 时
- (NSInteger)lgf_Hour;
#pragma mark - 当前时间 分
- (NSInteger)lgf_Minute;
#pragma mark - 当前时间 秒
- (NSInteger)lgf_Second;
#pragma mark - 当前时间 纳秒
- (NSInteger)lgf_Nanosecond;
#pragma mark - 当前时间 日
- (NSInteger)lgf_Day;
#pragma mark - 当前时间 月
- (NSInteger)lgf_Month;
#pragma mark - 当前时间 周
- (NSInteger)lgf_Week;
#pragma mark - 当前时间 星期几
- (NSInteger)lgf_Weekday;
#pragma mark - 当前时间 当前月第几个星期
- (NSInteger)lgf_NthWeekday;
#pragma mark - 当前时间 年
- (NSInteger)lgf_Year;
#pragma mark - 相对于月的第几周 范围(1~5)
- (NSInteger)lgf_WeekOfMonth;
#pragma mark - 相对于年的第几周 范围(1~53)
- (NSInteger)lgf_WeekOfYear;
#pragma mark - 是闰月
- (BOOL)lgf_IsLeapMonth;
#pragma mark - 是闰年
- (BOOL)lgf_IsLeapYear;
#pragma mark - 是今天
- (BOOL)lgf_IsToday;
#pragma mark - 是昨天
- (BOOL)lgf_IsYesterday;

@end

NS_ASSUME_NONNULL_END
