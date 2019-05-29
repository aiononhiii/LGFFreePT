//
//  UIDevice+LGFDevice.h
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIDevice`.
 */
@interface UIDevice (LGFDevice)


#pragma mark - Device 信息
#pragma mark 设备系统版本 (e.g. 8.1)
+ (double)lgf_SystemVersion;

#pragma mark 当前设备是否是 ipad.
@property (nonatomic, readonly) BOOL lgf_IsPad;

#pragma mark 设备是否是模拟器.
@property (nonatomic, readonly) BOOL lgf_IsSimulator;

#pragma mark 该设备是否越狱.
@property (nonatomic, readonly) BOOL lgf_IsJailbroken;

#pragma mark 设备是否可以拨打电话.
@property (nonatomic, readonly) BOOL lgf_CanMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

#pragma mark 设备是否可以使用相机
@property (nonatomic, readonly) BOOL lgf_CanMakeCamera;

#pragma mark 该设备的机器型号.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *lgf_MachineModel;

#pragma mark 设备的机器型号名称. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *lgf_MachineModelName;

#pragma mark 系统的启动时间.
@property (nonatomic, readonly) NSDate *lgf_SystemUptime;


#pragma mark - Network 信息
#pragma mark 该设备的WIFI IP地址（可以为nil）. e.g. @"192.168.1.111"
@property (nullable, nonatomic, readonly) NSString *lgf_IpAddressWIFI;

#pragma mark 此设备的Cell单元 IP地址（可以为nil）. e.g. @"10.2.2.222"
@property (nullable, nonatomic, readonly) NSString *lgf_IpAddressCell;

#pragma mark wifi 名字
@property (nonatomic, readonly) NSString *lgf_WifiName;

/**
 网络流量类型：
  
   WWAN：无线广域网。
         例如：3G / 4G
   WIFI：Wi-Fi
   AWDL：Apple Wireless Direct Link（点对点连接）
         例如：AirDrop, AirPlay, GameKit
 */
typedef NS_OPTIONS(NSUInteger, lgf_NetworkTrafficType) {
    lgf_NetworkTrafficTypeWWANSent     = 1 << 0,
    lgf_NetworkTrafficTypeWWANReceived = 1 << 1,
    lgf_NetworkTrafficTypeWIFISent     = 1 << 2,
    lgf_NetworkTrafficTypeWIFIReceived = 1 << 3,
    lgf_NetworkTrafficTypeAWDLSent     = 1 << 4,
    lgf_NetworkTrafficTypeAWDLReceived = 1 << 5,
    
    lgf_NetworkTrafficTypeWWAN = lgf_NetworkTrafficTypeWWANSent | lgf_NetworkTrafficTypeWWANReceived,
    lgf_NetworkTrafficTypeWIFI = lgf_NetworkTrafficTypeWIFISent | lgf_NetworkTrafficTypeWIFIReceived,
    lgf_NetworkTrafficTypeAWDL = lgf_NetworkTrafficTypeAWDLSent | lgf_NetworkTrafficTypeAWDLReceived,
    
    lgf_NetworkTrafficTypeALL = lgf_NetworkTrafficTypeWWAN |
    lgf_NetworkTrafficTypeWIFI |
    lgf_NetworkTrafficTypeAWDL,
};

/**
 获取设备网络流量字节。
  
   @discussion 这是自设备上次启动以来的计数器。
   用法：
   uint64_t bytes = [[UIDevice currentDevice] getNetworkTrafficBytes：lgf_NetworkTrafficTypeALL];
   NSTimeInterval time = CACurrentMediaTime（）
   uint64_t bytesPerSecond =（bytes - _lastBytes）/（time - _lastTime）;
      
    _lastBytes = bytes;
    _lastTime = 时间;
 
   @param types 流量类型
   @return 字节计数器。
 */
- (uint64_t)lgf_GetNetworkTrafficBytes:(lgf_NetworkTrafficType)types;

#pragma mark - 磁盘空间
#pragma mark 字节中的总磁盘空间. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_DiskSpace;

#pragma mark 可用磁盘空间的字节. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_DiskSpaceFree;

#pragma mark 在字节中使用的磁盘空间. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_DiskSpaceUsed;


#pragma mark - 内存 信息
#pragma mark 字节总物理内存. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_MemoryTotal;

#pragma mark 字节中正在使用（活动+不活动+有线）内存. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_MemoryUsed;

#pragma mark 字节中的空闲内存. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_MemoryFree;

#pragma mark 字节中的活动内存. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_MemoryActive;

#pragma mark 字节中的非活动内存. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_MemoryInactive;

#pragma mark 字节中的有线内存. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_MemoryWired;

#pragma mark 可清除的字节内存. (-1 when error occurs)
@property (nonatomic, readonly) int64_t lgf_MemoryPurgable;

#pragma mark - CPU 信息
#pragma mark CPU 型号
@property (nonatomic, readonly) NSUInteger lgf_CpuNumber;
#pragma mark 可用的CPU处理器数量.
@property (nonatomic, readonly) NSUInteger lgf_CpuCount;

#pragma mark 目前的CPU使用率，1.0意味着100％。 (-1 when error occurs)
@property (nonatomic, readonly) float lgf_CpuUsage;

#pragma mark 当前每个处理器的CPU使用率（NSNumber数组），1.0表示100％。 (nil when error occurs)
@property (nullable, nonatomic, readonly) NSArray<NSNumber *> *lgf_CpuUsagePerProcessor;

#pragma mark - 电池 信息
@property (nonatomic, readonly) float lgf_BatteryQuantity;

#pragma mark - 打开手电筒
+ (void)lgf_TurnOnTheFlashlight:(BOOL)lgf_IsOn;

#pragma mark - 获取手机可用内存,转换成可视字符串

+ (NSString *)lgf_DiskSizeToString:(int64_t)lgf_DiskSize;
@end

NS_ASSUME_NONNULL_END

#ifndef lgf_IOS6Later
#define lgf_IOS6Later ([UIDevice systemVersion] >= 6)
#endif

#ifndef lgf_IOS7Later
#define lgf_IOS7Later ([UIDevice systemVersion] >= 7)
#endif

#ifndef lgf_IOS8Later
#define lgf_IOS8Later ([UIDevice systemVersion] >= 8)
#endif

#ifndef lgf_IOS9Later
#define lgf_IOS9Later ([UIDevice systemVersion] >= 9)
#endif

#ifndef lgf_IOS10Later
#define lgf_IOS10Later ([UIDevice systemVersion] >= 10)
#endif

#ifndef lgf_IOS11Later
#define lgf_IOS11Later ([UIDevice systemVersion] >= 11)
#endif

