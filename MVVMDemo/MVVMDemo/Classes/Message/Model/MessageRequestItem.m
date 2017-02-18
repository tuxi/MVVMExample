//
//  MessageRequestItem.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/18.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "MessageRequestItem.h"

@implementation MessageRequestItem

- (void)xy_requestConfigures {
    
    self.xy_url = @"http://me.api.kfit.com.cn/me-api/rest/api/trend/save";
    self.xy_method = RequestMethodPOST;
    NSString *token = @"965b58eb-7bac-491d-887e-49ef93b43bf9";
    self.xy_headers = @{@"token": token, @"uid": @"21179"};
}

- (NSDictionary *)xy_requestParameters {
    
    return @{@"content": @"今天天气真好呀！！", @"labels": @"", @"lat": @"0.000000", @"level3	1": @"1", @"lot": @"0.000000", @"title": @"希望周一一切顺利！", @"type": @"1"};
}


@end
