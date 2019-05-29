//
//  NSObject+LGFKVOBlocks.h
//  LGFOCTool
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LGFKVOBlock)(NSDictionary *change, void *context);

@interface NSObject (LGFKVOBlocks)

#pragma mark - 给某个 NSObject 注册KVO监听 使用block进行回调
/**
 @param observer 监听对象
 @param keyPath 监听 属性 key 值
 @param options NSKeyValueObservingOptions
 @param context 附带内容
 @param block block回调
 */
+ (void)lgf_AddObserver:(NSObject *)observer
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(void *)context
          withBlock:(LGFKVOBlock)block;

#pragma mark - 删除某个 NSObject 的 KVO BLOCK 监听
/**
 @param observer 监听对象
 @param keyPath 监听 属性 key 值
 */
+ (void)lgf_RemoveBlockObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath;

#pragma mark - 给自己注册KVO监听 使用block进行回调
/**
 @param keyPath 监听 属性 key 值
 @param options NSKeyValueObservingOptions
 @param context 附带内容
 @param block block回调
 */
- (void)lgf_AddObserverForKeyPath:(NSString *)keyPath
                     options:(NSKeyValueObservingOptions)options
                     context:(void *)context
                   withBlock:(LGFKVOBlock)block;

#pragma mark - 删除自己的 KVO BLOCK 监听
/**
 @param keyPath 监听 属性 key 值
 */
- (void)lgf_RemoveBlockObserverForKeyPath:(NSString *)keyPath;

@end
