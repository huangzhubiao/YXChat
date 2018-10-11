//
//  HttpTool.h
//  huocheng
//
//  Created by ios on 2018/9/3.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HttpTool;

//block回调传值
/**
 *   请求成功回调json数据
 *
 *  @param json json串
 */
typedef void(^Success)(id json);
/**
 *  请求失败回调错误信息
 *
 *  @param error error错误信息
 */
typedef void(^Failure)(NSError *error);
@interface HttpTool : NSObject

//单例模式
+ (HttpTool *)httpManager;
/**
 *  GET请求
 *
 *  @param url       NSString 请求url
 *  @param paramters NSDictionary 参数
 *  @param success   void(^Success)(id json)回调
 *  @param failure   void(^Failure)(NSError *error)回调
 */
- (void)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters success:(Success)success failure:(Failure)failure;
/**
 *  POST请求
 *
 *  @param url       NSString 请求url
 *  @param paramters NSDictionary 参数
 *  @param success   void(^Success)(id json)回调
 *  @param failure   void(^Failure)(NSError *error)回调
 */
- (void)postDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters success:(Success)success failure:(Failure)failure;


@end
