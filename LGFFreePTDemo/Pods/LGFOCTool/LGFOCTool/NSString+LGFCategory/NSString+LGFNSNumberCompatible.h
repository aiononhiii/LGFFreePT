//
//  NSString+LGFNSNumberCompatible.h
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGFNSNumberCompatible)

@property (readonly) char lgf_CharValue;
@property (readonly) unsigned char lgf_UnsignedCharValue;
@property (readonly) short lgf_ShortValue;
@property (readonly) unsigned short lgf_UnsignedShortValue;
@property (readonly) unsigned int lgf_UnsignedIntValue;
@property (readonly) long lgf_LongValue;
@property (readonly) unsigned long lgf_UnsignedLongValue;
@property (readonly) unsigned long long lgf_UnsignedLongLongValue;
@property (readonly) NSUInteger lgf_UnsignedIntegerValue;

@end
