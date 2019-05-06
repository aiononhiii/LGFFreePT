//
//  LGFEmojiCell.h
//  OptimalLive
//
//  Created by apple on 2019/4/17.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGFEmojiCell : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_EmojiLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_EmojiRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_EmojiTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_EmojiBottom;
@property (weak, nonatomic) IBOutlet UIImageView *lgf_EmojiImage;
@property (assign, nonatomic) CGFloat lgf_EmojiSpacing;
lgf_XibViewForH;
@end

NS_ASSUME_NONNULL_END
