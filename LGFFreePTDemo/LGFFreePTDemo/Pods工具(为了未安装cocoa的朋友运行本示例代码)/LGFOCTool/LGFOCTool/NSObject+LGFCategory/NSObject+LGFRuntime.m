//
//  NSObject+LGFRuntime.m
//  LGFOCTool
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSObject+LGFRuntime.h"

BOOL lgf_Method_swizzle(Class klass, SEL origSel, SEL altSel) {
    if (!klass) return NO;
    Method __block origMethod, __block altMethod;
    void (^find_methods)(void) = ^{
        unsigned methodCount = 0;
        Method *methodList = class_copyMethodList(klass, &methodCount);
        origMethod = altMethod = NULL;
        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i) {
                if (method_getName(methodList[i]) == origSel)
                    origMethod = methodList[i];
                if (method_getName(methodList[i]) == altSel)
                    altMethod = methodList[i];
            }
        free(methodList);
    };
    find_methods();
    if (!origMethod) {
        origMethod = class_getInstanceMethod(klass, origSel);
        if (!origMethod) return NO;
        if (!class_addMethod(klass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod))) return NO;
    }
    if (!altMethod) {
        altMethod = class_getInstanceMethod(klass, altSel);
        if (!altMethod) return NO;
        if (!class_addMethod(klass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod))) return NO;
    }
    find_methods();
    if (!origMethod || !altMethod) return NO;
    method_exchangeImplementations(origMethod, altMethod);
    return YES;
}

void lgf_Method_append(Class toClass, Class fromClass, SEL selector) {
    if (!toClass || !fromClass || !selector) return;
    Method method = class_getInstanceMethod(fromClass, selector);
    if (!method) return;
    class_addMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

void lgf_Method_replace(Class toClass, Class fromClass, SEL selector) {
    if (!toClass || !fromClass || ! selector) return;
    Method method = class_getInstanceMethod(fromClass, selector);
    if (!method) return;
    class_replaceMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

@implementation NSObject (LGFRuntime)

#pragma mark - 交换方法实现
/**
 @param originalMethod 被替换的方法
 @param newMethod 替换的方法
 */
+ (void)lgf_SwizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod {
    lgf_Method_swizzle(self.class, originalMethod, newMethod);
}

#pragma mark - 动态添加一个新方法
/**
 @param newMethod 添加的方法
 @param klass 添加方法的类
 */
+ (void)lgf_AppendMethod:(SEL)newMethod fromClass:(Class)klass {
    lgf_Method_append(self.class, klass, newMethod);
}

#pragma mark - 替换某个对象的方法
/**
 @param method 要替换的方法.
 @param klass 要替换的方法 的类.
 */
+ (void)lgf_ReplaceMethod:(SEL)method fromClass:(Class)klass {
    lgf_Method_replace(self.class, klass, method);
}

#pragma mark - Check whether the receiver implements or inherits a specified method up to and exluding a particular class in hierarchy.
/**
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)lgf_RespondsToSelector:(SEL)selector untilClass:(Class)stopClass {
    return [self.class lgf_InstancesRespondToSelector:selector untilClass:stopClass];
}

#pragma mark - Check whether a superclass implements or inherits a specified method.
/**
 @param selector A selector that identifies a method.
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)lgf_SuperRespondsToSelector:(SEL)selector {
    return [self.superclass instancesRespondToSelector:selector];
}

#pragma mark - Check whether a superclass implements or inherits a specified method.
/**
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)lgf_SuperRespondsToSelector:(SEL)selector untilClass:(Class)stopClass {
    return [self.superclass lgf_InstancesRespondToSelector:selector untilClass:stopClass];
}

#pragma mark - Check whether the receiver's instances implement or inherit a specified method up to and exluding a particular class in hierarchy.
/**
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
+ (BOOL)lgf_InstancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass {
    BOOL __block (^ __weak block_self)(Class klass, SEL selector, Class stopClass);
    BOOL (^block)(Class klass, SEL selector, Class stopClass) = [^
                                                                 (Class klass, SEL selector, Class stopClass) {
                                                                     if (!klass || klass == stopClass) return NO;
                                                                     unsigned methodCount = 0;
                                                                     Method *methodList = class_copyMethodList(klass, &methodCount);
                                                                     if (methodList)
                                                                         for (unsigned i = 0; i < methodCount; ++i)
                                                                             if (method_getName(methodList[i]) == selector) return YES;
                                                                     return block_self(klass.superclass, selector, stopClass);
                                                                 } copy];
    block_self = block;
    return block(self.class, selector, stopClass);
}

@end
