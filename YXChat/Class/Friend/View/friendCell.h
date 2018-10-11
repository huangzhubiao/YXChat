//
//  friendCell.h
//  YXChat
//
//  Created by ios on 2018/10/8.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JMessage/JMessage.h>

@interface friendCell : UITableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) JMSGUser *user;
@end
