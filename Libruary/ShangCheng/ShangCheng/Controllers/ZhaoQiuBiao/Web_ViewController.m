//
//  Web_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/31.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Web_ViewController.h"

@interface Web_ViewController ()
@property (strong, nonatomic)UIWebView *myWebVIew;

@end

@implementation Web_ViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.isProtocal == YES) {
        self.title = @"协议";
    }else{
        self.title = @"正文";
    }
    [self.view beginLoading];
    self.myWebVIew = [[UIWebView alloc]init];
    self.myWebVIew.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.myWebVIew loadRequest:request];
    [self.view addSubview:self.myWebVIew];
    [self.myWebVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


@end
