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
/// 显示序列帧的视图
@property (nonatomic, weak) UIImageView *flameAnimationView;

@end

@implementation XYLoadingView

@synthesize loadingText = _loadingText;

#pragma mark - public

- (void)loading {
    self.hidden = NO;
    self.state = XYLoadingStateLoading;
    self.reloadBtn.hidden = YES;
    if (self.loadingImgs.count) {
        [self.flameAnimationView startAnimating];
        self.loadingText = @"";
        return;
    }
    self.loadingText = @"正在加载";
    [self.indicatorView startAnimating];
}

- (void)loadFinished {
    self.hidden = YES;
    self.state = XYLoadingStateFinished;
    self.reloadBtn.hidden = YES;
    [self updateFrame];
    if (self.loadingImgs.count) {
        [self.flameAnimationView stopAnimating];
        return;
    }
    [self.indicatorView stopAnimating];
    
}

- (void)loadFailure {
    self.loadingText = @"加载失败";
    self.reloadBtn.hidden = NO;
    self.hidden = NO;
    [self updateFrame];
    self.state = XYLoadingStateFailure;
    if (self.loadingImgs.count) {
        [self.flameAnimationView stopAnimating];
        return;
    }
    [self.indicatorView stopAnimating];
    
}

- (void)setLoadingImgs:(NSArray<UIImage *> *)loadingImgs {
    _loadingImgs = loadingImgs;
    if (self.indicatorView) {
        [self.indicatorView removeFromSuperview];
        self.indicatorView = nil;
    }
    if (loadingImgs.count) {
        self.flameAnimationView.animationImages = loadingImgs;
    } else {
        self.flameAnimationView.animationImages = @[[UIImage imageNamed:@"Warning_64px"]];
    }
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


- (UIImageView *)flameAnimationView {
    if (_flameAnimationView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        // all frames will execute in 1.75 seconds
        imageView.animationDuration = 1.0;
        // repeat the annimation forever
        imageView.animationRepeatCount = 0;
        _flameAnimationView = imageView;
    }
    return _flameAnimationView;
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
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    if (self.loadingText.length) {
        size = [self.loadingText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _label.font} context:nil].size;
    }
    CGRect frame = _label.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    frame.origin.x = _indicatorView.hidden ? (selfW - size.width) * 0.5 :(selfW - size.width - indicatorViewW) * 0.5;
    frame.origin.y = (selfH - size.height) * 0.5;
    _label.frame = frame;
    
    _indicatorView.frame = CGRectMake(CGRectGetMaxX(_label.frame), 0, indicatorViewW, indicatorViewW);
    CGPoint indicatorViewCenter = _indicatorView.center;
    indicatorViewCenter.y = _label.center.y;
    self.indicatorView.center = indicatorViewCenter;
    
    _reloadBtn.frame = CGRectMake((selfW - reloadBtnW) * 0.5, CGRectGetMaxY(self.label.frame)+10, reloadBtnW, reloadBtnH);
    
    CGFloat flameAnimationWH = 60;
    CGFloat flameAnimationX = (selfW - flameAnimationWH) * 0.5;
    CGFloat flameAnimationY = (selfH - flameAnimationWH) * 0.5;
    _flameAnimationView.frame = CGRectMake(flameAnimationX, flameAnimationY, flameAnimationWH, flameAnimationWH);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}



@end
