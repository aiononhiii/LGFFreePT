//
//  NSDictionary+LGFDictionary.m
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSDictionary+LGFDictionary.h"
#import "LGFOCTool.h"
#import "NSString+LGFString.h"

@interface lgf_XMLDictionaryParser : NSObject <NSXMLParserDelegate>
@end

@implementation lgf_XMLDictionaryParser {
    NSMutableDictionary *_root;
    NSMutableArray *_stack;
    NSMutableString *_text;
}

- (instancetype)initWithData:(NSData *)data {
    self = super.init;
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    return self;
}

- (instancetype)initWithString:(NSString *)xml {
    NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
    return [self initWithData:data];
}

- (NSDictionary *)result {
    return _root;
}

#pragma mark NSXMLParserDelegate

#define XMLText @"_text"
#define XMLName @"_name"
#define XMLPref @"_"

- (void)lgf_TextEnd {
    _text = _text.lgf_StringByTrim.mutableCopy;
    if (_text.length) {
        NSMutableDictionary *top = _stack.lastObject;
        id existing = top[XMLText];
        if ([existing isKindOfClass:[NSArray class]]) {
            [existing addObject:_text];
        } else if (existing) {
            top[XMLText] = [@[existing, _text] mutableCopy];
        } else {
            top[XMLText] = _text;
        }
    }
    _text = nil;
}

- (void)parser:(__unused NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(__unused NSString *)namespaceURI qualifiedName:(__unused NSString *)qName attributes:(NSDictionary *)attributeDict {
    [self lgf_TextEnd];
    
    NSMutableDictionary *node = [NSMutableDictionary new];
    if (!_root) node[XMLName] = elementName;
    if (attributeDict.count) [node addEntriesFromDictionary:attributeDict];
    
    if (_root) {
        NSMutableDictionary *top = _stack.lastObject;
        id existing = top[elementName];
        if ([existing isKindOfClass:[NSArray class]]) {
            [existing addObject:node];
        } else if (existing) {
            top[elementName] = [@[existing, node] mutableCopy];
        } else {
            top[elementName] = node;
        }
        [_stack addObject:node];
    } else {
        _root = node;
        _stack = [NSMutableArray arrayWithObject:node];
    }
}

- (void)parser:(__unused NSXMLParser *)parser didEndElement:(__unused NSString *)elementName namespaceURI:(__unused NSString *)namespaceURI qualifiedName:(__unused NSString *)qName {
    [self lgf_TextEnd];
    
    NSMutableDictionary *top = _stack.lastObject;
    [_stack removeLastObject];
    
    NSMutableDictionary *left = top.mutableCopy;
    [left removeObjectsForKeys:@[XMLText, XMLName]];
    for (NSString *key in left.allKeys) {
        [left removeObjectForKey:key];
        if ([key hasPrefix:XMLPref]) {
            left[[key substringFromIndex:XMLPref.length]] = top[key];
        }
    }
    if (left.count) return;
    
    NSMutableDictionary *children = top.mutableCopy;
    [children removeObjectsForKeys:@[XMLText, XMLName]];
    for (NSString *key in children.allKeys) {
        if ([key hasPrefix:XMLPref]) {
            [children removeObjectForKey:key];
        }
    }
    if (children.count) return;
    
    NSMutableDictionary *topNew = _stack.lastObject;
    NSString *nodeName = top[XMLName];
    if (!nodeName) {
        for (NSString *name in topNew) {
            id object = topNew[name];
            if (object == top) {
                nodeName = name; break;
            } else if ([object isKindOfClass:[NSArray class]] && [object containsObject:top]) {
                nodeName = name; break;
            }
        }
    }
    if (!nodeName) return;
    
    id inner = top[XMLText];
    if ([inner isKindOfClass:[NSArray class]]) {
        inner = [inner componentsJoinedByString:@"\n"];
    }
    if (!inner) return;
    
    id parent = topNew[nodeName];
    if ([parent isKindOfClass:[NSArray class]]) {
        parent[[parent count] - 1] = inner;
    } else {
        topNew[nodeName] = inner;
    }
}

- (void)parser:(__unused NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (_text) [_text appendString:string];
    else _text = [NSMutableString stringWithString:string];
}

- (void)parser:(__unused NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    NSString *string = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    if (_text) [_text appendString:string];
    else _text = [NSMutableString stringWithString:string];
}

#undef XMLText
#undef XMLName
#undef XMLPref
@end

@implementation NSDictionary (LGFDictionary)

+ (NSDictionary *)lgf_DictionaryWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([dictionary isKindOfClass:[NSDictionary class]]) return dictionary;
    return nil;
}

