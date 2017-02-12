//
//  XYLoadingView.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYLoadingView.h"

static CGFloat const indicatorViewW = 30;
static CGFloat const reloadBtnW = 160;
static CGFloat const reloadBtnH = 30;

@interface XYLoadingView ()

/// 显示加载状态label
@property (nonatomic, weak) UILabel *label;
/// 菊花
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;
/// 重新加载按钮  -- 当加载失败时才会显示  -- 用户可同block设置回调
@property (nonatomic, weak) UIButton *reloadBtn;


@end

@implementation XYLoadingView

@synthesize loadingText = _loadingText;

#pragma mark - public

- (void)loading {
    self.hidden = NO;
    self.state = XYLoadingStateLoading;
    self.reloadBtn.hidden = YES;
    self.loadingText = @"正在加载";
    [self.indicatorView startAnimating];
}

- (void)loadFinished {
    self.hidden = YES;
    self.state = XYLoadingStateFinished;
    self.reloadBtn.hidden = YES;
    [self.indicatorView stopAnimating];
    [self updateFrame];
}

- (void)loadFailure {
    self.loadingText = @"加载失败";
    self.reloadBtn.hidden = NO;
    self.hidden = NO;
    self.state = XYLoadingStateFailure;
    [self.indicatorView stopAnimating];
    [self updateFrame];

}


#pragma mark - lazy
- (UILabel *)label {
    if (_label == nil) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        _label = label;
        [self addSubview:label];
        
    }
    return _label;
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:indicatorView];
        _indicatorView = indicatorView;
        
    }
    return _indicatorView;
}

- (UIButton *)reloadBtn {
    if (_reloadBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btn.backgroundColor = [UIColor blackColor];
        btn.layer.cornerRadius = 8;
        [btn.layer setMasksToBounds:YES];
        btn.hidden = YES;
        [btn addTarget:self action:@selector(reloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _reloadBtn = btn;
    }
    return _reloadBtn;
}


#pragma mark - Events
- (void)reloadBtnClick:(UIButton *)btn {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

- (void)setLoadingText:(NSString *)loadingText {
    _loadingText = loadingText;
    self.label.text = loadingText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateFrame];
}

#pragma mark - private
- (void)updateFrame {
    
    CGSize size = CGSizeZero;
    if (self.loadingText.length) {
        size = [self.loadingText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil].size;
    }
    CGRect frame = self.label.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    frame.origin.x = self.indicatorView.hidden ? (self.frame.size.width - size.width) * 0.5 :(self.frame.size.width - size.width - indicatorViewW) * 0.5;
    frame.origin.y = (self.frame.size.height - size.height) * 0.5;
    self.label.frame = frame;
    
    self.indicatorView.frame = CGRectMake(CGRectGetMaxX(self.label.frame), 0, indicatorViewW, indicatorViewW);
    CGPoint indicatorViewCenter = self.indicatorView.center;
    indicatorViewCenter.y = self.label.center.y;
    self.indicatorView.center = indicatorViewCenter;
    
    self.reloadBtn.frame = CGRectMake((self.frame.size.width - reloadBtnW) * 0.5, CGRectGetMaxY(self.label.frame)+10, reloadBtnW, reloadBtnH);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}



@end
