//
//  ConversationCell.h
//  YXChat
//
//  Created by ios on 2018/9/30.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JMessage/JMessage.h>

@interface ConversationCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) JMSGConversation *conversation;

@end
