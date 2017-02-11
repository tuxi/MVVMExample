//
//  NSObject+XYProperties.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYViewModelProtocol.h"
#import "XYViewManagerProtocol.h"
#import "XYViewProtocol.h"
#import "XYMediator.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  ViewModelBlock
 */
typedef _Nonnull id (^ViewModelBlock)( );
/**
 *  ViewMangerInfosBlock
 */
typedef void (^ViewMangerInfosBlock)( );
/**
 *  ViewModelInfosBlock
 */
typedef void (^ViewModelInfosBlock)( );




@interface NSObject (XYProperties)

/**
 *  viewModelBlock
 */
@property (nonatomic, copy, nonnull) ViewModelBlock viewModelBlock;

/**
 *  获取一个对象的所有属性
 */
- (nullable NSDictionary *)xy_allProperties;

/**
 *  viewMangerDelegate
 */
@property (nullable, nonatomic, weak) id<XYViewManagerProtocol> viewMangerDelegate;

/**
 *  ViewMangerInfosBlock
 */
@property (nonatomic, copy) ViewMangerInfosBlock viewMangerInfosBlock;

/**
 *  viewModelDelegate
 */
@property (nullable, nonatomic, weak) id<XYViewModelProtocol> viewModelDelegate;

/**
 *  ViewModelInfosBlock
 */
@property (nonatomic, copy) ViewModelInfosBlock viewModelInfosBlock;

/**
 *  mediator
 */
@property (nonatomic, strong) XYMediator *xy_mediator;

/**
 *  xy_viewMangerInfos
 */
@property (nonatomic, copy) NSDictionary *xy_viewMangerInfos;

/**
 *  xy_viewModelInfos
 */
@property (nonatomic, copy) NSDictionary *xy_viewModelInfos;



@end

NS_ASSUME_NONNULL_END
