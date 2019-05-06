//
//  LGFGetPhoto.h
//  LGFOCTool
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFOCTool.h"

typedef NS_ENUM(NSUInteger, LGFGetPhotoType) {
    LGFPhoto,
    LGFCamera,
};
@interface LGFGetPhoto : NSObject
typedef void(^lgf_ReturnImage) (UIImage *image);
lgf_AllocOnceForH;
/**
 调用系统相册，拍照
 */
- (void)lgf_GetPhoto:(UIViewController *)SVC type:(LGFGetPhotoType)type returnImage:(lgf_ReturnImage)returnImage;

@end
