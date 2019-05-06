//
//  LGFAllPermissions.m
//  LGFOCTool
//
//  Created by apple on 2017/5/10.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFAllPermissions.h"

@implementation LGFAllPermissions

lgf_AllocOnceForM(LGFAllPermissions);

#pragma mark - 相机权限

+ (void)lgf_GetCameraPermission:(void(^)(BOOL isHave))block {
    if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType:completionHandler:)]) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    lgf_HaveBlock(block, YES);
                } else {
                    lgf_HaveBlock(block, NO);
                }
            });
        }];
    } else {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusAuthorized) {
            lgf_HaveBlock(block, YES);
        } else {
            lgf_HaveBlock(block, NO);
        }
    }
}

#pragma mark - 麦克风权限

+ (void)lgf_GetMicroPhoneAutoPermission:(void(^)(BOOL isHave))block {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession requestRecordPermission:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    lgf_HaveBlock(block, YES);
                } else {
                    lgf_HaveBlock(block, NO);
                }
            });
        }];
    } else {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if (authStatus == AVAuthorizationStatusAuthorized) {
            lgf_HaveBlock(block, YES);
        } else {
            lgf_HaveBlock(block, NO);
        }
    }
}

#pragma mark - 相册权限

+ (void)lgf_GetPhotoAutoPermission:(void(^)(BOOL isHave))block {
    if ([PHPhotoLibrary respondsToSelector:@selector(requestAuthorization:)]) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
                    lgf_HaveBlock(block, NO);
                } else {
                    lgf_HaveBlock(block, YES);
                }
            });
        }];
    } else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized){
            lgf_HaveBlock(block, YES);
        } else {
            lgf_HaveBlock(block, NO);
        }
    }
}

#pragma mark - 日历或备忘录权限

+ (void)lgf_GetEventPermission:(void(^)(BOOL isHave))block {
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    if (EKstatus == EKAuthorizationStatusAuthorized) {
        lgf_HaveBlock(block, YES);
    } else {
        EKEventStore *store = [[EKEventStore alloc]init];
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    lgf_HaveBlock(block, YES);
                }else{
                    lgf_HaveBlock(block, NO);
                }
            });
        }];
    }
}

#pragma mark - 定位权限

+ (void)lgf_GetLocationPermission:(lgf_LocationPermissionType)LocationPermissionType block:(void(^)(BOOL isHave))block {
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    if (CLstatus == kCLAuthorizationStatusAuthorizedAlways) {
        lgf_HaveBlock(block, YES);
    } else if (CLstatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        lgf_HaveBlock(block, YES);
    } else {
        if (LocationPermissionType == lgf_Always) {
            [[LGFAllPermissions lgf_Once].lgf_Manager requestAlwaysAuthorization];//一直获取定位信息
        } else {
            [[LGFAllPermissions lgf_Once].lgf_Manager requestWhenInUseAuthorization];//使用的时候获取定位信息
        }
        lgf_HaveBlock(block, NO);
    }
}

#pragma mark - 推送权限

+ (void)lgf_GetUserNotificationPermission:(void (^)(BOOL isHave))block {
    if (lgf_IOSSystemVersion(8.0)) {
        UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (settings.types == UIUserNotificationTypeNone) {
            UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
            lgf_HaveBlock(block, NO);
        } else {
            lgf_HaveBlock(block, YES);
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone == type){
            UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
#pragma clang diagnostic pop
            lgf_HaveBlock(block, NO);
        }else{
            lgf_HaveBlock(block, YES);
        }
    }
}

#pragma mark - 通讯录权限

+ (void)lgf_GetAddressBookPermission:(void (^)(BOOL isHave))block {
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    if (authStatus == kABAuthorizationStatusAuthorized) {
        lgf_HaveBlock(block, YES);
    } else {
        if (lgf_IOSSystemVersion(9.0)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        lgf_HaveBlock(block, YES);
                    }else{
                        lgf_HaveBlock(block, NO);
                    }
                });
            }];
#pragma clang diagnostic pop
        } else {
            ABAddressBookRef addBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addBook, ^(bool granted, CFErrorRef error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        lgf_HaveBlock(block, YES);
                    }else{
                        lgf_HaveBlock(block, NO);
                    }
                });
            });
        }
    }
}

#pragma mark - IOS10 网络权限

+ (void)lgf_GetNetworkPermission:(void(^)(BOOL isHave))block {
    if (lgf_IOSSystemVersion(10.0)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
            //获取联网状态
            if (state == kCTCellularDataRestricted) {// 没权限
                [[[NSURLSession sharedSession] dataTaskWithRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com"]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    NSLog(@"请求完毕");
                }] resume];
                lgf_HaveBlock(block, NO);
            } else if (state == kCTCellularDataNotRestricted) {// 有权限
                lgf_HaveBlock(block, YES);
            } else if (state == kCTCellularDataRestrictedStateUnknown) {// 未知
                lgf_HaveBlock(block, YES);
            }
        };
#pragma clang diagnostic pop
    }
}

#pragma mark - 进入系统设置权限页
+ (void)lgf_GoSystemSettingPermission {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (lgf_IOSSystemVersion(10)) {
            [lgf_Application openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    });
}

- (CLLocationManager *)lgf_Manager {
    if (!_lgf_Manager) {
        _lgf_Manager = [[CLLocationManager alloc] init];
    }
    return _lgf_Manager;
}

@end
