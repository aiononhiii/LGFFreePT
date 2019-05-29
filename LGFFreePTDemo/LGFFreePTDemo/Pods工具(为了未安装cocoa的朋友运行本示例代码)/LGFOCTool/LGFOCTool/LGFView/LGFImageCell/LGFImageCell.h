//
//  LGFImageCell.h
//  OptimalLive
//
//  Created by apple on 2019/3/7.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGFImageCell : UICollectionViewCell
@property (assign, nonatomic) CGFloat lgf_ImageSpace;
@property (weak, nonatomic) IBOutlet UIImageView *lgf_Image;
@end

NS_ASSUME_NONNULL_END
