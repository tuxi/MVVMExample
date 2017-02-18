//
//  NSObject+XYRequest.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYRequestProtocol.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, RequestMethod) {
    RequestMethodGET,
    RequestMethodPOST,
    RequestMethodUPLOAD,
    RequestMethodDOWNLOAD
    
};

@class XYRequestFileConfig;
@interface NSObject (XYRequest)

/**
 *  scheme (eg: http, https, ftp)
 */
@property (nonatomic, copy, nonnull) NSString *xy_scheme;

/**
 *  host
 */
@property (nonatomic, copy, nonnull) NSString *xy_host;

/**
 *  path
 */
@property (nonatomic, copy, nonnull) NSString *xy_path;

/**
 *  请求头 此参数需要设置在requestSerializer中
 */
@property (nonatomic, strong, nonnull) NSDictionary *xy_headers;

/**
 *  method
 */
@property (nonatomic, assign) RequestMethod xy_method;

/**
 * url 请求的全路径 (如果设置了url，则不需要在设置scheme，host，path 属性)
 */
@property (nonatomic, copy) NSString *xy_url;

/**
 * parameters 请求参数
 */
@property (nonatomic, strong) id xy_params;

/**
 * fileConfig
 */
@property (nonatomic, strong) XYRequestFileConfig *xy_fileConfig;

@end

NS_ASSUME_NONNULL_END
