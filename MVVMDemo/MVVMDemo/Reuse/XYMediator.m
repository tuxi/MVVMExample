//
//  XYMediator.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYMediator.h"
#import "NSObject+XYProperties.h"

@implementation XYMediator

- (instancetype)initWithViewModel:(id<XYViewModelProtocol>)viewModel viewManager:(id<XYViewManagerProtocol>)viewManager {
    if (self = [super init]) {
        self.viewManager = viewManager;
        self.viewModel = viewModel;
    }
    return self;
}

+ (instancetype)mediatorWithViewModel:(id<XYViewModelProtocol>)viewModel viewManager:(id<XYViewManagerProtocol>)viewManager {
    return [[self alloc] initWithViewModel:viewModel viewManager:viewManager];
}

- (void)notityViewModelWithInfos:(NSDictionary *)infos {
    self.viewModel.xy_viewModelInfos = infos;
}

- (void)notityViewManagerWithInfos:(NSDictionary *)infos {
    self.viewManager.xy_viewMangerInfos = infos;
}

@end
