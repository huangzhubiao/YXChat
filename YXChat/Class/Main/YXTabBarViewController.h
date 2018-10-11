//
//  YXTabBarViewController.h
//  huocheng
//
//  Created by ios on 2018/8/29.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXTabBarViewController;

@protocol YXTabBarViewControllerDelegate <UITabBarControllerDelegate>
@optional
/** 利用代理让Main控制器调弹框 */
- (void)tabBarViewControllerWith:(YXTabBarViewController *)tabBarViewController;

@end

@interface YXTabBarViewController : UITabBarController
@property(nonatomic, weak) id<YXTabBarViewControllerDelegate> mydelegate;
@end
