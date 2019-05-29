//
//  LGFFreePTFlowLayout.m
//  OptimalLive
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019年 QT. All rights reserved.
//

#import "LGFFreePTFlowLayout.h"
#import "UIView+LGFFreePT.h"
#import "LGFFreePTMethod.h"

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
        [LGFFreePTMethod lgf_FreePageViewTopToBottomAnimationConfig:attrs flowLayout:self];
        return attrs;
    } else if (self.lgf_PVAnimationType == lgf_PageViewAnimationSmallToBig) {
        [LGFFreePTMethod lgf_FreePageViewSmallToBigAnimationConfig:attrs flowLayout:self];
        return attrs;
    } else if(self.lgf_PVAnimationType == lgf_PageViewAnimationCustomize) {
        if (self.lgf_FreePTFlowLayoutDelegate && [self.lgf_FreePTFlowLayoutDelegate respondsToSelector:@selector(lgf_FreePageViewCustomizeAnimation:flowLayout:)]) {
            LGFPTLog(@"自定义分页动画的 contentOffset.x:%f", self.collectionView.contentOffset.x);
            [self.lgf_FreePTFlowLayoutDelegate lgf_FreePageViewCustomizeAnimation:attrs flowLayout:self];
        }
        return attrs;
    } else {
        return attrs;
    }
}

@end
