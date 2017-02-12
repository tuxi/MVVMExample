//
//  FirstViewManager.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "FirstViewManager.h"
#import "Example1Vc.h"
#import "UIView+Events.h"
#import "XYMediator.h"
#import "NSObject+XYProperties.h"
#import "SUIUtils.h"

@implementation FirstViewManager

#pragma mark - XYViewProtocol的代理方法
/// 传递view的事件
- (void)xy_view:(__kindof UIView *)view events:(NSDictionary *)events {
    NSLog(@"events:--%@", events);
    if ([events.allKeys containsObject:@"jump"]) {
        
        UIViewController *vc = [UIViewController sui_viewControllerWithStoryboard:nil identifier:events[@"jump"]];
        if (vc == nil) {
            vc = [[UIViewController alloc] init];
        }
        [view.sui_currentVC.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - XYViewManagerProtocol
- (void(^)())xy_viewManagerWithViewEventBlockOfInfos:(NSDictionary *)infos {
    
    return ^(NSString *info){
        if (self.viewMangerInfosBlock) {
            self.viewMangerInfosBlock();
        }
        
        if (self.viewMangerDelegate && [self.viewMangerDelegate respondsToSelector:@selector(xy_viewManger:withInfos:)]) {
            [self.viewMangerDelegate xy_viewManger:self withInfos:@{@"infos": @"您好viewModel，我是viewManage"}];
        }
        
    };
}

- (void)xy_notify {
    [self.xy_mediator notityViewModelWithInfos:self.xy_viewMangerInfos];
}

#pragma mark - XYViewModelProtocol
- (void)xy_viewModel:(id)viewModel withInfos:(NSDictionary *)infos {
    NSLog(@"%@", infos);
}

@end
