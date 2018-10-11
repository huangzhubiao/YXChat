//
//  YXVerificationInfo.h
//  YXChat
//
//  Created by ios on 2018/10/11.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXVerificationInfo;

NS_ASSUME_NONNULL_BEGIN

@interface YXVerificationInfoManager : NSObject
+(instancetype)shareInstance;
/**
 创建数据库
 
 @param tableName 表名称
 @return 是否创建成功
 */
-(BOOL)creatDataBaseWithName:(NSString *)tableName;


-(BOOL)insertUser:(YXVerificationInfo *)info;

-(BOOL)deleteUser:(YXVerificationInfo *)info;
-(BOOL)deleteinfo;

-(BOOL)updataUser:(YXVerificationInfo *)info;

- (YXVerificationInfo *)getUserWith:(NSString *)ID;
-(NSArray *)seleteinfo;
@end

@interface YXVerificationInfo : NSObject

@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *appkey;
@property (nonatomic,copy) NSString *reason;
@property (nonatomic,assign) int state;

@end

NS_ASSUME_NONNULL_END
