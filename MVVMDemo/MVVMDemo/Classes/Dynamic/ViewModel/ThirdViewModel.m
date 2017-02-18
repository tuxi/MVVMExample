//
//  ThirdViewModel.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "ThirdViewModel.h"
#import "XYNetworkRequest.h"
#import "ThirdRequestItem.h"
#import "DynamicItem.h"

@interface ThirdViewModel ()

/// 网络请求对象
@property (nonatomic, strong) ThirdRequestItem *item;

@end

@implementation ThirdViewModel

- (ThirdRequestItem *)item {
    if (_item == nil) {
        _item = [ThirdRequestItem new];
    }
    return _item;
}

- (NSURLSessionTask *)xy_viewModelWithConfigRequest:(void (^)(id<XYRequestProtocol>))requestItem
                                           progress:(progressBlock)progress
                                            success:(successBlock)success
                                            failure:(failureBlock)failure {
    
    __weak typeof(self) weakSelf = self;
    
    /// 将网络请求对象 通过requestItem回调给调用者对象使用，调用者根据请求修改此请求对象对应的参数，即可做到动态参数 请求服务器数据
    if (requestItem) {
        requestItem(weakSelf.item);
    }
    return [[XYNetworkRequest sharedInstance] sendRequest:weakSelf.item                                                      progress:nil
                                                  success:^(id responseObject) {
                                                           
                                                           NSMutableArray<DynamicItem *> *arrayList = [NSMutableArray array];
                                                           
                                                           /// 将服务器请求的数据转换为模型，返回给外界使用
                                                           if (responseObject[@"data"]) {
                                                               if ([responseObject[@"data"][@"code"] isEqualToString:@"0"]) {
                                                                   /// code为0，说明请求数据成功
                                                                   for (id obj in responseObject[@"data"][@"list"]) {
                                                                       if ([obj isKindOfClass:[NSDictionary class]]) {
                                                                           [arrayList addObject:[DynamicItem itemWithDict:obj]];
                                                                       }
                                                                   }
                                                               }
                                                           }
                                                           
                                                           if (success) {
                                                               success(arrayList);
                                                           }
                                                       }
                                                       failure:^(NSError *error) {
                                                           if (failure) {
                                                               failure(error);
                                                           }
                                                       }];
}


@end