+ (NSDictionary *)lgf_DictionaryWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self lgf_DictionaryWithPlistData:data];
}

- (NSData *)lgf_PlistData {
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)lgf_PlistString {
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData) return xmlData.lgf_Utf8String;
    return nil;
}

- (NSArray *)lgf_AllKeysSorted {
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)lgf_AllValuesSortedByKeys {
    NSArray *sortedKeys = [self lgf_AllKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return arr;
}

- (BOOL)lgf_ContainsObjectForKey:(id)key {
    if (!key) return NO;
    return self[key] != nil;
}

- (NSDictionary *)lgf_EntriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) dic[key] = value;
    }
    return dic;
}

+ (NSDictionary *)lgf_DictionaryWithXML:(id)xml {
    lgf_XMLDictionaryParser *parser = nil;
    if ([xml isKindOfClass:[NSString class]]) {
        parser = [[lgf_XMLDictionaryParser alloc] initWithString:xml];
    } else if ([xml isKindOfClass:[NSData class]]) {
        parser = [[lgf_XMLDictionaryParser alloc] initWithData:xml];
    }
    return [parser result];
}

/// Get a number value from 'id'.
static NSNumber *lgf_NSNumberFromID(id value) {
    static NSCharacterSet *dot;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
    });
    if (!value || value == [NSNull null]) return nil;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) {
        NSString *lower = ((NSString *)value).lowercaseString;
        if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) return @(YES);
        if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]) return @(NO);
        if ([lower isEqualToString:@"nil"] || [lower isEqualToString:@"null"]) return nil;
        if ([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            return @(((NSString *)value).doubleValue);
        } else {
            return @(((NSString *)value).longLongValue);
        }
    }
    return nil;
}

#define lgf_RETURN_VALUE(_type_)                                                     \
if (!key) return def;                                                                \
id value = self[key];                                                                \
if (!value || value == [NSNull null]) return def;                                    \
if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value)._type_;       \
if ([value isKindOfClass:[NSString class]]) return lgf_NSNumberFromID(value)._type_; \
return def;

- (BOOL)lgf_BoolValueForKey:(NSString *)key default:(BOOL)def {
    lgf_RETURN_VALUE(boolValue);
}

- (char)lgf_CharValueForKey:(NSString *)key default:(char)def {
    lgf_RETURN_VALUE(charValue);
}

- (unsigned char)lgf_UnsignedCharValueForKey:(NSString *)key default:(unsigned char)def {
    lgf_RETURN_VALUE(unsignedCharValue);
}

- (short)lgf_ShortValueForKey:(NSString *)key default:(short)def {
    lgf_RETURN_VALUE(shortValue);
}

- (unsigned short)lgf_UnsignedShortValueForKey:(NSString *)key default:(unsigned short)def {
    lgf_RETURN_VALUE(unsignedShortValue);
}

- (int)lgf_IntValueForKey:(NSString *)key default:(int)def {
    lgf_RETURN_VALUE(intValue);
}

- (unsigned int)lgf_UnsignedIntValueForKey:(NSString *)key default:(unsigned int)def {
    lgf_RETURN_VALUE(unsignedIntValue);
}

- (long)lgf_LongValueForKey:(NSString *)key default:(long)def {
    lgf_RETURN_VALUE(longValue);
}

- (unsigned long)lgf_UnsignedLongValueForKey:(NSString *)key default:(unsigned long)def {
    lgf_RETURN_VALUE(unsignedLongValue);
}

- (long long)lgf_LongLongValueForKey:(NSString *)key default:(long long)def {
    lgf_RETURN_VALUE(longLongValue);
}

- (unsigned long long)lgf_UnsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def {
    lgf_RETURN_VALUE(unsignedLongLongValue);
}

- (float)lgf_FloatValueForKey:(NSString *)key default:(float)def {
    lgf_RETURN_VALUE(floatValue);
}

- (double)lgf_DoubleValueForKey:(NSString *)key default:(double)def {
    lgf_RETURN_VALUE(doubleValue);
}

- (NSInteger)lgf_IntegerValueForKey:(NSString *)key default:(NSInteger)def {
    lgf_RETURN_VALUE(integerValue);
}

- (NSUInteger)lgf_UnsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def {
    lgf_RETURN_VALUE(unsignedIntegerValue);
}

- (NSNumber *)lgf_NumberValueForKey:(NSString *)key default:(NSNumber *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) return lgf_NSNumberFromID(value);
    return def;
}

- (NSString *)lgf_StringValueForKey:(NSString *)key default:(NSString *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSString class]]) return value;
    if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value).description;
    return def;
}

@end
