//
//  LGFMJRefreshBackStateFooter.m
//  LGFMJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "LGFMJRefreshBackStateFooter.h"

@interface LGFMJRefreshBackStateFooter()
{
    /** 显示刷新状态的label */
    __unsafe_unretained UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation LGFMJRefreshBackStateFooter
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel lgfmj_label]];
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(LGFMJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (NSString *)titleForState:(LGFMJRefreshState)state {
  return self.stateTitles[@(state)];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = LGFMJRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:[NSBundle lgfmj_localizedStringForKey:LGFMJRefreshBackFooterIdleText] forState:LGFMJRefreshStateIdle];
    [self setTitle:[NSBundle lgfmj_localizedStringForKey:LGFMJRefreshBackFooterPullingText] forState:LGFMJRefreshStatePulling];
    [self setTitle:[NSBundle lgfmj_localizedStringForKey:LGFMJRefreshBackFooterRefreshingText] forState:LGFMJRefreshStateRefreshing];
    [self setTitle:[NSBundle lgfmj_localizedStringForKey:LGFMJRefreshBackFooterNoMoreDataText] forState:LGFMJRefreshStateNoMoreData];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.constraints.count) return;
    
    // 状态标签
    self.stateLabel.frame = self.bounds;
}

- (void)setState:(LGFMJRefreshState)state
{
    LGFMJRefreshCheckState
    
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
}
@end
