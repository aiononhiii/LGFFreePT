//
//  LGFCountDownButton.m
//  LGFOCTool
//
//  Created by apple on 2017/5/7.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "LGFCountDownButton.h"
#import "LGFOCTool.h"

@interface LGFCountDownButton ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;
@end

@implementation LGFCountDownButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.lgf_Label.hidden = YES;
    self.lgf_Label.frame = CGRectMake(-1, -1, self.lgf_width - 2, self.lgf_height - 2);
    [self addSubview:self.lgf_Label];
    self.lgf_SelectColor = [UIColor whiteColor];
    self.lgf_SelectTextColor = lgf_HexColor(@"333333");
    self.lgf_Label.textColor = self.lgf_SelectTextColor;
    self.lgf_Label.backgroundColor = self.lgf_SelectColor;
    self.lgf_Label.clipsToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lgf_Label.frame = self.bounds;
    self.lgf_Label.layer.cornerRadius = self.layer.cornerRadius;
}

- (UILabel *)lgf_Label {
    if (!_lgf_Label) {
        _lgf_Label = [[UILabel alloc] init];
        _lgf_Label.font = self.titleLabel.font;
        _lgf_Label.textAlignment = NSTextAlignmentCenter;
        _lgf_Label.layer.borderColor = lgf_HexColor(@"F0F0F0").CGColor;
        _lgf_Label.layer.borderWidth = 2.0;
    }
    return _lgf_Label;
}

- (void)lgf_TimeFailBeginFrom:(NSInteger)timeCount {
    self.count = timeCount;
    [self setUI];
    // 加1个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

- (void)timerFired {
    if (self.count != 1) {
        self.count -= 1;
        [self setUI];
    } else {
        self.enabled = YES;
        self.lgf_Label.hidden = YES;
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)setUI {
    self.enabled = NO;
    self.lgf_Label.hidden = NO;
    self.lgf_Label.text = [NSString stringWithFormat:@"%lds", (long)self.count];
}

@end
