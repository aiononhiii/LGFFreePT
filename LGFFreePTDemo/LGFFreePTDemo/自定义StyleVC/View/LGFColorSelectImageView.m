//
//  LGFColorSelectImageView.m
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/14.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "LGFColorSelectImageView.h"
#import "LGFOCTool.h"

@implementation LGFColorSelectImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.image = [UIImage imageNamed:@"colorSelect.png"];
    self.userInteractionEnabled = YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self lgf_GetColor:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self lgf_GetColor:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self lgf_GetColor:touches];
    
}

- (void)lgf_GetColor:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint pointL = [touch locationInView:self];
    if (pow(pointL.x - self.bounds.size.width / 2, 2)+pow(pointL.y - self.bounds.size.width / 2, 2) <= pow(self.bounds.size.width / 2, 2)) {
        UIColor *color = [self.image lgf_ColorAtPixel:pointL];
        lgf_HaveBlock(self.lgf_CurrentColorBlock, color, [color lgf_HexString]);
    }
}

- (void)setImage:(UIImage *)image {
    UIImage *temp = [self lgf_ImageForResizeWithImage:image resize:CGSizeMake(self.frame.size.width, self.frame.size.width)];
    [super setImage:temp];
}

- (UIImage *)lgf_ImageForResizeWithImage:(UIImage *)picture resize:(CGSize)resize {
    CGSize imageSize = resize;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
    [picture drawInRect:imageRect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}


@end
