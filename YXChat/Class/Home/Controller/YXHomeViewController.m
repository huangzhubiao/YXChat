//
//  YXHomeViewController.m
//  YXChat
//
//  Created by ios on 2018/9/28.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "YXHomeViewController.h"
#import "YXUser.h"
#import <JMessage/JMessage.h>
#import "masonry.h"
#import "YXChatViewController.h"
#import "ConversationCell.h"
#import "XZChatViewController.h"

@interface YXHomeViewController ()<JMessageDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) YXUser *user;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation YXHomeViewController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [JMessage addDelegate:self withConversation:nil];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
//    __weak typeof(self) weakSelf = self;
//    [JMSGUser loginWithUsername:@"Biao1234" password:@"123456" completionHandler:^(id resultObject, NSError *error) {
//        NSLog(@"login resulte = %@",resultObject);
//        [weakSelf loadData];
//    }];
    [self loadData];
}

- (void)loadData{
    [self.dataArray removeAllObjects];
    __weak typeof(self) weakSelf = self;
    [JMSGConversation allConversations:^(id resultObject, NSError *error) {
        NSLog(@"conver = %@",resultObject);
        NSMutableArray *arr = resultObject;
        [weakSelf.dataArray addObjectsFromArray:arr];
        [weakSelf.tableView reloadData];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UITableViewDelegate UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//
//    JMSGConversation *coversation = self.dataArray[indexPath.row];
//    cell.textLabel.text = coversation.title;
//    cell.detailTextLabel.text = coversation.latestMessageContentText;
//    [(JMSGUser *)coversation.target thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
//
//    }];
//    return cell;
    ConversationCell *cell = [ConversationCell cellWithTableView:tableView];
    JMSGConversation *coversation = self.dataArray[indexPath.row];
    cell.conversation = coversation;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    XZGroup *group = [[XZGroup alloc] init];
    XZChatViewController *chatVc = [[XZChatViewController alloc] init];
    JMSGConversation *conversation = self.dataArray[indexPath.row];
    chatVc.group                 = group;
    chatVc.conversation = conversation;
    chatVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}




- (void)initUser{
    self.user = [[YXUser alloc] init];
    self.user.userID = @"1001";
    self.user.avatarURL = @"http://p1.qq181.com/cms/120506/2012050623111097826.jpg";
    self.user.nikeName = @"李555";
    self.user.username = @"li-bokun";
    self.user.qqNumber = @"1159197873";
    self.user.email = @"libokun@126.com";
    self.user.location = @"山东 滨州";
    self.user.sex = @"男";
    self.user.motto = @"Hello world!";
    self.user.momentsWallURL = @"http://pic1.win4000.com/wallpaper/c/5791e49b37a5c.jpg";
    
    YXUserManager *userManager = [YXUserManager shareInstance];
    BOOL res = [userManager creatDataBaseWithName:@"user"];

    res = [userManager insertUser:self.user];
    if (res) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }

    
}

@end
