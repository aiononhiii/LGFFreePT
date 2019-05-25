//
//  NSObject+LGFReflection.h
//  LGFOCTool
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LGFReflection)

#pragma mark - 用`NSKeyedArchiver`和``NSKeyedUnarchiver``返回实例的一个副本 如果发生错误则返回nil
- (nullable id)lgf_DeepCopy;

#pragma mark - 返回实例的副本，使用归档程序和解析程序 如果发生错误则返回nil
/**
 @param archiver   NSKeyedArchiver类或任何继承的类。
 @param unarchiver NSKeyedUnarchiver clsas或任何继承的类。
 */
- (nullable id)lgf_DeepCopyWithArchiver:(Class)archiver unarchiver:(Class)unarchiver;

#pragma mark - 类名

- (NSString *)lgf_ClassName;
+ (NSString *)lgf_ClassName;

#pragma mark - 父类名称

- (NSString *)lgf_SuperClassName;
+ (NSString *)lgf_SuperClassName;

#pragma mark - 实例属性字典

-(NSDictionary *)lgf_PropertyDictionary;

#pragma mark - 属性名称列表

- (NSArray*)lgf_PropertyKeys;
+ (NSArray *)lgf_PropertyKeys;

#pragma mark - 属性详细信息列表

- (NSArray *)lgf_PropertiesInfo;
+ (NSArray *)lgf_PropertiesInfo;

#pragma mark - 格式化后的属性列表

+ (NSArray *)lgf_PropertiesWithCodeFormat;

#pragma mark - 方法列表

-(NSArray*)lgf_MethodList;
+(NSArray*)lgf_MethodList;

-(NSArray*)lgf_MethodListInfo;

#pragma mark - 创建并返回一个指向所有已注册类的指针列表

+ (NSArray *)lgf_RegistedClassList;

#pragma mark - 实例变量

+ (NSArray *)lgf_InstanceVariable;

#pragma mark - 协议列表

-(NSDictionary *)lgf_ProtocolList;
+ (NSDictionary *)lgf_ProtocolList;


- (BOOL)lgf_HasPropertyForKey:(NSString*)key;
- (BOOL)lgf_HasIvarForKey:(NSString*)key;

#pragma mark - 保留 N 位小数 取消四舍五入
- (NSString *)lgf_KeepDecimals:(int)num;
@end

NS_ASSUME_NONNULL_END
