//
//  FindFriendViewController.m
//  YXChat
//
//  Created by ios on 2018/10/10.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "FindFriendViewController.h"
#import "masonry.h"
#import <JMessage/JMessage.h>
#import "AddFriendCell.h"

@interface FindFriendViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) UIButton *searchButton;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *friendsArray;

@end

@implementation FindFriendViewController

-(NSMutableArray *)friendsArray{
    if (!_friendsArray) {
        _friendsArray = [NSMutableArray array];
    }
    return _friendsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    UITextField *searchTextField = [[UITextField alloc] init];
    searchTextField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.searchTextField = searchTextField;
    searchTextField.delegate = self;
    [self.view addSubview:searchTextField];
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UIButton *searchButton = [[UIButton alloc] init];
    self.searchButton = searchButton;
    searchButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:searchButton];
    [searchButton setTitle:@"查找" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(searchTextField.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UITableView *tableView = [[UITableView alloc] init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(searchButton.mas_bottom).offset(20);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)searchFriend{
    __weak typeof(self) weakSelf = self;
    NSString *userName = self.searchTextField.text;
    [JMSGUser userInfoArrayWithUsernameArray:@[userName] completionHandler:^(id resultObject, NSError *error) {
        NSArray *arr = resultObject;
        [weakSelf.friendsArray addObjectsFromArray:arr];
        [weakSelf.tableView reloadData];
    }];
}


- (void)addFriendWith:(JMSGUser *)user{
    [JMSGFriendManager sendInvitationRequestWithUsername:user.username appKey:user.appKey reason:@"添加我为好友" completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            NSLog(@"发送成功");
        }
    }];
}

#pragma mark --UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddFriendCell *cell = [AddFriendCell cellWithTableView:tableView];
    __weak typeof(self) weakSelf = self;
    cell.addFriend = ^(JMSGUser *user) {
        [weakSelf addFriendWith:user];
    };
    cell.user = self.friendsArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
