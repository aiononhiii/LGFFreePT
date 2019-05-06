//
//  UIButton+LGFImagePosition.h
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, lgf_ImagePosition) {
    lgf_PositionLeft = 0,              //图片在左，文字在右，默认
    lgf_PositionRight = 1,             //图片在右，文字在左
    lgf_PositionTop = 2,               //图片在上，文字在下
    lgf_PositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (LGFImagePosition)

#pragma mark - 给按钮的 上下左右位置 添加图片
/**
 @param postion 图片 相对于 文字位置
 @param spacing 图片和文字间距
 */
- (void)lgf_SetImagePosition:(lgf_ImagePosition)postion spacing:(CGFloat)spacing;

@end
