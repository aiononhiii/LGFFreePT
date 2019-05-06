//
//  NSData+LGFDate.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "NSDate+LGFDate.h"

@implementation NSDate (LGFDate)

#pragma mark - 自动格式化时间字符串
/**
 @param DateFormat 格式化类型
 @param date 传入时间 NSDate 或 NSString（如果传的是字符串 DateFormat 必须和该字符串一致）
 @return 传入 NSDate 返回 NSString， 传入 NSString 返回 NSDate
 */
+ (id)lgf_NeedDateFormat:(NSString*)DateFormat date:(id)date {
    return [self lgf_NeedDateFormat:DateFormat timeZone:nil date:date];
}

+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat timeZone:(NSTimeZone *)timeZone date:(id)date {
    return [self lgf_NeedDateFormat:DateFormat timeZone:timeZone locale:nil date:date];
}

+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale date:(id)date {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    if (timeZone) {
        [fmt setTimeZone:timeZone];
    } else {
        [fmt setTimeZone:[NSTimeZone systemTimeZone]];
    }
    if (locale) {
        [fmt setLocale:locale];
    } else {
        [fmt setLocale:[NSLocale systemLocale]];
    }
    fmt.dateFormat = DateFormat;
    if ([date isKindOfClass:[NSDate class]]) {
        return [fmt stringFromDate:date];
    } else {
        return [fmt dateFromString:date];
    }
}

#pragma mark - 根据时间戳自动格式化字符串
/**
 @param DateFormat 格式化类型
 @param timeInterval 传入时间戳
 @return 时间字符串
 */
+ (id)lgf_NeedDateFormat:(NSString*)DateFormat timeInterval:(double)timeInterval {
    return [self lgf_NeedDateFormat:DateFormat date:[NSDate dateWithTimeIntervalSince1970:timeInterval / 1000]];
}
+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat timeZone:(nullable NSTimeZone *)timeZone timeInterval:(double)timeInterval {
    return [self lgf_NeedDateFormat:DateFormat timeZone:timeZone date:[NSDate dateWithTimeIntervalSince1970:timeInterval / 1000]];
}
+ (nullable id)lgf_NeedDateFormat:(NSString*)DateFormat timeZone:(nullable NSTimeZone *)timeZone locale:(nullable NSLocale *)locale timeInterval:(double)timeInterval {
    return [self lgf_NeedDateFormat:DateFormat timeZone:timeZone locale:locale date:[NSDate dateWithTimeIntervalSince1970:timeInterval / 1000]];
}

- (NSDate *)lgf_DateByAddingYears:(NSInteger)years {
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lgf_DateByAddingMonths:(NSInteger)months {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lgf_DateByAddingWeeks:(NSInteger)weeks {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lgf_DateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)lgf_DateByAddingHours:(NSInteger)hours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)lgf_DateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)lgf_DateByAddingSeconds:(NSInteger)seconds {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)lgf_DateWithISOFormatString:(NSString *)dateString {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter dateFromString:dateString];
}

- (NSString *)lgf_StringWithISOFormat {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter stringFromDate:self];
}

#pragma mark - 返回当前时间戳
+ (NSInteger)lgf_GetNowTimeStamp {
    NSInteger timeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    return timeStamp;
}

#pragma mark - 当前时间是否是工作日
- (BOOL)lgf_IsWorkDay {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return NO;
    return YES;
}

#pragma mark - 当前时间是否是未来时间
- (BOOL)lgf_IsInFuture {
    return ([self compare:self] == NSOrderedAscending);
}

#pragma mark - 当前时间是否是过去时间
- (BOOL)lgf_IsInPast {
    return ([self compare:self] == NSOrderedDescending);
}

#pragma mark - 当前时间 时
- (NSInteger)lgf_Hour {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.hour;
}

#pragma mark - 当前时间 分
- (NSInteger)lgf_Minute {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.minute;
}

#pragma mark - 当前时间 秒
- (NSInteger)lgf_Second {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.second;
}

#pragma mark - 当前时间 纳秒
- (NSInteger)lgf_Nanosecond {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.nanosecond;
}

#pragma mark - 当前时间 日
- (NSInteger)lgf_Day {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.day;
}

#pragma mark - 当前时间 月
- (NSInteger)lgf_Month {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.month;
}

#pragma mark - 当前时间 周
- (NSInteger)lgf_Week {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.weekOfYear;
}

#pragma mark - 当前时间 星期几
- (NSInteger)lgf_Weekday {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.weekday;
}

#pragma mark - 当前时间 当前月第几个星期
- (NSInteger)lgf_NthWeekday {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.weekdayOrdinal;
}

#pragma mark - 当前时间 年
- (NSInteger)lgf_Year {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.year;
}

#pragma mark - 相对于月的第几周 范围(1~5)
- (NSInteger)lgf_WeekOfMonth {
    return [[lgf_Calendar components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

#pragma mark - 相对于年的第几周 范围(1~53)
- (NSInteger)lgf_WeekOfYear {
    return [[lgf_Calendar components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

#pragma mark - 是闰月
- (BOOL)lgf_IsLeapMonth {
    return [[lgf_Calendar components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

#pragma mark - 是闰年
- (BOOL)lgf_IsLeapYear {
    NSUInteger year = [self lgf_Year];
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

#pragma mark - 是今天
- (BOOL)lgf_IsToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [[NSDate new] lgf_Day] == [self lgf_Day];
}

#pragma mark - 是昨天
- (BOOL)lgf_IsYesterday {
    NSDate *added = [self lgf_DateByAddingDays:1];
    return [added lgf_IsToday];
}

@end
