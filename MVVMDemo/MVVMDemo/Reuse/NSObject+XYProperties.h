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

typedef _Nonnull id (^ViewModelBlock)();

typedef void (^ViewMangerInfosBlock)();

typedef void (^ViewModelInfosBlock)();

@interface NSObject (XYProperties)


@property (nonatomic, copy, nonnull) ViewModelBlock viewModelBlock;

/// 获取一个对象的所有属性
- (nullable NSDictionary *)xy_allProperties;


@property (nullable, nonatomic, weak) id<XYViewManagerProtocol> viewMangerDelegate;


@property (nonatomic, copy) ViewMangerInfosBlock viewMangerInfosBlock;


@property (nullable, nonatomic, weak) id<XYViewModelProtocol> viewModelDelegate;


@property (nonatomic, copy) ViewModelInfosBlock viewModelInfosBlock;

/// 传递者
@property (nonatomic, strong) XYMediator *xy_mediator;

/// 传递的信息
@property (nonatomic, strong) NSDictionary *xy_viewMangerInfos;

/// 传递的信息
@property (nonatomic, strong) NSDictionary *xy_viewModelInfos;


@end

NS_ASSUME_NONNULL_END
