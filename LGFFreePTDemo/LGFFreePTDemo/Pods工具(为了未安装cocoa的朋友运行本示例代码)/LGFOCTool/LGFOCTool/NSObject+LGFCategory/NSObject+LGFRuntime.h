//
//  NSObject+LGFRuntime.h
//  LGFOCTool
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFOCTool.h"

@interface NSObject (LGFRuntime)

#pragma mark - 交换方法实现
/**
 @param originalMethod 被替换的方法
 @param newMethod 替换的方法
 */
+ (void)lgf_SwizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

#pragma mark - 动态添加一个新方法
/**
 @param newMethod 添加的方法
 @param klass 添加方法的类
 */
+ (void)lgf_AppendMethod:(SEL)newMethod fromClass:(Class)klass;

#pragma mark - 替换某个对象的方法
/**
 @param method 要替换的方法.
 @param klass 要替换的方法 的类.
 */
+ (void)lgf_ReplaceMethod:(SEL)method fromClass:(Class)klass;

#pragma mark - Check whether the receiver implements or inherits a specified method up to and exluding a particular class in hierarchy.
/**
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)lgf_RespondsToSelector:(SEL)selector untilClass:(Class)stopClass;

#pragma mark - Check whether a superclass implements or inherits a specified method.
/**
 @param selector A selector that identifies a method.
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)lgf_SuperRespondsToSelector:(SEL)selector;

#pragma mark - Check whether a superclass implements or inherits a specified method.
/**
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)lgf_SuperRespondsToSelector:(SEL)selector untilClass:(Class)stopClass;

#pragma mark - Check whether the receiver's instances implement or inherit a specified method up to and exluding a particular class in hierarchy.
/**
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
+ (BOOL)lgf_InstancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass;


@end
