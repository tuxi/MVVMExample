//
//  XYLoadingView.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYLoadingView.h"

static CGFloat const indicatorViewW = 30;

@interface XYLoadingView ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;
@property (nonatomic, copy) NSString *loadingText;

@end

@implementation XYLoadingView

@synthesize loadingText = _loadingText;

#pragma mark - public
- (void)loading {
    self.hidden = NO;
    self.loadingText = @"加载中...";
    [self.indicatorView startAnimating];
}

- (void)loadFinished {
    self.hidden = YES;
    [self.indicatorView stopAnimating];
    [self updateFrame];
}

- (void)loadFailure {
    self.loadingText = @"加载失败...";
    self.hidden = NO;
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
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}



@end
