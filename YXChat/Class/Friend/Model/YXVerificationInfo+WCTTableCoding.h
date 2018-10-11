//
//  YXVerificationInfo+WCTTableCoding.h
//  YXChat
//
//  Created by ios on 2018/10/11.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "YXVerificationInfo.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXVerificationInfo (WCTTableCoding)<WCTTableCoding>
WCDB_PROPERTY(ID)
WCDB_PROPERTY(username)
WCDB_PROPERTY(nikeName)
WCDB_PROPERTY(appkey)
WCDB_PROPERTY(reason)
WCDB_PROPERTY(state)
@end

NS_ASSUME_NONNULL_END
