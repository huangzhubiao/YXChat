//
//  YXTabBarViewController.m
//  huocheng
//
//  Created by ios on 2018/8/29.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "YXTabBarViewController.h"
#import "YXNavViewController.h"
#import "YXHomeViewController.h"
#import "FriendViewController.h"
#import "MineViewController.h"
#import "HBDNavigationController.h"

@interface YXTabBarViewController ()

@end

@implementation YXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initChildViewControllers{
    YXHomeViewController *vc1 = [[YXHomeViewController alloc] init];
    vc1.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:vc1 Title:@"会话" NorImageName:@"" SelectImageName:@""];
    FriendViewController *vc2 = [[FriendViewController alloc] init];
    vc2.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addChildViewController:vc2 Title:@"好友" NorImageName:@"" SelectImageName:@""];
    
    MineViewController *vc3 = [[MineViewController alloc] init];
    vc3.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addChildViewController:vc3 Title:@"我的" NorImageName:@"" SelectImageName:@""];
}

- (void)addChildViewController:(UIViewController *)vc Title:(NSString *)title NorImageName:(NSString *)norImageName SelectImageName:(NSString *)selectImageName{
    vc.title = title;
    
    // 为每个控制器添加一个左上角按钮
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setImage:[UIImage imageNamed:@"home_drawer_entrance"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"shared_listbuttom_highlighted"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonItem) forControlEvents:UIControlEventTouchUpInside];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    HBDNavigationController *navVc = [[HBDNavigationController alloc] initWithRootViewController:vc];
    navVc.tabBarItem.title = title;
    [self addChildViewController:navVc];
}

- (void)leftButtonItem{
    if ([self.mydelegate respondsToSelector:@selector(tabBarViewControllerWith:)]) {
        [self.mydelegate tabBarViewControllerWith:self];
    }
}
@end
