//
//  MessageViewModel.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/18.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "MessageViewModel.h"
#import "MessageRequestItem.h"
#import "UploadRequestItem.h"

@interface MessageViewModel ()

@property (nonatomic, strong) MessageRequestItem *requestItem;
@property (nonatomic, strong) UploadRequestItem *upRequestItem;

@end

@implementation MessageViewModel

- (MessageRequestItem *)requestItem {
    if (_requestItem ==  nil) {
        _requestItem = [MessageRequestItem new];
    }
    return _requestItem;
}

- (UploadRequestItem *)upRequestItem {
    if (_upRequestItem == nil) {
        _upRequestItem = [UploadRequestItem new];
    }
    return _upRequestItem;
}

/*
发布图片文字的规则：
若有图片或视频，先调用save接口保存上传信息，保存成功后服务器会返回datas字段 其值为tid， 再调用updateTrendFile接口上传视频或图片，上传需要的参数有tid，发布成功
若无图片或视频，直接调用save接口即可
注意：当有图片和视频时，存在依赖关系的，只有先调用save完成后，才能调用uodateTrendFile接口上传视频或图片
 */

// save接口
- (NSURLSessionTask *)xy_viewModelWithProgress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    NSURLSessionTask *task = [[XYNetworkRequest sharedInstance] sendRequest:self.requestItem  progress:nil success:^(id responseObject) {
       
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

// updateTrendFile接口
- (NSURLSessionTask *)xy_viewModelWithConfigRequest:(void (^)(id<XYRequestProtocol>))requestBlock progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    if (requestBlock) {
        requestBlock(self.upRequestItem);
    }
    
    NSURLSessionTask *task = [[XYNetworkRequest sharedInstance] sendRequest:self.upRequestItem  progress:^(NSProgress * progress1) {
        if (progress) {
            progress(progress1);
        }
    } success:^(id responseObject) {
        
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


@end
