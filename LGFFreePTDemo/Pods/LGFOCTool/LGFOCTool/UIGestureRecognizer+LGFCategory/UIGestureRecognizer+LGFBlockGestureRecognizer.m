//
//  UIGestureRecognizer+LGFBlockGestureRecognizer.m
//  LGFOCTool
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIGestureRecognizer+LGFBlockGestureRecognizer.h"
#import "LGFCategoriesMacro.h"
#import <objc/runtime.h>

static const int block_key;

@interface LGFUIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithLGFBlock:(void (^)(id sender))block;
- (void)lgf_Invoke:(id)sender;

@end

@implementation LGFUIGestureRecognizerBlockTarget

- (id)initWithLGFBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)lgf_Invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@implementation UIGestureRecognizer (LGFBlockGestureRecognizer)

- (instancetype)initWithActionLGFBlock:(void (^)(id sender))block {
    self = [self init];
    [self lgf_AddActionBlock:block];
    return self;
}

- (void)lgf_AddActionBlock:(void (^)(id sender))block {
    LGFUIGestureRecognizerBlockTarget *target = [[LGFUIGestureRecognizerBlockTarget alloc] initWithLGFBlock:block];
    [self addTarget:target action:@selector(lgf_Invoke:)];
    NSMutableArray *targets = [self _lgf_allUIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (void)lgf_RemoveAllActionBlocks {
    NSMutableArray *targets = [self _lgf_allUIGestureRecognizerBlockTargets];
    [targets enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
        [self removeTarget:target action:@selector(lgf_Invoke:)];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)_lgf_allUIGestureRecognizerBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}
@end
