//
//  XZChatViewController.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZGroup.h"
#import <JMessage/JMessage.h>

@interface XZChatViewController : UIViewController

@property (nonatomic, strong) XZGroup *group;
@property (nonatomic,strong) JMSGConversation *conversation;

@end
