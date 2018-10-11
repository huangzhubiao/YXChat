//
//  YXMainViewController.m
//  huocheng
//
//  Created by ios on 2018/8/29.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "YXMainViewController.h"
#import "YXTabBarViewController.h"
#import "UIView+Extension.h"
// 手势距离分界点为左侧栏宽度的一半
#define PanCenterlength self.leftSettingView.width*0.5
#define LeftViewWidth ScreenW*0.75
@interface YXMainViewController ()<YXTabBarViewControllerDelegate>
/** 侧边栏控制器的view */
@property (nonatomic, weak) UIView *leftSettingView;
@end

@implementation YXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 为主控制器添加子控制器
    // 1.tabbar控制器
    YXTabBarViewController *tabVc = [[YXTabBarViewController alloc] init];
    tabVc.mydelegate = self;
    [self.view addSubview:tabVc.view];
    [self addChildViewController:tabVc];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor grayColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.view.frame = CGRectMake(-LeftViewWidth, 0, LeftViewWidth, ScreenH);
    
    self.leftSettingView = vc.navigationController.view;
    // view也为父子关系
    [nav.view addSubview:vc.view];
    [self.view addSubview:nav.view];
    [self addChildViewController:nav];
    
    // 3.添加拖拽手势
    UIGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftSettingView:)];
    [self.view addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 手势操作:拉开左侧抽屉，并添加遮盖
- (void)leftSettingView:(UIPanGestureRecognizer *)recognize
{
    // 获得手势移动的点
    CGPoint translation = [recognize translationInView:self.leftSettingView];
    NSLog(@"%f", translation.x);
    // 获得当前移动的侧边 x
    CGFloat currentLeftViewX = translation.x + self.leftSettingView.x;
    if(translation.x>0){ // 向右滑
        if(currentLeftViewX>0){// && translation.x>0){
            self.leftSettingView.x = 0; // 到边界了，返回
            [self addCoverInsertBelowWithView:self.leftSettingView]; // 添加遮盖
            return;
        }
    }else if (translation.x<=0){ // 向左滑
        if(currentLeftViewX<-self.leftSettingView.width){
            self.leftSettingView.x = -LeftViewWidth;
            [self removeCoverFromCurView]; // 移除遮盖
            return;
        }
    }
    // 确定左边界滚动位置
    CGFloat leftX = self.leftSettingView.x;
    leftX += translation.x;
    self.leftSettingView.x= leftX;
    // 及时清空手势距离
    [recognize setTranslation:CGPointZero inView:recognize.view];
    // 处理回弹效果
    if(recognize.state == UIGestureRecognizerStateEnded)
    {
#warning 控制回弹的距离
        if(self.leftSettingView.x >= -PanCenterlength)
        {
            // 打开左侧栏
            [self open:YES];
            
        }else if (self.leftSettingView.x <= -PanCenterlength)
        {
            // 关闭左侧栏
            [self open:NO];
        }
    }
}

// 是否要打开左侧栏
- (void)open:(BOOL)isOpen
{
    if(isOpen){
        [self moveLeftView:0];
        // 添加遮盖
        [self addCoverInsertBelowWithView:self.leftSettingView];
    }else{
        [self moveLeftView:-LeftViewWidth];
        // 移除遮盖
        [self removeCoverFromCurView];
    }
}

- (void)moveLeftView:(CGFloat)distance
{
    [UIView animateWithDuration:0.2 animations:^{
        self.leftSettingView.x = distance;
    }];
}
// 添加遮盖
- (void)addCoverInsertBelowWithView:(UIView *)view
{
    [self.view bringSubviewToFront:view];
}
// 移除遮盖，左侧栏左对齐
- (void)removeCoverFromCurView
{
    [UIView animateWithDuration:0.1 animations:^{
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.leftSettingView.x = -LeftViewWidth;
        }];
    }];
}

#pragma mark - YLTabBarViewControllerDelegate代理方法，调出弹框
- (void)tabBarViewControllerWith:(YXTabBarViewController *)tabBarViewController
{
    // 打开左侧栏
    [self open:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
