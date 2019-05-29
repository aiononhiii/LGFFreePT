//
//  LGFImageTitleCell.h
//  OptimalLive
//
//  Created by apple on 2019/3/6.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGFImageTitleCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_ImageWidth;
@property (weak, nonatomic) IBOutlet UIImageView *lgf_Image;
@property (weak, nonatomic) IBOutlet UILabel *lgf_Title;
@end

NS_ASSUME_NONNULL_END
