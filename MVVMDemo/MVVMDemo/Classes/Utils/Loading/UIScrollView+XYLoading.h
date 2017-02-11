//
//  UIScrollView+XYLoading.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYLoadingView.h"

@interface UIScrollView (XYLoading)

@property (nonatomic) XYLoadingView *loadingView;

/// 当数据加载失败时，可调用此方法在block中做处理，点击重新加载时，会回调此block
- (void)reloadBlock:(void(^)())block;

@end
