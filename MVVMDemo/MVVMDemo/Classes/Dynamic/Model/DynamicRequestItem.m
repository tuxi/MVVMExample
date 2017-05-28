//
//  DynamicRequestItem.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "DynamicRequestItem.h"
#import "NSObject+XYProperties.h"

@implementation DynamicRequestItem

- (instancetype)init {
    if (self = [super init]) {
        
        /// 初始化各请求参数
        self.uid = @67417;
        self.channel = @"AppStore";
        self.ver = @"3.4.4";
        self.where = @"";
        self.limt = @20;
        self.dtype = @1;
        self.sversion = @"10.3.1";
        self.token = @"010dc6a7f9d17ec0d2c296dfaab56232";
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
    
    NSLog(@"%@", self.xy_allProperties);
    return self.xy_allProperties;
    
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"配置的请求参数为:{uid=%@, channel=%@, ver=%@, where=%@, limt=%@, dtype=%@, sversion=%@, token=%@, page=%@, language=%@, mtype=%@}", self.uid, self.channel, self.ver, self.where, self.limt, self.dtype, self.sversion, self.token, self.page, self.language, self.mtype];
}

- (void)dealloc {

}

@end
