//
//  XYViewProtocol.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYViewProtocol <NSObject>

/**
 * @explain 将view的事件通过代理传递出去
 *
 * @param   view  view自己
 * @param   events  所触发事件的一些描述信息
 */
- (void)xy_view:(__kindof UIView *)view events:(NSDictionary *)events;

@end
