//
//  VerticalViewControllerOneCell.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "VerticalViewControllerOneCell.h"
#import "UIImage+ForceDecode.h"
#import "LGFOCTool.h"

@implementation VerticalViewControllerOneCell

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img = [UIImage decodedImageWithImage:lgf_Image(imageName)];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image.backgroundColor = [UIColor clearColor];
            [self.image setImage:img];
        });
    });
}

@end
