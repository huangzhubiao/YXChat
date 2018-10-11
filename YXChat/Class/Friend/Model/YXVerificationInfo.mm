//
//  YXVerificationInfo.m
//  YXChat
//
//  Created by ios on 2018/10/11.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "YXVerificationInfo.h"
#import "YXVerificationInfo+WCTTableCoding.h"

@implementation YXVerificationInfo
WCDB_IMPLEMENTATION(YXVerificationInfo)

WCDB_SYNTHESIZE(YXVerificationInfo, ID)
WCDB_SYNTHESIZE(YXVerificationInfo, username)
WCDB_SYNTHESIZE(YXVerificationInfo, nickname)
WCDB_SYNTHESIZE(YXVerificationInfo, appkey)
WCDB_SYNTHESIZE(YXVerificationInfo, reason)
WCDB_SYNTHESIZE(YXVerificationInfo, state)

WCDB_PRIMARY(YXVerificationInfo, ID)
WCDB_INDEX(YXVerificationInfo, "_index", appkey)
@end


@interface YXVerificationInfoManager(){
    WCTDatabase *database;
}

@end

@implementation YXVerificationInfoManager

+(instancetype)shareInstance{
    
    static YXVerificationInfoManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YXVerificationInfoManager alloc] init];
    });
    
    return instance;
}


/**
 创建数据库
 
 @param tableName 表名称
 @return 是否创建成功
 */
-(BOOL)creatDataBaseWithName:(NSString *)tableName{
    //获取沙盒根目录
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    NSLog(@"path = %@",filePath);
    database = [[WCTDatabase alloc]initWithPath:filePath];
    //测试数据库是否能够打开
    if ([database canOpen]) {
        if ([database isOpened]) {
            if ([database isTableExists:tableName]) {
                NSLog(@"表已经存在");
                return NO;
            }else
                return [database createTableAndIndexesOfName:tableName withClass:YXVerificationInfo.class];
        }
    }
    return NO;
}


-(BOOL)insertUser:(YXVerificationInfo *)info{
    [self deleteUser:info];
    return  [database insertObject:info  into:@"info"];
}

-(BOOL)deleteUser:(YXVerificationInfo *)info{
    
    return [database deleteAllObjectsFromTable:@"info"];
}

-(BOOL)updataUser:(YXVerificationInfo *)info{
    return YES;
}

- (YXVerificationInfo *)getUserWith:(NSString *)ID{
    YXVerificationInfo *user = nil;
    user = [database getOneObjectOfClass:YXVerificationInfo.class fromTable:@"info" where:YXVerificationInfo.ID.like(ID)];
    return user;
}
-(BOOL)deleteinfo{
     return [database deleteAllObjectsFromTable:@"info"];
}
-(NSArray *)seleteinfo{
    //SELECT * FROM message ORDER BY localID
    NSArray<YXVerificationInfo *> * message = [database getAllObjectsOfClass:YXVerificationInfo.class fromTable:@"info"];
    
    return message;
}
@end
