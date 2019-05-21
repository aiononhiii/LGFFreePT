//  代码地址: https://github.com/CoderMJLee/LGFMJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+LGFMJRefresh.m
//  LGFMJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIScrollView+LGFMJRefresh.h"
#import "LGFMJRefreshHeader.h"
#import "LGFMJRefreshFooter.h"
#import <objc/runtime.h>

@implementation NSObject (LGFMJRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (LGFMJRefresh)

#pragma mark - header
static const char LGFMJRefreshHeaderKey = '\0';
- (void)setLgfmj_header:(LGFMJRefreshHeader *)lgfmj_header
{
    if (lgfmj_header != self.lgfmj_header) {
        // 删除旧的，添加新的
        [self.lgfmj_header removeFromSuperview];
        [self insertSubview:lgfmj_header atIndex:0];
        
        // 存储新的
        objc_setAssociatedObject(self, &LGFMJRefreshHeaderKey,
                                 lgfmj_header, OBJC_ASSOCIATION_RETAIN);
    }
}

- (LGFMJRefreshHeader *)lgfmj_header
{
    return objc_getAssociatedObject(self, &LGFMJRefreshHeaderKey);
}

#pragma mark - footer
static const char LGFMJRefreshFooterKey = '\0';
- (void)setLgfmj_footer:(LGFMJRefreshFooter *)lgfmj_footer
{
    if (lgfmj_footer != self.lgfmj_footer) {
        // 删除旧的，添加新的
        [self.lgfmj_footer removeFromSuperview];
        [self insertSubview:lgfmj_footer atIndex:0];
        
        // 存储新的
        objc_setAssociatedObject(self, &LGFMJRefreshFooterKey,
                                 lgfmj_footer, OBJC_ASSOCIATION_RETAIN);
    }
}

- (LGFMJRefreshFooter *)lgfmj_footer
{
    return objc_getAssociatedObject(self, &LGFMJRefreshFooterKey);
}

#pragma mark - 过期
- (void)setFooter:(LGFMJRefreshFooter *)footer
{
    self.lgfmj_footer = footer;
}

- (LGFMJRefreshFooter *)footer
{
    return self.lgfmj_footer;
}

- (void)setHeader:(LGFMJRefreshHeader *)header
{
    self.lgfmj_header = header;
}

- (LGFMJRefreshHeader *)header
{
    return self.lgfmj_header;
}

#pragma mark - other
- (NSInteger)lgfmj_totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char LGFMJRefreshReloadDataBlockKey = '\0';
- (void)setLgfmj_reloadDataBlock:(void (^)(NSInteger))lgfmj_reloadDataBlock
{
    [self willChangeValueForKey:@"lgfmj_reloadDataBlock"]; // KVO
    objc_setAssociatedObject(self, &LGFMJRefreshReloadDataBlockKey, lgfmj_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"lgfmj_reloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))lgfmj_reloadDataBlock
{
    return objc_getAssociatedObject(self, &LGFMJRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock
{
    !self.lgfmj_reloadDataBlock ? : self.lgfmj_reloadDataBlock(self.lgfmj_totalDataCount);
}
@end

@implementation UITableView (LGFMJRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(lgfmj_reloadData)];
}

- (void)lgfmj_reloadData
{
    [self lgfmj_reloadData];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (LGFMJRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(lgfmj_reloadData)];
}

- (void)lgfmj_reloadData
{
    [self lgfmj_reloadData];
    
    [self executeReloadDataBlock];
}
@end
