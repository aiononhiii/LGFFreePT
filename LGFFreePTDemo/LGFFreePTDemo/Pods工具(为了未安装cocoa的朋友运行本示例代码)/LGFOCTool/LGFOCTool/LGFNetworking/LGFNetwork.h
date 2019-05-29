//
//  LGFNetwork.h
//  LGFOCTool
//
//  Created by apple on 2017/6/7.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LGFOCTool.h"
#import "LGFNetworkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGFNetwork : NSObject

/**
 HOST
 */
@property (nonatomic, strong) NSString *lgf_Host;

/**
 用于配置请求头的模型
 */
@property (strong, nonatomic) LGFNetworkHeader *lgf_Header;

/**
 网络请求管理者
 */
@property (nonatomic, strong) AFHTTPSessionManager *lgf_SessionManager;

/**
 下载请求管理者
 */
@property (nonatomic, strong) AFURLSessionManager *lgf_DownLoadManager;

lgf_AllocOnceForH;

#pragma mark - 请求区方法

- (NSURLSessionDataTask *)lgf_GET:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


- (NSURLSessionDataTask *)lgf_POST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

// 下载文件
- (NSURLSessionDownloadTask *)lgf_DownloadTaskWithRequest:(NSString *)URLString
                                               saveToPath:(NSString *)path
                                        completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
