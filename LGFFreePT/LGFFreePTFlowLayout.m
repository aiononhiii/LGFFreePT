//
//  LGFFreePTFlowLayout.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFFreePTFlowLayout.h"
#import "UIView+LGFFreePT.h"

@implementation LGFFreePTFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    if (self.lgf_PVAnimationType == lgf_PageViewAnimationTopToBottom) {
        CGFloat contentOffsetX = self.collectionView.contentOffset.x;
        CGFloat collectionViewCenterX = self.collectionView.lgfpt_Width * 0.5;
        for (UICollectionViewLayoutAttributes *attr in attrs) {
            CGFloat alpha = fabs(1.0 - fabs(attr.center.x - contentOffsetX - collectionViewCenterX) /self.collectionView.lgfpt_Width);
            CGFloat scale = -fabs(fabs(attr.center.x - contentOffsetX - collectionViewCenterX) /self.collectionView.lgfpt_Width) * 50.0;
            NSInteger index = fabs(self.collectionView.contentOffset.x / self.collectionView.lgfpt_Width);
            if ([self.collectionView.panGestureRecognizer translationInView:self.collectionView].x < 0.0) {
                if (attr.indexPath.item != index) {
                    attr.alpha = alpha;
                }
            } else {
                if (attr.indexPath.item == index) {
                    attr.alpha = alpha;
                }
            }
            attr.transform = CGAffineTransformMakeTranslation(0, scale);
        }
        return attrs;
    } else if (self.lgf_PVAnimationType == lgf_PageViewAnimationSmallToBig) {
        CGFloat contentOffsetX = self.collectionView.contentOffset.x;
        CGFloat collectionViewCenterX = self.collectionView.lgfpt_Width * 0.5;
        for (UICollectionViewLayoutAttributes *attr in attrs) {
            CGFloat scale = (1.0 - fabs(attr.center.x - contentOffsetX - collectionViewCenterX) /self.collectionView.lgfpt_Width * 0.8);
            attr.transform = CGAffineTransformMakeScale(scale, scale);
        }
        return attrs;
    } else {
        return attrs;
    }
}

@end
