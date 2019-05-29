//
//  NSString+LGFNSNumberCompatible.m
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSString+LGFNSNumberCompatible.h"
#import "NSString+LGFString.h"

@implementation NSString (LGFNSNumberCompatible)

- (char)lgf_CharValue {
    return self.lgf_NumberValue.charValue;
}

- (unsigned char)lgf_UnsignedCharValue {
    return self.lgf_NumberValue.unsignedCharValue;
}

- (short)lgf_ShortValue {
    return self.lgf_NumberValue.shortValue;
}

- (unsigned short)lgf_UnsignedShortValue {
    return self.lgf_NumberValue.unsignedShortValue;
}

- (unsigned int)lgf_UnsignedIntValue {
    return self.lgf_NumberValue.unsignedIntValue;
}

- (long)lgf_LongValue {
    return self.lgf_NumberValue.longValue;
}

- (unsigned long)lgf_UnsignedLongValue {
    return self.lgf_NumberValue.unsignedLongValue;
}

- (unsigned long long)lgf_UnsignedLongLongValue {
    return self.lgf_NumberValue.unsignedLongLongValue;
}

- (NSUInteger)lgf_UnsignedIntegerValue {
    return self.lgf_NumberValue.unsignedIntegerValue;
}

@end
