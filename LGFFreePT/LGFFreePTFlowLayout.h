//
//  LGFFreePTFlowLayout.h
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFFreePTStyle.h"

NS_ASSUME_NONNULL_BEGIN
@protocol LGFFreePTFlowLayoutDelegate <NSObject>
@optional

#pragma mark - 自定义分页动画（我这里提供一个配置入口，也可以自己在外面配置 UICollectionViewFlowLayout 原理一样，自己在外面配置的话记得配置 self.scrollDirection = UICollectionViewScrollDirectionHorizontal; self.minimumInteritemSpacing = 0; self.minimumLineSpacing = 0; self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);）
/// @param attributes UICollectionViewLayoutAttributes
/// @param flowLayout UICollectionViewFlowLayout
- (void)lgf_FreePageViewCustomizeAnimation:(NSArray *)attributes flowLayout:(UICollectionViewFlowLayout *)flowLayout;

@end
@interface LGFFreePTFlowLayout : UICollectionViewFlowLayout
@property (weak, nonatomic) id<LGFFreePTFlowLayoutDelegate>lgf_FreePTFlowLayoutDelegate;
@property (assign, nonatomic) lgf_FreePageViewAnimationType lgf_PVAnimationType;
@end

NS_ASSUME_NONNULL_END
