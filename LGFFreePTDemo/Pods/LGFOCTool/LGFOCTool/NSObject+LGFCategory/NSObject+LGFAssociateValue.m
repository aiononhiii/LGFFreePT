//
//  NSObject+LGFAssociateValue.m
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSObject+LGFAssociateValue.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation NSObject (LGFAssociateValue)

- (void)lgf_SetAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lgf_SetAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)lgf_RemoveAssociatedValues {
    objc_removeAssociatedObjects(self);
}

- (id)lgf_GetAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}


@end
