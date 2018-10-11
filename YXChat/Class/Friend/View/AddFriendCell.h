//
//  AddFriendCell.h
//  YXChat
//
//  Created by ios on 2018/10/11.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JMessage/JMessage.h>

typedef void(^addFriendBlock)(JMSGUser *user);

NS_ASSUME_NONNULL_BEGIN

@interface AddFriendCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,copy) addFriendBlock addFriend;

@property (nonatomic,strong) JMSGUser *user;



@end

NS_ASSUME_NONNULL_END
