//
//  ConversationCell.m
//  YXChat
//
//  Created by ios on 2018/9/30.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "ConversationCell.h"

@interface ConversationCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *chatTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastChatContentLable;

@end

@implementation ConversationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *const Idetifier = @"ConversationCell";
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:Idetifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ConversationCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

-(void)setConversation:(JMSGConversation *)conversation{
    _conversation = conversation;
    __weak typeof(self) weakSelf = self;
    [(JMSGUser *)_conversation.target thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
        NSLog(@"data = %@",data);
        weakSelf.avatorImageView.image = [UIImage imageWithData:data];
        
        
    }];
    _chatTitleLabel.text = _conversation.title;
    _lastChatContentLable.text = _conversation.latestMessageContentText;
}

@end
