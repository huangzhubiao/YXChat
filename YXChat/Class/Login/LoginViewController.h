//
//  LoginViewController.h
//  YXChat
//
//  Created by ios on 2018/10/10.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loginSucessBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (nonatomic,copy) loginSucessBlock loginSucess;

@end

NS_ASSUME_NONNULL_END
