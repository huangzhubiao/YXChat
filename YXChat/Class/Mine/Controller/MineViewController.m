//
//  MineViewController.m
//  YXChat
//
//  Created by ios on 2018/10/9.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "MineViewController.h"
#import "masonry.h"
#import <JMessage/JMessage.h>

@interface MineViewController ()

@property (nonatomic,strong) UIButton *logoutButton;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI{
    self.logoutButton = [[UIButton alloc] init];
    [self.view addSubview:self.logoutButton];
    self.logoutButton.backgroundColor = [UIColor orangeColor];
    [self.logoutButton setTitle:@"注销" forState:UIControlStateNormal];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(50);
    }];
    [self.logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
}

- (void)logout{
    __weak typeof(self) weakSelf = self;
    [JMSGUser logout:^(id resultObject, NSError *error) {
        [weakSelf logoutNotification];
    }];
}

- (void)logoutNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutNotification" object:nil];
}

@end
