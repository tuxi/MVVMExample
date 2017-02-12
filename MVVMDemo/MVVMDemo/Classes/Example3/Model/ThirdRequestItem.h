//
//  ThirdRequestItem.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYRequestProtocol.h"
#import "NSObject+XYRequest.h"

@interface ThirdRequestItem : NSObject<XYRequestProtocol>

/// 请求参数
@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *ver;
@property (nonatomic, copy) NSString *where;
@property (nonatomic, copy) NSNumber *limt;
@property (nonatomic, copy) NSNumber *dtype;
@property (nonatomic, copy) NSString *sversion;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSNumber *page;
@property (nonatomic, copy) NSString *mtype;
@property (nonatomic, copy) NSNumber *language;


@end
