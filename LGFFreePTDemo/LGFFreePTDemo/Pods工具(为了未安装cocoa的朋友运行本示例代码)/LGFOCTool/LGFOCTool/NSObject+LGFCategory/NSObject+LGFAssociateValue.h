//
//  NSObject+LGFAssociateValue.h
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LGFAssociateValue)

#pragma mark - 给 self 动态添加一个 (strong，nonatomic）属性 并关联某一个对象
/**
 @param value   要关联的对象。
 @param key     从`self`获取值的指针（属性名字）
 */
- (void)lgf_SetAssociateValue:(nullable id)value withKey:(void *)key;

#pragma mark - 给 self 动态添加一个 (week，nonatomic）属性 并关联某一个对象
/**
 @param value  要关联的对象。
 @param key    从`self`获取值的指针（属性名字）
 */
- (void)lgf_SetAssociateWeakValue:(nullable id)value withKey:(void *)key;

#pragma mark - 从 self 获取相关动态属性对象值
/**
 @param key 从 self 获取值的指针。
 */
- (nullable id)lgf_GetAssociatedValueForKey:(void *)key;

#pragma mark - 删除所有动态添加的属性值
- (void)lgf_RemoveAssociatedValues;


@end

NS_ASSUME_NONNULL_END
