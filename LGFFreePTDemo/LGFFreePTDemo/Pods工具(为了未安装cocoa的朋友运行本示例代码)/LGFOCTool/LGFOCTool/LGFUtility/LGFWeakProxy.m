//
//  LGFWeakProxy.m
//  LGFOCTool
//
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFWeakProxy.h"

@implementation LGFWeakProxy

- (instancetype)lgf_InitWithTarget:(id)target {
    _lgf_Target = target;
    return self;
}

+ (instancetype)lgf_ProxyWithTarget:(id)target {
    return [[LGFWeakProxy alloc] lgf_InitWithTarget:target];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _lgf_Target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_lgf_Target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_lgf_Target isEqual:object];
}

- (NSUInteger)hash {
    return [_lgf_Target hash];
}

- (Class)superclass {
    return [_lgf_Target superclass];
}

- (Class)class {
    return [_lgf_Target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_lgf_Target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_lgf_Target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_lgf_Target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_lgf_Target description];
}

- (NSString *)debugDescription {
    return [_lgf_Target debugDescription];
}


@end
