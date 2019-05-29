//
//  NSNotificationCenter+OnMainThread.m
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSNotificationCenter+OnMainThread.h"
#include <pthread.h>

@implementation NSNotificationCenter (OnMainThread)

- (void)lgf_PostNotificationOnMainThread:(NSNotification *)notification {
    if (pthread_main_np()) return [self postNotification:notification];
    [self lgf_PostNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void)lgf_PostNotificationOnMainThread:(NSNotification *)notification waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotification:notification];
    [[self class] performSelectorOnMainThread:@selector(lgf_PostNotification:) withObject:notification waitUntilDone:wait];
}

- (void)lgf_PostNotificationOnMainThreadWithName:(NSString *)name object:(id)object {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:nil];
    [self lgf_PostNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void)lgf_PostNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    [self lgf_PostNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void)lgf_PostNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [[self class] performSelectorOnMainThread:@selector(lgf_PostNotificationName:) withObject:info waitUntilDone:wait];
}

+ (void)lgf_PostNotification:(NSNotification *)notification {
    [[self defaultCenter] postNotification:notification];
}

+ (void)lgf_PostNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    
    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

@end
