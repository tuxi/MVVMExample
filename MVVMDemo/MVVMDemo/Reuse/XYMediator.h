//
//  XYMediator.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//  传递者

#import <Foundation/Foundation.h>
#import "XYViewManagerProtocol.h"
#import "XYViewModelProtocol.h"

@interface XYMediator : NSObject

@property (nonatomic, strong) NSObject<XYViewModelProtocol> *viewModel;
@property (nonatomic, strong) NSObject<XYViewManagerProtocol> *viewManager;

/// 初始化方法
- (instancetype)initWithViewModel:(id<XYViewModelProtocol>)viewModel viewManager:(id<XYViewManagerProtocol>)viewManager;
+ (instancetype)mediatorWithViewModel:(id<XYViewModelProtocol>)viewModel viewManager:(id<XYViewManagerProtocol>)viewManager;

/// 将infos通知给viewModel
- (void)notityViewModelWithInfos:(NSDictionary *)infos;
/// 将infos通知给viewManager;
- (void)notityViewManagerWithInfos:(NSDictionary *)infos;
@end
