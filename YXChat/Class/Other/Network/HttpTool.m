//
//  HttpTool.m
//  huocheng
//
//  Created by ios on 2018/9/3.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

static HttpTool *httpManager = nil;
static AFHTTPSessionManager *afnManager = nil;

@implementation HttpTool
/**
 *  创建单例
 *
 *  @return <#return value description#>
 */
+ (HttpTool *)httpManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[HttpTool alloc] init];
        afnManager = [AFHTTPSessionManager manager];
        afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return httpManager;
}

//GET请求
- (void)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters success:(Success)success failure:(Failure)failure {
    afnManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [afnManager GET:url parameters:paramters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

//POST请求
- (void)postDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters success:(Success)success failure:(Failure)failure {
    [afnManager POST:url parameters:paramters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

@end
