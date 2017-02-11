//
//  FirstViewModel.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "FirstViewModel.h"
#import "NSObject+XYProperties.h"
#import "XYNetworkRequest.h"
#import "FirstRequest.h"
#import "MJExtension.h"
#import "FirstModel.h"

@implementation FirstViewModel

#pragma mark - XYViewManagerProtocol
- (void)xy_viewManger:(id)viewManger withInfos:(NSDictionary *)infos {
    NSLog(@"%@", infos);
}

#pragma mark - XYViewModelProtocol
- (ViewMangerInfosBlock)xy_viewModelWithViewMangerBlockOfInfos:(NSDictionary *)infos {
    return ^{
        NSLog(@"%@", infos);
    };
}

/// 加载网络请求
- (NSURLSessionTask *)xy_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    /// 发送网络请求
    return [[XYNetworkRequest sharedInstance] sendRequestBlock:^id(NSObject *request) {
        return [FirstRequest new];
    } progress:nil success:^(id responseObject) {
        NSArray *modelList = [FirstModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
        if (success) {
            success(modelList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/// 配置加工模型数据，并通过block传递给view 将模型传递给view
- (void)xy_viewModelWithModelBlcok:(void (^)(id))modelBlock {
    
    /// 获取数据
    [self xy_viewModelWithProgress:nil success:^(id responseObject) {
        
        if (modelBlock) {
            if (self.viewModelDelegate && [self.viewModelDelegate respondsToSelector:@selector(xy_viewModel:withInfos:)]) {
                [self.viewModelDelegate xy_viewModel:self withInfos:@{@"info": @"你好，我是viewModel，数据加载成功啦"}];
            }
            
            modelBlock([self getRandomData:responseObject]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (id)getRandomData:(NSArray *)arrayList {
    u_int32_t index = arc4random_uniform((u_int32_t)10);
    return arrayList[index];
}

- (void)xy_notify {
    [self.xy_mediator notityViewManagerWithInfos:self.xy_viewModelInfos];
}
@end
