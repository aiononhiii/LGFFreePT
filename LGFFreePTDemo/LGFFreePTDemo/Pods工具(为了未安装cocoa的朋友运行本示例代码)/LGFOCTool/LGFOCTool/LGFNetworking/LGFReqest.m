//
//  LGFReqest.m
//  LGFOCTool
//
//  Created by apple on 2017/6/7.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFReqest.h"

@implementation LGFReqest

#pragma mark - 缓存所有请求的数组
/**
 @{
    @"ClassName" : @[task, task, task],
    @"ClassName" : @[task, task, task],
    @"ClassName" : @[task, task, task]
 },
 */
static NSMutableDictionary *lgf_AllTasks;
+ (NSMutableDictionary *)lgf_AllTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (lgf_AllTasks == nil) {
            lgf_AllTasks = [[NSMutableDictionary alloc] init];
        }
    });
    return lgf_AllTasks;
}

+ (void)lgf_AllTasksRemoveFromVC:(id)target {
    if (target) {
        if ([target isKindOfClass:[UIViewController class]]) {
            [[[LGFReqest lgf_AllTasks] valueForKey:NSStringFromClass([target class])] makeObjectsPerformSelector:@selector(cancel)];
            [[LGFReqest lgf_AllTasks] removeObjectForKey:NSStringFromClass([target class])];
        }
    }
}

+ (void)lgf_AllTasksRemove:(id)target task:(NSURLSessionDataTask *)task {
    if (target) {
        if ([target isKindOfClass:[UIViewController class]]) {
            NSMutableArray *tasks = [NSMutableArray arrayWithArray:[[LGFReqest lgf_AllTasks] valueForKey:NSStringFromClass([target class])]];
            [tasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.response.URL.absoluteString isEqualToString:task.response.URL.absoluteString]) {
                    [obj cancel];
                    [tasks removeObject:obj];
                }
            }];
            [[LGFReqest lgf_AllTasks] setObject:tasks forKey:NSStringFromClass([target class])];
        }
    }
}

+ (void)lgf_AllTasksAdd:(id)target task:(NSURLSessionDataTask *)task {
    if (target) {
        if ([target isKindOfClass:[UIViewController class]]) {
            NSMutableArray *tasks = [NSMutableArray arrayWithArray:[[LGFReqest lgf_AllTasks] valueForKey:NSStringFromClass([target class])]];
            [tasks addObject:task];
            [[LGFReqest lgf_AllTasks] setObject:tasks forKey:NSStringFromClass([target class])];
        }
    }
}

#pragma mark - 网络请求
/**
 @param method 请求方法：GET/POST 目前只支持这两中
 @param url 地址
 @param paramt 参数
 @param completed 回调
 */
+ (NSURLSessionDataTask *)lgf_Request:(id)target method:(lgf_RequestMethod)method url:(NSString *)url paramt:(NSDictionary *)paramt completed:(void(^)(NSDictionary *data, NSError *error))completed {
    NSURLSessionDataTask *task = nil;
    if (method == lgf_GET) {
        // GET
        task = [[LGFNetwork lgf_Once] lgf_GET:url parameters:paramt success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            lgf_HaveBlock(completed, responseObject, nil);
            [LGFReqest lgf_AllTasksRemove:target task:task];
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            // 网络欠佳的情况
            if (error.code == -1001 || [error.localizedDescription isEqualToString:@"The request timed out."]) {
                NSError *err = [NSError errorWithDomain:@"LGF" code: -1001 userInfo:@{NSLocalizedDescriptionKey:@"当前网络不佳，请检查网络"}];
                error = err;
            }
            if (error.code == -1009) {
                // 网络断开
                NSError *err = [NSError errorWithDomain:@"LGF" code: -1009 userInfo:@{NSLocalizedDescriptionKey:@"似乎已断开与互联网的连接"}];
                error = err;
            }
            if (error.code == 500) {
                NSError *err = [NSError errorWithDomain:@"LGF" code: 500 userInfo:@{NSLocalizedDescriptionKey:@"当前服务不可用，请稍后再试"}];
                error = err;
            }
            lgf_HaveBlock(completed, nil , error);
            [LGFReqest lgf_AllTasksRemove:target task:task];
        }];
    } else if (method == lgf_POST) {
        // POST
        task = [[LGFNetwork lgf_Once] lgf_POST:url parameters:paramt success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            [LGFReqest lgf_AllTasksRemove:target task:task];
            lgf_HaveBlock(completed, responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            // 网络欠佳的情况
            if (error.code == -1001 || [error.localizedDescription isEqualToString:@"The request timed out."]) {
                NSError *err = [NSError errorWithDomain:@"LGF" code: -1001 userInfo:@{NSLocalizedDescriptionKey:@"当前网络不佳，请检查网络"}];
                error = err;
            }
            if (error.code == -1009) {
                // 网络断开
                NSError *err = [NSError errorWithDomain:@"LGF" code: -1009 userInfo:@{NSLocalizedDescriptionKey:@"似乎已断开与互联网的连接"}];
                error = err;
            }
            if (error.code == 500) {
                NSError *err = [NSError errorWithDomain:@"LGF" code: 500 userInfo:@{NSLocalizedDescriptionKey:@"当前服务不可用，请稍后再试"}];
                error = err;
            }
            [LGFReqest lgf_AllTasksRemove:target task:task];
            lgf_HaveBlock(completed, nil , error);
        }];
    }
    [LGFReqest lgf_AllTasksAdd:target task:task];
    return task;
}

#pragma mark - 下载文请求
/**
 @param fileUrl 要下载的文件路径
 @param path 下载的文件保存路径
 @param completed 完成后回调
 */
+ (void)lgf_DownLoadFile:(NSString *)fileUrl saveToPath:(NSString *)path completed:(void(^)(NSURL *url, NSError *error))completed {
    [[LGFNetwork lgf_Once] lgf_DownloadTaskWithRequest:fileUrl saveToPath:path completionHandler:^(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completed(filePath,error);
    }];
}

@end
