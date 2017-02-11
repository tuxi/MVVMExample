//
//  XYViewManagerProtocol.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYViewProtocol.h"
#import "XYViewManagerProtocol.h"


typedef void (^ViewEventsBlock)( );

/**
 *  将自己的信息返回给ViewModel的block
 */
typedef void (^ViewModelInfosBlock)( );

/**
 *  将自己的信息返回给ViewManger的block
 */
typedef void (^ViewMangerInfosBlock)( );

@protocol XYViewManagerProtocol <NSObject>

@optional

/// 通知
- (void)xy_notify;

/**
 * @explain 设置控制器的子视图的管理者为self
 *
 * @param   superView  一般指superView所在的控制器的根view
 */
- (void)xy_viewManagerWithSuperView:(UIView *)superView;

/**
 * @explain 设置subView的管理者为self
 *
 * @param   subView 管理的subview
 */
- (void)xy_viewManagerWithSubView:(UIView *)subView;

/**
 * @explain 设置添加subView的事件
 *
 * @param   subView  管理的subView
 * @param   info  附带信息 用于区分回调
 */
- (void)xy_viewManagerWithHandleOfSubView:(UIView *)subView info:(NSString *)info;

/**
 * @explain 返回viewManager所管理的视图
 * @return  view
 */
- (__kindof UIView *)xy_viewManagerOfSubView;

/**
 * @explain 得到其他viewManager所管理的subview 用户自己内部
 *
 * @param   viewInfos  其他的subViews
 */
- (void)xy_viewManagerWithOtherSubviews:(NSDictionary *)viewInfos;

/**
 * @explain 需要重新布局subView时，更新subview的frame或约束
 *
 * @param   updateBlock  布局更新完成后的回调
 */
- (void)xy_viewManagerWithLayoutSubviews:(void (^)())updateBlock;

/**
 * @explain 使子视图更新到最新的布局约束或frame
 */
- (void)xy_viewManagerWithUpdateLayoutSubviews;

/**
 * @explain 将模型数据传递给viewManager
 */
- (void)xy_viewManagerWithModel:(NSDictionary *(^)())block;

/**
 * @explain 处理viewBlock的事件
 */
- (void(^)())xy_viewManagerWithViewEventBlockOfInfos:(NSDictionary *)infos;

/**
 *  处理ViewModelInfosBlock
 */
- (ViewModelInfosBlock)xy_viewMangerWithViewModelBlockOfInfos:(NSDictionary *)infos;

/**
 *  处理ViewMangerInfosBlock
 */
- (ViewMangerInfosBlock)xy_viewMangerWithOtherViewMangerBlockOfInfos:(NSDictionary *)infos;

/**
 *  将viewManger中的信息通过代理传递给ViewModel
 *
 *  @param viewManger   viewManger自己
 *  @param infos 描述信息
 */
- (void)xy_viewManger:(id)viewManger withInfos:(NSDictionary *)infos;

@end
