//
//  LGFImageCell.m
//  OptimalLive
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFImageCell.h"

@interface LGFImageCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_ImageRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_ImageLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_ImageBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_ImageTop;
@end
@implementation LGFImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setLgf_ImageSpace:(CGFloat)lgf_ImageSpace {
    _lgf_ImageSpace = lgf_ImageSpace;
    self.lgf_ImageRight.constant = 5;
    self.lgf_ImageLeft.constant = 5;
    self.lgf_ImageBottom.constant = 5;
    self.lgf_ImageTop.constant = 5;
}

@end
