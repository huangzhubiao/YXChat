//
//  PrivateViewController.m
//  YXChat
//
//  Created by ios on 2018/10/12.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "PrivateViewController.h"
#import "masonry.h"

@interface PrivateViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation PrivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    NSURL *url = [NSURL URLWithString:@"http://blog.sina.com.cn/s/blog_c12e50d90102xzgc.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //加载网页
    [self.webView loadRequest:request];
    
    //设置代理
    self.webView.delegate = self;
}

@end
