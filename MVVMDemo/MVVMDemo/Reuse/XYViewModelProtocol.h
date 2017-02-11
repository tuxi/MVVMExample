//
//  XYViewModelProtocol.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  请求成功block
 */
typedef void (^successBlock)(id responseObject);
/**
 *  请求失败block
 */
typedef void (^failureBlock) (NSError *error);
/**
 *  请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);
/**
 *  监听进度响应block
 */
typedef void (^progressBlock)(NSProgress * progress);
/**
 *  将自己的信息返回给ViewManger的block
 */
typedef void (^ViewMangerInfosBlock)();
/**
 *  将自己的信息返回给ViewModel的block
 */
typedef void (^ViewModelInfosBlock)();




@protocol XYViewModelProtocol <NSObject>

- (void)xy_notice;

/**
 *  返回指定viewModel的所引用的控制器
 */
- (void)xy_viewModelWithViewController:(UIViewController *)viewController;

/**
 *  加载数据
 */
- (NSURLSessionTask *)xy_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure;

/**
 *  传递模型给view
 */
- (void)xy_viewModelWithModelBlcok:(void (^)(id model))modelBlock;

/**
 *  处理ViewMangerInfosBlock
 */
- (ViewMangerInfosBlock)xy_viewModelWithViewMangerBlockOfInfos:(NSDictionary *)infos;

/**
 *  处理ViewModelInfosBlock
 */
- (ViewModelInfosBlock)xy_viewModelWithOtherViewModelBlockOfInfos:(NSDictionary *)infos;

/**
 *  将viewModel中的信息通过代理传递给ViewManger
 *
 *  @param viewModel   viewModel自己
 *  @param infos 描述信息
 */
- (void)xy_viewModel:(id)viewModel withInfos:(NSDictionary *)infos;

@end
