//
//  UIScrollView+XYLoading.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "UIScrollView+XYLoading.h"
#import <objc/runtime.h>

static char *const loadingViewKey = "loadingViewKey";

@implementation UIScrollView (XYLoading)

#pragma mark - public

/// 正在加载中
- (void)loading {
    [self setup];
    [self.loadingView loading];
}
/// 加载完成
- (void)loadFinished {
    [self.loadingView loadFinished];
}
/// 加载失败
- (void)loadFailure {
    [self.loadingView loadFailure];
}

- (void)reloadBlock:(void (^)())block {
    self.loadingView.reloadBlock = block;
}

#pragma mark - private
- (void)setup {
    if (self.loadingView) {
        return;
    }

    XYLoadingView *loadingView = [XYLoadingView new];
    loadingView.frame = self.bounds;
    [self addSubview:(self.loadingView = loadingView)];
    loadingView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    loadingView.hidden = YES;
}

#pragma mark - set\get
- (void)setLoadingView:(XYLoadingView *)loadingView {
    objc_setAssociatedObject(self, loadingViewKey, loadingView, OBJC_ASSOCIATION_ASSIGN);
}

- (XYLoadingView *)loadingView {
    return (XYLoadingView *)objc_getAssociatedObject(self, loadingViewKey);
}



@end
