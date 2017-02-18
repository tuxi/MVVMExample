//
//  XYHomePageViewModel.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/18.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYHomePageViewModel.h"
#import "XYNetworkRequest.h"
#import "HomePageRequestItem.h"

@interface XYHomePageViewModel ()

@property (nonatomic, strong) HomePageRequestItem *requestItem;

@end

@implementation XYHomePageViewModel

- (HomePageRequestItem *)requestItem {
    if (_requestItem == nil) {
        _requestItem = [HomePageRequestItem new];
    }
    return _requestItem;
}


- (NSURLSessionTask *)xy_viewModelWithConfigRequest:(void (^)(id<XYRequestProtocol> request))requestBlock
                                           progress:(progressBlock)progress
                                            success:(successBlock)success
                                            failure:(failureBlock)failure {
    
    if (requestBlock) {
        requestBlock(self.requestItem);
    }
    
    NSURLSessionTask *task = [[XYNetworkRequest sharedInstance] sendRequest:self.requestItem
                                                                   progress:nil success:^(id responseObject) {
                                                                       if (success) {
                                                                           success(responseObject);
                                                                       }
                                                                   } failure:^(NSError *error) {
                                                                       if (failure) {
                                                                           failure(error);
                                                                       }
                                                                   }];
    return task;
    
}



//- (NSURLSessionTask *)xy_viewModelWithProgress:(progressBlock)progress
//                                       success:(successBlock)success
//                                       failure:(failureBlock)failure {
//    
//    NSLog(@"%@--%@", success, failure);
//    NSURLSessionTask *task = [[XYNetworkRequest sharedInstance] sendRequest:[HomePageRequestItem new]
//                                          progress:nil success:^(id responseObject) {
//                                              if (success) {
//                                                  success(responseObject);
//                                              }
//                                          } failure:^(NSError *error) {
//                                              if (failure) {
//                                                  failure(error);
//                                              }
//                                          }];
//    return task;
//}



@end
