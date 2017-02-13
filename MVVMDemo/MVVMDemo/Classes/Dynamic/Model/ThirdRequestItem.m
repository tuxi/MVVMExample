//
//  ThirdRequestItem.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "ThirdRequestItem.h"

@implementation ThirdRequestItem

- (instancetype)init {
    if (self = [super init]) {
        
        /// 初始化各请求参数
        self.uid = @67417;
        self.channel = @"AppStore";
        self.ver = @"3.3.1";
        self.where = @"";
        self.limt = @20;
        self.dtype = @1;
        self.sversion = @"10.2";
        self.token = @"8ed50c5dcbe18151261c7788dacf549d";
        self.page = @1;
        self.language = @0;
        self.mtype = @"iPhone 6";
    }
    return self;
}

- (void)xy_requestConfigures {
    
    self.xy_scheme = @"http";
    self.xy_host = @"app.drama.wang";
    self.xy_path = @"/indexv3/newtopiclist";
    
}

- (NSDictionary *)xy_requestParameters {
    
    return @{@"uid": self.uid, @"channel": self.channel, @"ver": self.ver, @"where": self.where, @"limt": self.limt, @"dtype": self.dtype, @"sversion": self.sversion, @"token": self.token, @"page": self.page, @"language": self.language, @"mtype": self.mtype};
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"配置的请求参数为:{uid=%@, channel=%@, ver=%@, where=%@, limt=%@, dtype=%@, sversion=%@, token=%@, page=%@, language=%@, mtype=%@}", self.uid, self.channel, self.ver, self.where, self.limt, self.dtype, self.sversion, self.token, self.page, self.language, self.mtype];
}


@end
