//
//  LGFFreePTMethod.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFFreePTMethod.h"

@implementation LGFFreePTMethod

#pragma mark - 获取文字size
+ (CGSize)lgf_SizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize size = [str boundingRectWithSize:maxSize
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:dict
                                    context:nil].size;
    return CGSizeMake(size.width, size.height);
}

#pragma mark - UIColorRGB 转颜色数组
+ (NSArray *)lgf_GetColorRGBA:(UIColor *)color {
    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbaComponents;
    if (numOfcomponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbaComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), @(components[3]), nil];
    }
    return rgbaComponents;
}

@end
