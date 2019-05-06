//
//  LGFNetwork.m
//  LGFOCTool
//
//  Created by apple on 2017/6/7.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LGFNetwork

#pragma mark - 单例初始化
lgf_AllocOnceForM(LGFNetwork);

#pragma mark - GET 请求
- (NSURLSessionDataTask *)lgf_GET:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure {
    NSString *url = [self lgf_UrlConfig:URLString];
    NSLog(@"请求的地址>>>>>>>>>>>>>>>>>%@", url);
    NSLog(@"请求的参数>>>>>>>>>>>>>>>>>%@", parameters);
    return [self.lgf_SessionManager GET:url parameters:parameters progress:nil success:success failure:failure];
}

#pragma mark - POST 请求
- (NSURLSessionDataTask *)lgf_POST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure {
    NSString *url = [self lgf_UrlConfig:URLString];
    NSLog(@"请求的地址>>>>>>>>>>>>>>>>>%@", url);
    NSLog(@"请求的参数>>>>>>>>>>>>>>>>>%@", parameters);
    return [self.lgf_SessionManager POST:url parameters:parameters progress:nil success:success failure:failure];
}

#pragma mark - 下载 请求
- (NSURLSessionDownloadTask *)lgf_DownloadTaskWithRequest:(NSString *)URLString
                                               saveToPath:(NSString *)path
                                        completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        if (path!= nil && path.length > 0) {
            return [documentsDirectoryURL URLByAppendingPathComponent:path];
        }
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        completionHandler(response,filePath,error);
    }];
    [downloadTask resume];
    return downloadTask;
}

#pragma mark - 懒加载网络请求管理者
//  设置根url懒加载
- (AFHTTPSessionManager *)lgf_SessionManager {
    if (_lgf_SessionManager == nil) {
        _lgf_SessionManager = [AFHTTPSessionManager manager];
        _lgf_SessionManager.requestSerializer.timeoutInterval = 10;
        _lgf_SessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
        [_lgf_SessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [_lgf_SessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    [self lgf_ResetHeader];
    return _lgf_SessionManager;
}

#pragma mark - 懒加载下载请求管理者
- (AFURLSessionManager *)lgf_DownLoadManager {
    if (!_lgf_DownLoadManager) {
        //默认配置
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        //AFN3.0+基于封住URLSession的句柄
        _lgf_DownLoadManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return _lgf_DownLoadManager;
}

#pragma mark - 配置请求头
- (void)lgf_ResetHeader {
    //重置请求头
    if (_lgf_Header) {
        if (_lgf_Header.lon) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.lon forHTTPHeaderField:@"lon"];
        }
        if (_lgf_Header.lat) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.lat forHTTPHeaderField:@"lat"];
        }
        if (_lgf_Header.password) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.password forHTTPHeaderField:@"password"];
        }
        if (_lgf_Header.appId) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.appId forHTTPHeaderField:@"appId"];
        }
        if (_lgf_Header.AppUserId) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.AppUserId forHTTPHeaderField:@"AppUserId"];
        }
        if (_lgf_Header.version) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.version forHTTPHeaderField:@"version"];
        }
        if (_lgf_Header.platform) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.platform forHTTPHeaderField:@"platform"];
        }
        if (_lgf_Header.locationID) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.locationID forHTTPHeaderField:@"locationId"];
        }
        if (_lgf_Header.locationName) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.locationName forHTTPHeaderField:@"locationName"];
        }
        if (_lgf_Header.token) {
            [_lgf_SessionManager.requestSerializer setValue:_lgf_Header.token forHTTPHeaderField:@"token"];
        }
    }
}

#pragma mark - HOST拼接
- (NSString *)lgf_UrlConfig:(NSString *)URLString {
    if (self.lgf_Host) {
        if (![URLString containsString:self.lgf_Host]) {
            if ([[URLString substringToIndex:1] isEqualToString:@"/"]) {
                return [NSString stringWithFormat:@"%@%@",self.lgf_Host,URLString];
            } else {
                return [NSString stringWithFormat:@"%@/%@",self.lgf_Host,URLString];
            }
        } else {
            return URLString;
        }
    } else {
        return URLString;
    }
}

@end

NS_ASSUME_NONNULL_END
