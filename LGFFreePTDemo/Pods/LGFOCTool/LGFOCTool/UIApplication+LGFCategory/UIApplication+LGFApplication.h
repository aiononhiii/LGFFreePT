//
//  UIApplication+LGFApplication.h
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (LGFApplication)

@property (nonatomic, readonly) NSURL *lgf_DocumentsURL;
@property (nonatomic, readonly) NSString *lgf_DocumentsPath;

#pragma mark - 这个应用程序沙盒中的“缓存”文件夹
@property (nonatomic, readonly) NSURL *lgf_CachesURL;
@property (nonatomic, readonly) NSString *lgf_CachesPath;

#pragma mark - 这个应用程序沙盒中的“库”文件夹
@property (nonatomic, readonly) NSURL *lgf_LibraryURL;
@property (nonatomic, readonly) NSString *lgf_LibraryPath;

#pragma mark - 这个应用程序的 Bundle Name (show in SpringBoard)
@property (nullable, nonatomic, readonly) NSString *lgf_AppBundleName;

#pragma mark - 这个应用程序的 Bundle ID.  e.g. "com.ibireme.MyApp"
@property (nullable, nonatomic, readonly) NSString *lgf_AppBundleID;

#pragma mark - 这个应用程序的 Version.  e.g. "1.2.0"
@property (nullable, nonatomic, readonly) NSString *lgf_AppVersion;

#pragma mark - 这个应用程序的 Build number. e.g. "123"
@property (nullable, nonatomic, readonly) NSString *lgf_AppBuildVersion;

#pragma mark - 这个应用程序是否被预先设置（不从AppStore商店安装）
@property (nonatomic, readonly) BOOL lgf_IsPirated;

#pragma mark - 这个应用程序是否正在调试（附加的调试器）
@property (nonatomic, readonly) BOOL lgf_IsBeingDebugged;

#pragma mark - 当前线程在字节中使用的实际内存（错误发生时为-1）
@property (nonatomic, readonly) int64_t lgf_MemoryUsage;

#pragma mark - 当前线程CPU使用率，1意味着100%（错误发生时为-1）
@property (nonatomic, readonly) float lgf_CpuUsage;


#pragma mark - 增加活动网络请求的数量, 如果在递增之前这个数字为零, 这将启动动画, 状态栏网络活动指示器, 这种方法是线程安全的
- (void)lgf_IncrementNetworkActivityCount;

#pragma mark - 减少活动网络请求的数量, 如果这个数量在递减之后变为零, 这将停止动画, 状态栏网络活动指示器, 这种方法是线程安全的
- (void)lgf_DecrementNetworkActivityCount;

#pragma mark - 返回YES 应用程序扩展中
+ (BOOL)lgf_IsAppExtension;

#pragma mark - 与sharedApplication相同, 但在应用程序扩展中返回nil
+ (nullable UIApplication *)lgf_SharedExtensionApplication;

@end

NS_ASSUME_NONNULL_END
