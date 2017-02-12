//
//  UIView+XYLoading.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "UIView+XYLoading.h"
#import <objc/runtime.h>

static char *const loadingViewKey = "loadingViewKey";

@implementation UIView (XYLoading)

#pragma mark - public

/// 正在加载中
- (void)loading {
    [self setup];
    if (self.loadingView == nil) {
        [self setup];
    }
    [self.loadingView loading];
}
/// 加载完成
- (void)loadFinished {
    if (self.loadingView == nil) {
        [self setup];
    }
    [self.loadingView loadFinished];
}
/// 加载失败
- (void)loadFailure {
    if (self.loadingView == nil) {
        [self setup];
    }
    [self.loadingView loadFailure];
}

- (void)reloadBlock:(void (^)())block {
    /// 为了防止外界先调用此方法，但self.loadingView还未创建时，会导致block赋值失败
    if (self.loadingView == nil) {
        [self setup];
    }
    self.loadingView.reloadBlock = block;
}

#pragma mark - private
- (void)setup {
    if (self.loadingView == nil) {
        XYLoadingView *loadingView = [XYLoadingView new];
        loadingView.frame = self.bounds;
        [self addSubview:(self.loadingView = loadingView)];
        loadingView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        loadingView.hidden = YES;
    }
}

#pragma mark - set\get
- (void)setLoadingView:(XYLoadingView *)loadingView {
    objc_setAssociatedObject(self, loadingViewKey, loadingView, OBJC_ASSOCIATION_ASSIGN);
}

- (XYLoadingView *)loadingView {
    return (XYLoadingView *)objc_getAssociatedObject(self, loadingViewKey);
}



@end
