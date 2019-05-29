//
//  NSNotificationCenter+OnMainThread.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (OnMainThread)

#pragma mark - 在主线程上发送给定的通知给接收器 如果当前线程是主线程 则同步发布通知 否则 异步发布通知
/**
 @param notification 要发布的通知.
 如果通知为nil, 则会引发异常
 */
- (void)lgf_PostNotificationOnMainThread:(NSNotification *)notification;

#pragma mark - 在主线程上发送给定的通知给接收器
/**
 @param notification 要发布的通知.
 如果通知为nil, 则会引发异常
 @param wait 一个布尔值，指定当前线程是否阻塞
   直到在指定的通知发布之后
   接收器在主线程上。 指定YES以阻止此操作
   线; 否则，指定NO返回此方法
   立即。
 */
- (void)lgf_PostNotificationOnMainThread:(NSNotification *)notification
                       waitUntilDone:(BOOL)wait;

#pragma mark 使用给定名称和发件人创建通知并将其发布给 主线上的接收器 如果当前线程是主线程 则同步发布通知 否则 异步发布通知
/**
 @param name    要发布的通知名字
 @param object  发布通知的对象
 */
- (void)lgf_PostNotificationOnMainThreadWithName:(NSString *)name
                                      object:(nullable id)object;

#pragma mark - 使用给定名称和发件人创建通知并将其发布给 主线上的接收器 如果当前线程是主线程 则同步发布通知 否则 异步发布通知
/**
 @param name      要发布的通知名字
 @param object    发布通知的对象
 @param userInfo  有关通知的信息, 可以为nil
 */
- (void)lgf_PostNotificationOnMainThreadWithName:(NSString *)name
                                      object:(nullable id)object
                                    userInfo:(nullable NSDictionary *)userInfo;

#pragma mark - 使用给定名称和发件人创建通知并将其发布给 主线上的接收器
/**
 @param name     要发布的通知名字
 @param object   发布通知的对象
 @param userInfo 有关通知的信息, 可以为nil
 @param wait     一个布尔值，指定当前线程是否阻塞
   直到在指定的通知发布之后
   接收器在主线程上。 指定YES以阻止此操作
   线; 否则，指定NO返回此方法
   立即。
 */
- (void)lgf_PostNotificationOnMainThreadWithName:(NSString *)name
                                      object:(nullable id)object
                                    userInfo:(nullable NSDictionary *)userInfo
                               waitUntilDone:(BOOL)wait;

@end

NS_ASSUME_NONNULL_END
