//
//  FriendViewController.m
//  YXChat
//
//  Created by ios on 2018/10/8.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "FriendViewController.h"
#import <JMessage/JMessage.h>
#import "friendCell.h"
#import "masonry.h"
#import "FindFriendViewController.h"
#import "YXVerificationInfo.h"
#import "XZChatViewController.h"
#import "XZGroup.h"

@interface FriendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *friendArr;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UILabel *vericationLabel;

@end

@implementation FriendViewController

-(NSMutableArray *)friendArr{
    if (!_friendArr) {
        _friendArr = [NSMutableArray array];
    }
    return _friendArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightBarItem];
    
    UILabel *vericationLabel = [[UILabel alloc] init];
    self.vericationLabel = vericationLabel;
    vericationLabel.text = @"消息验证";
    [self.view addSubview:vericationLabel];
    [vericationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-80);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *recevieButton = [[UIButton alloc] init];
    [self.view addSubview:recevieButton];
    recevieButton.backgroundColor = [UIColor greenColor];
    [recevieButton setTitle:@"通过验证" forState:UIControlStateNormal];
    [recevieButton addTarget:self action:@selector(passVerication) forControlEvents:UIControlEventTouchUpInside];
    [recevieButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.left.mas_equalTo(vericationLabel.mas_right).offset(0);
        make.right.mas_equalTo(-0);
        make.height.mas_equalTo(40);
    }];
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(vericationLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    __weak typeof(self) weakSelf = self;
    [JMSGFriendManager getFriendList:^(id resultObject, NSError *error) {
        
        NSArray *userArray = resultObject;
        [weakSelf.friendArr addObjectsFromArray:userArray];
        [weakSelf.tableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    
    YXVerificationInfoManager *infomanger = [YXVerificationInfoManager shareInstance];
    NSArray *vericationArr = [infomanger seleteinfo];
    YXVerificationInfo *info = [vericationArr firstObject];
    if (vericationArr.count != 0) {
        NSString *str = [NSString stringWithFormat:@"有好友(%@)请求添加",info.username];
        self.vericationLabel.text = str;
    }else{
        self.vericationLabel.text = @"无验证消息";
    }
}

- (void)passVerication{
    
    
    YXVerificationInfoManager *infomanger = [YXVerificationInfoManager shareInstance];
    NSArray *vericationArr = [infomanger seleteinfo];
    if (vericationArr.count == 0) {
        return;
    }
    YXVerificationInfo *info = [vericationArr firstObject];
    __weak typeof(self) weakSelf = self;
    [JMSGFriendManager acceptInvitationWithUsername:info.username appKey:info.appkey completionHandler:^(id resultObject, NSError *error) {
        if (error == nil) {
            [weakSelf reflesh];
        }
    }];
}

- (void)reflesh{
    YXVerificationInfoManager *infomanger = [YXVerificationInfoManager shareInstance];
    [infomanger deleteinfo];
    [self.friendArr removeAllObjects];
    __weak typeof(self) weakSelf = self;
    [JMSGFriendManager getFriendList:^(id resultObject, NSError *error) {
        NSArray *userArray = resultObject;
        [weakSelf.friendArr addObjectsFromArray:userArray];
        [weakSelf.tableView reloadData];
    }];
}

- (void)addRightBarItem{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 60, 30);
    
    btn.selected = NO;
    
    [btn setTitle:@"查找" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickSearch{
    FindFriendViewController *friendVC = [[FindFriendViewController alloc] init];
    [self.navigationController pushViewController:friendVC animated:YES];
    
}

#pragma mark --UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    friendCell *cell = [friendCell cellWithTableView:tableView];
    cell.user = self.friendArr[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JMSGUser *user = self.friendArr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    [JMSGConversation createSingleConversationWithUsername:user.username appKey:user.appKey completionHandler:^(id resultObject, NSError *error) {
        JMSGConversation *conversation = (JMSGConversation *)resultObject;
        [weakSelf createSingle:conversation];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)createSingle:(JMSGConversation *)conversation{
    XZGroup *group = [[XZGroup alloc] init];
    XZChatViewController *chatVc = [[XZChatViewController alloc] init];
    chatVc.group                 = group;
    chatVc.conversation = conversation;
    chatVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVc animated:YES];
}

@end
