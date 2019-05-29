//
//  UIControl+LGFControl.m
//  LGFOCTool
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIControl+LGFControl.h"
#import "LGFCategoriesMacro.h"
#import <objc/runtime.h>

static const int lgf_block_key;
@interface _LGFUIControlBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;
- (void)lgf_Invoke:(id)sender;

@end

@implementation _LGFUIControlBlockTarget

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events {
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)lgf_Invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@implementation UIControl (LGFControl)

- (void)lgf_RemoveAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock: ^(id object, BOOL *stop) {
        [self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
    }];
    [[self _lgf_allUIControlBlockTargets] removeAllObjects];
}

- (void)lgf_SetTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (!target || !action || !controlEvents) return;
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction)
              forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}

- (void)lgf_AddBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    if (!controlEvents) return;
    _LGFUIControlBlockTarget *target = [[_LGFUIControlBlockTarget alloc]
                                       initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(lgf_Invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self _lgf_allUIControlBlockTargets];
    [targets addObject:target];
}

- (void)lgf_SetBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    [self lgf_RemoveAllBlocksForControlEvents:UIControlEventAllEvents];
    [self lgf_AddBlockForControlEvents:controlEvents block:block];
}

- (void)lgf_RemoveAllBlocksForControlEvents:(UIControlEvents)controlEvents {
    if (!controlEvents) return;
    
    NSMutableArray *targets = [self _lgf_allUIControlBlockTargets];
    NSMutableArray *removes = [NSMutableArray array];
    for (_LGFUIControlBlockTarget *target in targets) {
        if (target.events & controlEvents) {
            UIControlEvents newEvent = target.events & (~controlEvents);
            if (newEvent) {
                [self removeTarget:target action:@selector(lgf_Invoke:) forControlEvents:target.events];
                target.events = newEvent;
                [self addTarget:target action:@selector(lgf_Invoke:) forControlEvents:target.events];
            } else {
                [self removeTarget:target action:@selector(lgf_Invoke:) forControlEvents:target.events];
                [removes addObject:target];
            }
        }
    }
    [targets removeObjectsInArray:removes];
}

- (NSMutableArray *)_lgf_allUIControlBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &lgf_block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &lgf_block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
