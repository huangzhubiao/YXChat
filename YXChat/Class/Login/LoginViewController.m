//
//  LoginViewController.m
//  YXChat
//
//  Created by ios on 2018/10/10.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "LoginViewController.h"
#import "masonry.h"
#import <JMessage/JMessage.h>
#import "PrivateViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *acountTextField;
@property (nonatomic,strong) UITextField *passwordTextFiled;

@property (nonatomic,strong) UIButton *registButton;
@property (nonatomic,strong) UIButton *loginButton;

@property (nonatomic,strong) UIButton *privateButton;

@end

@implementation LoginViewController

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
    
    self.loginButton = [[UIButton alloc] init];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextFiled.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    self.loginButton.backgroundColor = [UIColor grayColor];
    
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    self.registButton = [[UIButton alloc] init];
    [self.view addSubview:self.registButton];
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    [self.registButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    self.registButton.backgroundColor = [UIColor grayColor];
    
    
    self.privateButton = [[UIButton alloc] init];
    [self.view addSubview:self.privateButton];
    [self.privateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registButton.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    [self.privateButton setTitle:@"隐私" forState:UIControlStateNormal];
    [self.privateButton addTarget:self action:@selector(private) forControlEvents:UIControlEventTouchUpInside];
    self.privateButton.backgroundColor = [UIColor grayColor];
}

- (void)private{
    PrivateViewController *privateVC = [[PrivateViewController alloc] init];
    [self.navigationController pushViewController:privateVC animated:YES];
}

- (void)regist{
    NSString *account = self.acountTextField.text;
    NSString *password = self.passwordTextFiled.text;
    __weak typeof(self) weakSelf = self;
    [JMSGUser registerWithUsername:account password:password completionHandler:^(id resultObject, NSError *error) {
        if (error == nil) {
            weakSelf.acountTextField.text = @"";
            weakSelf.passwordTextFiled.text = @"";
        }
    }];
}
- (void)login{
    
    NSString *account = self.acountTextField.text;
    NSString *password = self.passwordTextFiled.text;
    __weak typeof(self) weakSelf = self;
    [JMSGUser loginWithUsername:account password:password completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"login resulte = %@",resultObject);
        if (error == nil) {
            if (weakSelf.loginSucess) {
                weakSelf.loginSucess();
            }
        }
    }];
}
@end
