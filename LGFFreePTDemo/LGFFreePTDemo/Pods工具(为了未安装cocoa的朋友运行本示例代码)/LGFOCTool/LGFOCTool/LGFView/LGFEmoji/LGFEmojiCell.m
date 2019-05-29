//
//  LGFEmojiCell.m
//  OptimalLive
//
//  Created by apple on 2019/4/17.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFEmojiCell.h"

@implementation LGFEmojiCell

lgf_XibViewForM(LGFEmojiCell, @"LGFOCTool");
- (void)setLgf_EmojiSpacing:(CGFloat)lgf_EmojiSpacing {
    _lgf_EmojiSpacing = lgf_EmojiSpacing;
    self.lgf_EmojiLeft.constant = lgf_EmojiSpacing;
    self.lgf_EmojiRight.constant = lgf_EmojiSpacing;
    self.lgf_EmojiTop.constant = lgf_EmojiSpacing;
    self.lgf_EmojiBottom.constant = lgf_EmojiSpacing;
    [self layoutIfNeeded];
}

@end
