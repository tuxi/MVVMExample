//
//  FirstViewManager.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "FirstViewManager.h"
#import "Example1Vc.h"
#import "NSObject+XYProperties.h"

@implementation FirstViewManager


- (void)xy_notify {
    
}

#pragma mark - XYViewModelProtocol
- (void)xy_viewModel:(id)viewModel withInfos:(NSDictionary *)infos {
    NSLog(@"%@", infos);
}

@end
