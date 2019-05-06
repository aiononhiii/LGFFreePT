//
//  NSMutableArray+LGFMutableArray.m
//  LGFOCTool
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSMutableArray+LGFMutableArray.h"

@implementation NSMutableArray (LGFMutableArray)

- (void)lgf_ArraySupplementInteger:(int)column {
    int placeholderCount = column - (self.count % column);
    for (int i = 0; i < placeholderCount; i++) {
        [self addObject:@""];
    }
}

+ (NSMutableArray *)lgf_ArrayWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSMutableArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    if ([array isKindOfClass:[NSMutableArray class]]) return array;
    return nil;
}

+ (NSMutableArray *)lgf_ArrayWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self lgf_ArrayWithPlistData:data];
}

- (void)lgf_RemoveFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)lgf_RemoveLastObject {
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

#pragma clang diagnostic pop


- (id)lgf_PopFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self lgf_RemoveFirstObject];
    }
    return obj;
}

- (id)lgf_PopLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}

- (void)lgf_AppendObject:(id)anObject {
    [self addObject:anObject];
}

- (void)lgf_PrependObject:(id)anObject {
    [self insertObject:anObject atIndex:0];
}

- (void)lgf_AppendObjects:(NSArray *)objects {
    if (!objects) return;
    [self addObjectsFromArray:objects];
}

- (void)lgf_PrependObjects:(NSArray *)objects {
    if (!objects) return;
    NSUInteger i = 0;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)lgf_InsertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)lgf_Reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)lgf_Shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}

- (NSMutableArray *)lgf_CreatDentical:(id)object count:(NSInteger)count {
    [self removeAllObjects];
    for (int i = 0; i < count; i++) {
        [self addObject:object];
    }
    return self;
}

- (NSMutableArray *)lgf_CreatIndexArr:(NSInteger)count {
    [self removeAllObjects];
    for (int i = 0; i < count; i++) {
        [self addObject:[NSString stringWithFormat:@"%d", i]];
    }
    return self;
}

- (NSMutableArray *)lgf_CreatNumberIndexArr:(NSInteger)count {
    [self removeAllObjects];
    for (int i = 0; i < count; i++) {
        [self addObject:@(i)];
    }
    return self;
}

- (void)lgf_RemoveAllThisObject:(NSString *)object {
    if ([self containsObject:object]) {
        for (NSString * obj in self) {
            if ([obj isEqualToString:object]) {
                [self removeObject:obj];
            }
        }
    }
}

@end
