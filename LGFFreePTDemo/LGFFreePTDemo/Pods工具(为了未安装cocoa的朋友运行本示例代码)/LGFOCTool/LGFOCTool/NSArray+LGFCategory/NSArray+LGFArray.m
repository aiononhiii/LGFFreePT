//
//  NSArray+LGFArray.m
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSArray+LGFArray.h"
#import "NSData+LGFEncodeDecode.h"

@implementation NSArray (LGFArray)

+ (NSArray *)lgf_ArrayWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([array isKindOfClass:[NSArray class]]) return array;
    return nil;
}

+ (NSArray *)lgf_ArrayWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self lgf_ArrayWithPlistData:data];
}

- (NSData *)lgf_PlistData {
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)lgf_PlistString {
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData) return xmlData.lgf_Utf8String;
    return nil;
}

- (id)lgf_RandomObject {
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (id)lgf_ObjectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

@end
