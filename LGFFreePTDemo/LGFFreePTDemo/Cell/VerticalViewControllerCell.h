//
//  VerticalViewControllerCell.h
//  LGFFreePTDemo
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerticalViewControllerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *editBack;
@property (weak, nonatomic) IBOutlet UIImageView *deleteAndAdd;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (copy, nonatomic) NSString *imageName;
@property (assign, nonatomic) BOOL isEdit;
@end

NS_ASSUME_NONNULL_END
