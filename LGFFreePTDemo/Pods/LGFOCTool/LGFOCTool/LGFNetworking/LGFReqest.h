//
//  LGFReqest.h
//  LGFOCTool
//
//  Created by apple on 2017/6/7.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFNetwork.h"

typedef NS_ENUM(NSUInteger, lgf_RequestMethod) {
    lgf_POST,
    lgf_GET,
};

@interface LGFReqest : NSObject

+ (NSMutableDictionary *)lgf_AllTasks;
+ (void)lgf_AllTasksRemoveFromVC:(id)target;
+ (void)lgf_AllTasksRemove:(id)target task:(NSURLSessionDataTask *)task;
+ (void)lgf_AllTasksAdd:(id)target task:(NSURLSessionDataTask *)task;

#pragma mark - 网络请求
/**
 @param method 请求方法：GET/POST 目前只支持这两中
 @param url 地址
 @param paramt 参数
 @param completed 回调
 */
+ (NSURLSessionDataTask *)lgf_Request:(id)target method:(lgf_RequestMethod)method url:(NSString *)url paramt:(NSDictionary *)paramt completed:(void(^)(NSDictionary *data, NSError *error))completed;

#pragma mark - 下载文请求
/**
 @param fileUrl 要下载的文件路径
 @param path 下载的文件保存路径
 @param completed 完成后回调
 */
+ (void)lgf_DownLoadFile:(NSString *)fileUrl saveToPath:(NSString *)path completed:(void(^)(NSURL *url, NSError *error))completed;

@end
