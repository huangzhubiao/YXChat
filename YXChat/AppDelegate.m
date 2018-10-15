//
//  AppDelegate.m
//  YXChat
//
//  Created by ios on 2018/9/28.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "AppDelegate.h"
#import "YXMainViewController.h"
#import "YXTabBarViewController.h"
#import <JMessage/JMessage.h>
#import "LoginViewController.h"
#import "YXVerificationinfo.h"
#import "HBDNavigationController.h"
#define JMAPPKEY @"e265219c22d7b8e0f1775d96"
@interface AppDelegate ()<JMessageDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [self initNotification];
    
//    YXMainViewController *mainVC = [[YXMainViewController alloc] init];
    [JMessage setupJMessage:launchOptions appKey:JMAPPKEY channel:nil apsForProduction:true category:nil messageRoaming:true];
    [self setupJmessage];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    HBDNavigationController *navVc = [[HBDNavigationController alloc] initWithRootViewController:loginVC];
    navVc.tabBarItem.title = @"denglu";
    __weak typeof(self) weakSelf = self;
    loginVC.loginSucess = ^{
        [weakSelf loginSuccess];
    };
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = navVc;
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)initNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logouNotification) name:@"logoutNotification" object:nil];
}

- (void)logouNotification{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    loginVC.loginSucess = ^{
        [weakSelf loginSuccess];
    };
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = loginVC;
    [_window makeKeyAndVisible];
}

- (void)loginSuccess{
    YXTabBarViewController *tabVc = [[YXTabBarViewController alloc] init];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = tabVc;
    [_window makeKeyAndVisible];
}
- (void)setupJmessage{
    [JMessage addDelegate:self withConversation:nil];
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
         [JMessage registerForRemoteNotificationTypes:UIUserNotificationTypeBadge
         |UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
     }else{
         [JMessage registerForRemoteNotificationTypes:UIUserNotificationTypeBadge
          |UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
     }
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required - 注册token
    [JMessage registerDeviceToken:deviceToken];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark --JMessageDelegate
- (void)onReceiveNotificationEvent:(JMSGNotificationEvent *)event{
    switch (event.eventType) {
        case kJMSGEventNotificationReceiveFriendInvitation:{
            JMSGFriendNotificationEvent *friendEvent = (JMSGFriendNotificationEvent *)event;
            JMSGUser *user = friendEvent.getFromUser;
            NSString *resaon = friendEvent.getReason;
            NSLog(@"resaon = %@ username = %@",resaon,user.username);
            YXVerificationInfo *info = [[YXVerificationInfo alloc] init];
            info.ID = user.uid;
            info.username = user.username;
            info.nickname = user.nickname;
            info.appkey = user.appKey;
            info.reason = resaon;
            info.state = 0;
            YXVerificationInfoManager *infoManager = [YXVerificationInfoManager shareInstance];
            [infoManager creatDataBaseWithName:@"info"];
            [infoManager insertUser:info];
            
        }
            
            break;
            
        default:
            break;
    }
}

@end
