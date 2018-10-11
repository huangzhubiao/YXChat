//
//  YXUser.m
//  YXChat
//
//  Created by ios on 2018/9/28.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "YXUser.h"
#import "YXUser+WCTTableCoding.h"

@implementation YXUser

WCDB_IMPLEMENTATION(YXUser)

WCDB_SYNTHESIZE(YXUser, userID)
WCDB_SYNTHESIZE(YXUser, username)
WCDB_SYNTHESIZE(YXUser, nikeName)
WCDB_SYNTHESIZE(YXUser, avatarURL)
WCDB_SYNTHESIZE(YXUser, avatarPath)
//WCDB_SYNTHESIZE(YXUser, remarkName)
//WCDB_SYNTHESIZE(YXUser, showName)
WCDB_SYNTHESIZE(YXUser, sex)
//WCDB_SYNTHESIZE(YXUser, phoneNumber)
WCDB_SYNTHESIZE(YXUser, qqNumber)
WCDB_SYNTHESIZE(YXUser, email)
WCDB_SYNTHESIZE(YXUser, motto)
WCDB_SYNTHESIZE(YXUser, momentsWallURL)
//WCDB_SYNTHESIZE(YXUser, remarkInfo)
//WCDB_SYNTHESIZE(YXUser, remarkImagePath)
//WCDB_SYNTHESIZE(YXUser, remarkImageURL)

WCDB_PRIMARY(YXUser, userID)

WCDB_INDEX(YXUser, "_index", qqNumber)

@end


@interface YXUserManager(){
    WCTDatabase *database;
}

@end


@implementation YXUserManager

+(instancetype)shareInstance{
    
    static YXUserManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YXUserManager alloc] init];
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
    // 数据库加密
    //NSData *password = [@"MyPassword" dataUsingEncoding:NSASCIIStringEncoding];
    //[database setCipherKey:password];
    //测试数据库是否能够打开
    if ([database canOpen]) {
        
        // WCDB大量使用延迟初始化（Lazy initialization）的方式管理对象，因此SQLite连接会在第一次被访问时被打开。开发者不需要手动打开数据库。
        // 先判断表是不是已经存在
        if ([database isOpened]) {
            
            if ([database isTableExists:tableName]) {
                
                NSLog(@"表已经存在");
                return NO;
                
            }else
                return [database createTableAndIndexesOfName:tableName withClass:YXUser.class];
        }
    }
    return NO;
}


-(BOOL)insertUser:(YXUser *)user{
     return  [database insertObject:user  into:@"user"];
}

-(BOOL)deleteUser:(YXUser *)user{
     return YES;
}

-(BOOL)updataUser:(YXUser *)user{
     return YES;
}

-(NSArray *)seleteUser{
    //SELECT * FROM message ORDER BY localID
    NSArray<YXUser *> * message = [database getAllObjectsOfClass:YXUser.class fromTable:@"user"];
    
    return message;
}

- (YXUser *)getUserWith:(NSString *)userId{
    YXUser *user = nil;
    user = [database getOneObjectOfClass:YXUser.class fromTable:@"user" where:YXUser.userID.like(userId)];
    return user;
}

// Message.content.like("Hello%")];
@end













