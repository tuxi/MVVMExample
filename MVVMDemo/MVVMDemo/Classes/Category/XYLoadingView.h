//
//  XYLoadingView.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYLoadingView : UIView

@property (nonatomic, weak, readonly) UILabel *label;
@property (nonatomic, weak, readonly) UIActivityIndicatorView *indicatorView;

/// 正在加载中
- (void)loading;
/// 加载完成
- (void)loadFinished;
/// 加载失败
- (void)loadFailure;

@end
