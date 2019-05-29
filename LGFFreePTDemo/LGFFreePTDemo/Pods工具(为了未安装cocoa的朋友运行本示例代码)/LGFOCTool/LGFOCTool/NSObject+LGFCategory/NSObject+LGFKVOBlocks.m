//
//  NSObject+LGFKVOBlocks.m
//  LGFOCTool
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSObject+LGFKVOBlocks.h"
#import "LGFOCTool.h"

@implementation NSObject (LGFKVOBlocks)

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
         withBlock:(LGFKVOBlock)block {
    
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), block, OBJC_ASSOCIATION_COPY);
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}

#pragma mark - 删除某个 NSObject 的 KVO BLOCK 监听
/**
 @param observer 监听对象
 @param keyPath 监听 属性 key 值
 */
+ (void)lgf_RemoveBlockObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath {
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), nil, OBJC_ASSOCIATION_COPY);
    [self removeObserver:observer forKeyPath:keyPath];
}

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
                   withBlock:(LGFKVOBlock)block {
    objc_setAssociatedObject(self, (__bridge const void *)(keyPath), block, OBJC_ASSOCIATION_COPY);
    [self addObserver:self forKeyPath:keyPath options:options context:context];
}

#pragma mark - 删除自己的 KVO BLOCK 监听
/**
 @param keyPath 监听 属性 key 值
 */
- (void)lgf_RemoveBlockObserverForKeyPath:(NSString *)keyPath {
    objc_setAssociatedObject(self, (__bridge const void *)(keyPath), nil, OBJC_ASSOCIATION_COPY);
    [self removeObserver:self forKeyPath:keyPath];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL observeValueForKeyPath = @selector(observeValueForKeyPath:ofObject:change:context:);
        SEL lgf_ObserveValueForKeyPath = @selector(lgf_ObserveValueForKeyPath:ofObject:change:context:);
        [class lgf_SwizzleMethod:observeValueForKeyPath withMethod:lgf_ObserveValueForKeyPath];
    });
}

- (void)lgf_ObserveValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    LGFKVOBlock block = objc_getAssociatedObject(self, (__bridge const void *)(keyPath));
    block(change, context);
}

@end
