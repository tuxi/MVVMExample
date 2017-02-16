//
//  UIView+Events.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYViewProtocol.h"
#import "XYViewManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ViewEventsBlock)();

@interface UIView (Events)

/// 传递事件的代理对象
@property (nullable, nonatomic, weak) id<XYViewProtocol> viewDelete;

/// 通过block传递事件
@property (nonatomic, copy) ViewEventsBlock viewEventsBlock;

/// 将view中的事件，交由viewManager处理
- (void)xy_viewWithViewManager:(id<XYViewProtocol>)viewManager;

@end

NS_ASSUME_NONNULL_END
