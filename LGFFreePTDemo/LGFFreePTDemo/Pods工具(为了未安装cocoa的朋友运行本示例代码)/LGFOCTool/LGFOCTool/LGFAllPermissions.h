//
//  LGFAllPermissions.h
//  LGFOCTool
//
//  Created by apple on 2017/5/10.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFOCTool.h"

// 相册              NSPhotoLibraryUsageDescription

// 相机              NSCameraUsageDescription

// 麦克风             NSMicrophoneUsageDescription

// 位置              NSLocationUsageDescription

// 在使用期间访问位置   NSLocationWhenInUseUsageDescription

// 始终访问位置        NSLocationAlwaysUsageDescription

// 日历              NSCalendarsUsageDescription

// 提醒事项           NSRemindersUsageDescription

// 运动与健身         NSMotionUsageDescription

// 蓝牙              NSBluetoothPeripheralUsageDescription

// 媒体资料库         NSAppleMusicUsageDescription

typedef NS_ENUM(NSUInteger, lgf_LocationPermissionType) {
    lgf_Always,// 始终
    lgf_WhenInUse,// 应用开启时
};

@interface LGFAllPermissions : NSObject

lgf_AllocOnceForH;

@property (strong, nonatomic) CLLocationManager *lgf_Manager;

#pragma mark - 相机权限

+ (void)lgf_GetCameraPermission:(void(^)(BOOL isHave))block;

#pragma mark - 麦克风权限

+ (void)lgf_GetMicroPhoneAutoPermission:(void(^)(BOOL isHave))block;

#pragma mark - 相册权限

+ (void)lgf_GetPhotoAutoPermission:(void(^)(BOOL isHave))block;

#pragma mark - IOS10 网络权限

+ (void)lgf_GetNetworkPermission:(void(^)(BOOL isHave))block;

#pragma mark - 通讯录权限

+ (void)lgf_GetAddressBookPermission:(void (^)(BOOL isHave))block;

#pragma mark - 日历或备忘录权限

+ (void)lgf_GetEventPermission:(void(^)(BOOL isHave))block;

#pragma mark - 推送权限

+ (void)lgf_GetUserNotificationPermission:(void (^)(BOOL isHave))block;

#pragma mark - 定位权限
/**
 @param LocationPermissionType 获取定位权限的范围
 */
+ (void)lgf_GetLocationPermission:(lgf_LocationPermissionType)LocationPermissionType block:(void(^)(BOOL isHave))block;

#pragma mark - 进入系统设置权限页

+ (void)lgf_GoSystemSettingPermission;


@end
