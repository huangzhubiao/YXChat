//
//  YXUser+WCTTableCoding.h
//  YXChat
//
//  Created by ios on 2018/9/28.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "YXUser.h"
#import <WCDB/WCDB.h>

@interface YXUser (WCTTableCoding)<WCTTableCoding>
WCDB_PROPERTY(userID)
WCDB_PROPERTY(username)
WCDB_PROPERTY(nikeName)
WCDB_PROPERTY(avatarURL)
WCDB_PROPERTY(avatarPath)
WCDB_PROPERTY(remarkName)
WCDB_PROPERTY(showName)
WCDB_PROPERTY(sex)
WCDB_PROPERTY(phoneNumber)
WCDB_PROPERTY(qqNumber)
WCDB_PROPERTY(email)
WCDB_PROPERTY(motto)
WCDB_PROPERTY(momentsWallURL)
WCDB_PROPERTY(remarkInfo)
WCDB_PROPERTY(remarkImagePath)
WCDB_PROPERTY(remarkImageURL)
@end
