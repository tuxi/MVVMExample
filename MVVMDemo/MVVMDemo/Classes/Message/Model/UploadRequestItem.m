//
//  UploadRequestItem.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/18.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "UploadRequestItem.h"

@implementation UploadRequestItem


- (void)xy_requestConfigures {
    
    self.xy_url = @"http://me.api.kfit.com.cn/me-api/rest/api/trend/updateTrendFile";
    self.xy_method = RequestMethodUPLOAD;
    NSString *token = @"965b58eb-7bac-491d-887e-49ef93b43bf9";
    self.xy_headers = @{@"token": token, @"uid": @"21179"};
}

@end
