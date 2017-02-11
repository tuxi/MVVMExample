//
//  SecondViewModel.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "SecondViewModel.h"
#import "XYNetworkRequest.h"
#import "SecondRequetItem.h"
#import "MJExtension.h"
#import "SecondModel.h"

@implementation SecondViewModel

#pragma mark - XYViewModelProtocol
- (NSURLSessionTask *)xy_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    /// 从网络请求数据
    return [[XYNetworkRequest sharedInstance] sendRequestBlock:^id(NSObject *request) {
        return [SecondRequetItem new];
    } progress:nil success:^(id responseObject) {
        /// 转换为模型 并通过block回调
        NSArray *dataList = [SecondModel mj_objectArrayWithKeyValuesArray:responseObject[@"books"]];
        if (success) {
            success(dataList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            
        }
    }];
}

@end
