//
//  LGFNetworkHeader.h
//  LGFOCTool
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFPch.h"

@interface LGFNetworkHeader : NSObject

lgf_AllocOnceForH;

/**
 appId
 */
@property (nonatomic, strong) NSString *appId;

/**
 用户id
 */
@property (nonatomic, strong) NSString *AppUserId;

/**
 经度
 */
@property (nonatomic, strong) NSString *lat;

/**
 纬度
 */
@property (nonatomic, strong) NSString *lon;

/**
 密码
 */
@property (nonatomic, strong) NSString *password;

/**
 版本号
 */
@property (nonatomic, strong) NSString *version;

/**
 定位id
 */
@property (nonatomic, strong) NSString *locationID;

/**
 定位名称
 */
@property (nonatomic, strong) NSString *locationName;

/**
 平台信息
 */
@property (nonatomic, strong) NSString *platform;

/**
 token
 */
@property (nonatomic, strong) NSString *token;

/**
 昵称
 */
@property (nonatomic, strong) NSString *nickname;

/**
 头像
 */
@property (nonatomic, strong) NSString *icon;

@end
