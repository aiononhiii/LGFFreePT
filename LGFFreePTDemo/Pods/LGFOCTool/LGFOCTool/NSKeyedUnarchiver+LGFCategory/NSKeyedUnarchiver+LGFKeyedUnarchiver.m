//
//  NSKeyedUnarchiver+LGFKeyedUnarchiver.m
//  LGFOCTool
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSKeyedUnarchiver+LGFKeyedUnarchiver.h"

@implementation NSKeyedUnarchiver (LGFKeyedUnarchiver)

+ (id)lgf_UnarchiveObjectWithData:(NSData *)data exception:(__autoreleasing NSException **)exception {
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *e)
    {
        if (exception) *exception = e;
    }
    @finally
    {
    }
    return object;
}

+ (id)lgf_UnarchiveObjectWithFile:(NSString *)path exception:(__autoreleasing NSException **)exception {
    id object = nil;
    
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    @catch (NSException *e)
    {
        if (exception) *exception = e;
    }
    @finally
    {
    }
    return object;
}

@end
