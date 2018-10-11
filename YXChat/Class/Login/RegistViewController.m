//
//  RegistViewController.m
//  YXChat
//
//  Created by ios on 2018/10/10.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "RegistViewController.h"
#import "masonry.h"
#import <JMessage/JMessage.h>

@interface RegistViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *acountTextField;
@property (nonatomic,strong) UITextField *passwordTextFiled;

@property (nonatomic,strong) UIButton *registButton;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI{
    self.acountTextField = [[UITextField alloc] init];
    [self.view addSubview:self.acountTextField];
    self.acountTextField.delegate = self;
    [self.acountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    self.acountTextField.backgroundColor = [UIColor grayColor];
    
    self.passwordTextFiled = [[UITextField alloc] init];
    self.passwordTextFiled.delegate = self;
    [self.view addSubview:self.passwordTextFiled];
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.acountTextField.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    self.passwordTextFiled.backgroundColor = [UIColor grayColor];

    
    self.registButton = [[UIButton alloc] init];
    [self.view addSubview:self.registButton];
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextFiled.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    [self.registButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    self.registButton.backgroundColor = [UIColor grayColor];
}
- (void)regist{
    NSString *account = self.acountTextField.text;
    NSString *password = self.passwordTextFiled.text;
    __weak typeof(self) weakSelf = self;
    [JMSGUser registerWithUsername:account password:password completionHandler:^(id resultObject, NSError *error) {
        [weakSelf registSuccessNotification];
    }];
}
- (void)registSuccessNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutNotification" object:nil];
}
@end
