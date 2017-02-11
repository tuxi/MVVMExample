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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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

#pragma mark - public
- (void)reloadBlock:(void (^)())block {
    self.loadingView.reloadBlock = block;
}

- (void)setup {
    XYLoadingView *loadingView = [XYLoadingView new];
    loadingView.frame = self.bounds;
    [self addSubview:(self.loadingView = loadingView)];
    
}

- (void)setLoadingView:(XYLoadingView *)loadingView {
    objc_setAssociatedObject(self, loadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XYLoadingView *)loadingView {
    return (XYLoadingView *)objc_getAssociatedObject(self, loadingViewKey);
}

@end
