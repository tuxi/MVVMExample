//
//  XYNetworkRequest.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYNetworkRequest.h"
#import "AFNetworking.h"
#import "NSObject+XYRequest.h"

static NSString * const XYRequestUrlPath = @"XYRequestUrlPath";
static NSString * const XYRequestParameters = @"XYRequestParameters";

@interface XYNetworkRequest ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
/**
 *  scheme
 */
@property (nonatomic, copy) NSString *scheme;
/**
 *  host
 */
@property (nonatomic, copy) NSString *host;
@end

@implementation XYNetworkRequest

#pragma mark - 单例设计
static id _instance;

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        _sessionManager.requestSerializer.timeoutInterval = (!self.timeoutInterval ?: self.timeoutInterval);
    }
    return _sessionManager;
}

- (void)configScheme:(NSString *)scheme host:(NSString *)host {
    self.scheme = scheme;
    self.host = host;
}

#pragma mark - public request method
- (NSURLSessionTask *)sendRequest:(id)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    if ([request respondsToSelector:@selector(xy_requestConfigures)]) {
        [request xy_requestConfigures];
    }
    
    NSObject *requestObj = (NSObject *)request;
    NSURLSessionTask *task = nil;
    
    switch (requestObj.xy_method) {
        case RequestMethodGET:
            task = [self get:request progress:progress success:success failure:failure];
            break;
        case RequestMethodPOST:
            task = [self post:request progress:progress success:success failure:failure];
            break;
        case RequestMethodUPLOAD:
            task = [self upload:request progress:progress success:success failure:failure];
            break;
        case RequestMethodDOWNLOAD:
            task = [self download:request progress:progress success:success failure:failure];
            break;
        default:
            break;
    }
    return task;
}

- (NSURLSessionTask *)sendRequestBlock:(id (^)(NSObject *))requestBlock progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    if (requestBlock) {
        NSObject *requestObj = [NSObject new];
        return [self sendRequest:requestBlock(requestObj) progress:progress success:success failure:failure];
    } else {
        return nil;
    }
}

#pragma mark - private
/// GET请求
- (NSURLSessionTask *)get:(id)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    /// 获取请求路径和请求参数
    NSDictionary *requestDict = [self requestObject:request];
    NSString *urlPath = requestDict[XYRequestUrlPath];
    NSDictionary *parameters = requestDict[XYRequestParameters];
    
    return [self.sessionManager GET:urlPath parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            if (downloadProgress) {
                progress(downloadProgress);
            }
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (responseObject) {
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (error) {
                failure(error);
            }
        }
    }];
}

/// POST请求
- (NSURLSessionTask *)post:(id)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    /// 获取请求路径和请求参数
    NSDictionary *requestDict = [self requestObject:request];
    NSString *urlPath = requestDict[XYRequestUrlPath];
    NSDictionary *parameters = requestDict[XYRequestParameters];
    
    return [self.sessionManager POST:urlPath parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            if (uploadProgress) {
                progress(uploadProgress);
            }
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (responseObject) {
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (error) {
                failure(error);
            }
        }
    }];
}

/// 下载
- (NSURLSessionTask *)download:(id)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    /// 获取请求路径
    NSDictionary *requestDict = [self requestObject:request];
    NSString *urlPath = requestDict[XYRequestUrlPath];
    
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:urlRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            if (downloadProgress) {
                progress(downloadProgress);
            }
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (failure) {
            if (error) {
                failure(error);
            }
            if (success) {
                if (response) {
                    success(response);
                }
            }
        }
    }];
    
    [downloadTask resume];
    return downloadTask;
}

/// 上传
- (NSURLSessionTask *)upload:(id)request progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure {
    
    /// 获取请求路径和请求参数
    NSDictionary *requestDict = [self requestObject:request];
    NSString *urlPath = requestDict[XYRequestUrlPath];
    NSDictionary *parameters = requestDict[XYRequestParameters];
    
    NSObject *requestObj = (NSObject *)request;
    
    return [self.sessionManager POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:requestObj.xy_fileConfig.fileData
                                    name:requestObj.xy_fileConfig.name
                                fileName:requestObj.xy_fileConfig.fileName
                                mimeType:requestObj.xy_fileConfig.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            if (uploadProgress) {
                progress(uploadProgress);
            }
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (responseObject) {
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (error) {
                failure(error);
            }
        }
    }];
    
}

/// 处理请求路径和请求参数，并返回处理后的结果
- (NSDictionary *)requestObject:(id)request {
    NSObject *requestObjc = (NSObject *)request;
    
    /// 处理urlPath
    NSString *urlPath = nil;
    if (requestObjc.xy_url.length) {
        urlPath = requestObjc.xy_url;
    } else {
        NSString *scheme = nil;
        NSString *host = nil;
        scheme = self.scheme.length > 0 ? self.scheme : requestObjc.xy_scheme;
        host = self.host.length > 0 ? self.host : requestObjc.xy_host;
        urlPath = [NSString stringWithFormat:@"%@://%@%@", scheme, host, requestObjc.xy_path];
    }
    
    /// 处理parameters参数
    id parameters = nil;
    if ([request respondsToSelector:@selector(xy_requestParameters)]) {
        parameters = [request xy_requestParameters];
    } else if ([request respondsToSelector:@selector(setXy_params:)]) {
        parameters = requestObjc.xy_params;
    }
    
    return @{
             XYRequestUrlPath: urlPath,
             XYRequestParameters: parameters ?: @""
              };
}

/// 取消所有操作
- (void)cancelAllOperations {
    [self.sessionManager.operationQueue cancelAllOperations];
}

#pragma mark - 网络环境判断
- (BOOL)isReachable {
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

- (BOOL)isReachableViaWiFi {
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
}

- (BOOL)isReachableViaWWAN {
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWWAN];
}

@end
