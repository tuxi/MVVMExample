//
//  FirstRequest.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "FirstRequest.h"


@implementation FirstRequest

- (void)xy_requestConfigures {
    self.xy_scheme = @"https";
    self.xy_host = @"api.douban.com";
    self.xy_path = @"/v2/book/search";
    self.xy_method = RequestMethodGET;
}

- (id)xy_requestParameters {
    return @{@"q": @"基础"};
}

@end
