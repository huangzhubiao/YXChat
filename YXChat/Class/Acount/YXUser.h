//
//  YXUser.h
//  YXChat
//
//  Created by ios on 2018/9/28.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YXUser;


@interface YXUserManager : NSObject


+(instancetype)shareInstance;


/**
 创建数据库
 
 @param tableName 表名称
 @return 是否创建成功
 */
-(BOOL)creatDataBaseWithName:(NSString *)tableName;


-(BOOL)insertUser:(YXUser *)user;

-(BOOL)deleteUser:(YXUser *)user;

-(BOOL)updataUser:(YXUser *)user;

-(NSArray *)seleteUser;
- (YXUser *)getUserWith:(NSString *)userId;


@end
//self.user = [[YXUser alloc] init];
//self.user.userID = @"1001";
//self.user.avatarURL = @"http://p1.qq181.com/cms/120506/2012050623111097826.jpg";
//self.user.nikeName = @"李伯坤";
//self.user.username = @"li-bokun";
//self.user.qqNumber = @"1159197873";
//self.user.email = @"libokun@126.com";
//self.user.location = @"山东 滨州";
//self.user.sex = @"男";
//self.user.motto = @"Hello world!";
//self.user.momentsWallURL = @"http://pic1.win4000.com/wallpaper/c/5791e49b37a5c.jpg";

@interface YXUser : NSObject
/// 用户ID
@property (nonatomic, strong) NSString *userID;

/// 用户名
@property (nonatomic, strong) NSString *username;

/// 昵称
@property (nonatomic, strong) NSString *nikeName;

/// 头像URL
@property (nonatomic, strong) NSString *avatarURL;

/// 头像Path
@property (nonatomic, strong) NSString *avatarPath;
//
///// 备注名
//@property (nonatomic, strong) NSString *remarkName;
//
///// 界面显示名称
//@property (nonatomic, strong, readonly) NSString *showName;


//======
@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *location;

//@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic, strong) NSString *qqNumber;

@property (nonatomic, strong) NSString *email;

//@property (nonatomic, strong) NSArray *albumArray;

@property (nonatomic, strong) NSString *motto;

@property (nonatomic, strong) NSString *momentsWallURL;

///// 备注信息
//@property (nonatomic, strong) NSString *remarkInfo;
//
///// 备注图片（本地地址）
//@property (nonatomic, strong) NSString *remarkImagePath;
//
///// 备注图片 (URL)
//@property (nonatomic, strong) NSString *remarkImageURL;

/// 标签
//@property (nonatomic, strong) NSMutableArray *tags;

//=====
@end
