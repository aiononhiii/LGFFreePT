//
//  VerticalViewControllerOneCell.h
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerticalViewControllerOneCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (copy, nonatomic) NSString *imageName;
@end

NS_ASSUME_NONNULL_END
