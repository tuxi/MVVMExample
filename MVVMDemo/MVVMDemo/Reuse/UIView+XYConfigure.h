//
//  UIView+XYConfigure.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYViewModelProtocol.h"

@interface UIView (XYConfigure)

/// 根据model配置view, 设置view的内容
- (void)xy_configViewWithModel:(id)model;

/// 根据viewModel配置view，设置view的内容
- (void)xy_configViewWithViewModel:(id<XYViewModelProtocol>)vm;

@end
