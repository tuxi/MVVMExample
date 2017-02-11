//
//  SecondRequetItem.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "SecondRequetItem.h"


@implementation SecondRequetItem

- (void)xy_requestConfigures {
    self.xy_url = @"https://api.douban.com/v2/book/search";
}

- (id)xy_requestParameters {
    return @{@"q": @"基础"};
}

@end
