//
//  NSString+LGFHash.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "NSString+LGFHash.h"
#import "NSData+LGFHash.h"

@implementation NSString (LGFHash)

- (NSString *)lgf_Md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_Md2String];
}

- (NSString *)lgf_Md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_Md4String];
}

- (NSString *)lgf_Md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_Md5String];
}

- (NSString *)lgf_Sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_Sha1String];
}

- (NSString *)lgf_Sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_Sha224String];
}

- (NSString *)lgf_Sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_Sha256String];
}

- (NSString *)lgf_Sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_Sha384String];
}

- (NSString *)lgf_Sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_Sha512String];
}

- (NSString *)lgf_Crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_Crc32String];
}

- (NSString *)lgf_HmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_HmacMD5StringWithKey:key];
}

- (NSString *)lgf_HmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_HmacSHA1StringWithKey:key];
}

- (NSString *)lgf_HmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_HmacSHA224StringWithKey:key];
}

- (NSString *)lgf_HmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_HmacSHA256StringWithKey:key];
}

- (NSString *)lgf_HmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_HmacSHA384StringWithKey:key];
}

- (NSString *)lgf_HmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lgf_HmacSHA512StringWithKey:key];
}

@end
