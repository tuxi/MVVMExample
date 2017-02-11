//
//  XYNetworkRequest.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  请求成功block
 */
typedef void (^successBlock)(id responseObject);

/**
 *  请求失败block
 */
typedef void (^failureBlock) (NSError *error);

/**
 *  请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);

/**
 *  监听进度响应block
 */
typedef void (^progressBlock)(NSProgress * progress);

@class XYRequestFileConfig;
@interface XYNetworkRequest : NSObject

/**
 *  请求超时时间
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 reachable
 */
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

/**
 reachableViaWWAN
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;

/**
 reachableViaWiFi
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;

/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 *  取消所有操作
 */
- (void)cancelAllOperations;

/**
 *  配置全局的scheme和host，若request中重新设置新值，则值为request中设置的新值
 *
 *  @param scheme scheme (eg: http, https, ftp)
 *  @param host   host
 */
- (void)configScheme:(NSString *)scheme host:(NSString *)host;

/**
 *  发送请求(在外部配置request)
 */
- (NSURLSessionTask *)sendRequest:
(id)request
                         progress:(progressBlock)progress
                          success:(successBlock)success
                          failure:(failureBlock)failure;

/**
 *  发送请求Block(在block内部配置request)
 */
- (NSURLSessionTask *)sendRequestBlock:
(id (^)(NSObject *request))requestBlock
                              progress:(progressBlock)progress
                               success:(successBlock)success
                               failure:(failureBlock)failure;


@end

@interface XYRequestFileConfig : NSObject

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *fileData;

/**
 *  服务器接收参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

+ (instancetype)fileConfigWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

- (instancetype)initWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end
