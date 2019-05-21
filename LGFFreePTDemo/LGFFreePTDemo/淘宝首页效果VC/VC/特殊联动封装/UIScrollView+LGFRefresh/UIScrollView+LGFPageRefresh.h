//
//  UIScrollView+LGFLGFMJRefresh.h
//  OptimalLive
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"
#import "LGFMJRefresh.h"

#undef LGFPageMJHeader
#define LGFPageMJHeader(Target, SEL) [LGFMJRefreshNormalHeader headerWithRefreshingTarget:Target refreshingAction:SEL]
#undef LGFPageMJGifHeader
#define LGFPageMJGifHeader(Target, SEL) [LGFMJRefreshGifHeader headerWithRefreshingTarget:Target refreshingAction:SEL]
#undef LGFPageMJFooter
#define LGFPageMJFooter(Target, SEL) [LGFMJRefreshAutoNormalFooter footerWithRefreshingTarget:Target refreshingAction:SEL]

@interface UIScrollView (LGFPageRefresh)
// 我是有底线的view
@property (nonatomic, strong) UIView *lgf_PageNoMoreView;
@property (nonatomic, strong) LGFMJRefreshHeader *lgf_PageHeader;
@property (nonatomic, strong) LGFMJRefreshFooter *lgf_PageFooter;
// header 和 footer 同时结束刷新
- (void)lgf_PageEndRefreshing;
// 传入 数据数组count 判断是否要显示 我是有底线的view 并且刷新
- (void)lgf_PageReloadData:(NSInteger)count dataArrayCount:(NSInteger)dataArrayCount;

- (void)lgf_PageReloadData:(NSInteger)count noDataViewType:(NSInteger)noDataViewType dataArrayCount:(NSInteger)dataArrayCount;

- (void)lgf_PageReloadData:(NSInteger)count limitCount:(NSInteger)limit dataArrayCount:(NSInteger)dataArrayCount;

- (void)lgf_PageReloadData:(NSInteger)count noDataViewType:(NSInteger)noDataViewType limitCount:(NSInteger)limit dataArrayCount:(NSInteger)dataArrayCount;

- (void)lgf_PageSetGifHeader:(LGFMJRefreshGifHeader *)gifHeader gifName:(NSString *)gifName gifSize:(CGSize)gifSize;
@end
