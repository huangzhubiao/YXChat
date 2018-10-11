//
//  AddFriendCell.m
//  YXChat
//
//  Created by ios on 2018/10/11.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "AddFriendCell.h"

@interface AddFriendCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end


@implementation AddFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"AddFriendCell";
    AddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddFriendCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (IBAction)clickAddFriendButton:(id)sender {
    if (self.addFriend) {
        self.addFriend(self.user);
    }
}


-(void)setUser:(JMSGUser *)user{
    _user = user;
    _userNameLabel.text = [_user username];
    __weak typeof(self) weakSelf = self;
    [_user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.iconImageView.image = image;
        });
    }];
}


@end
