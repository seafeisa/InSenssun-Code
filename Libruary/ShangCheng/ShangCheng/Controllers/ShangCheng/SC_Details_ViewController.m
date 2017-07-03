//
//  SC_Details_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Details_ViewController.h"
#import "Details_Head_View.h"
#import "SC_Things_View.h"
#import "SC_PingJia_View.h"
#import "SC_Deatils_View.h"
#import "SC_Sure_Order_ViewController.h"
#import "SC_Login_ViewController.h"
#import "SC_Share_View.h"

@interface SC_Details_ViewController (){
    SC_PingJia_View *pingJia_view;
    SC_Things_View *things_view;
    SC_Deatils_View *details;
    SC_Share_View *shareView;
}
@property (nonatomic,strong)NSMutableDictionary *contentDic;
@end

@implementation SC_Details_ViewController

- (NSMutableDictionary *)contentDic {
    if (_contentDic == nil) {
        _contentDic = [NSMutableDictionary dictionary];
    }
    return _contentDic;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Details_Head_View *list_view = [[[NSBundle mainBundle]loadNibNamed:@"Details_Head_View" owner:nil options:nil]firstObject];
    list_view.return_block = ^{
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    };
    list_view.shangPin_block = ^{
        for (id sub in [self.view subviews]) {
            if ([sub isKindOfClass:[SC_Things_View class]] || [sub isKindOfClass:[SC_PingJia_View class]] || [sub isKindOfClass:[SC_Deatils_View class]] || [sub isKindOfClass:[SC_Share_View class]]) {
                [sub removeFromSuperview];
            }
        }
        things_view.hidden = NO;
        pingJia_view.hidden = YES;
        details.hidden = YES;
        shareView.hidden = YES;
        things_view = [[SC_Things_View alloc]init];
        [self.view beginLoading];
        [self getData];
        __weak SC_Details_ViewController *weakSelf = self;
        things_view.next_block = ^(NSDictionary *dic){
            __strong SC_Details_ViewController *strongSelf = weakSelf;
            SC_Sure_Order_ViewController *VC = [[SC_Sure_Order_ViewController alloc]init];
            VC.contentDic = dic;
            [strongSelf.navigationController pushViewController:VC animated:YES];
        };
        things_view.addCart_Block = ^{
            __strong SC_Details_ViewController *strongSelf = weakSelf;
            SC_Login_ViewController *vc = [[SC_Login_ViewController alloc]init];
            strongSelf.hidesBottomBarWhenPushed = YES;
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };
        [self.view addSubview:things_view];
        [things_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    };
    list_view.xiangQing_block = ^{
        for (id sub in [self.view subviews]) {
            if ([sub isKindOfClass:[SC_Things_View class]] || [sub isKindOfClass:[SC_PingJia_View class]] || [sub isKindOfClass:[SC_Deatils_View class]] || [sub isKindOfClass:[SC_Share_View class]]) {
                [sub removeFromSuperview];
            }
        }
        things_view.hidden = YES;
        pingJia_view.hidden = YES;
        details.hidden = NO;
        shareView.hidden = YES;
        [self getData];
        details = [[SC_Deatils_View alloc]init];
        [self.view beginLoading];
        [self.view addSubview:details];
        [details mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    };
    list_view.pingJia_block = ^{
        for (id sub in [self.view subviews]) {
            if ([sub isKindOfClass:[SC_Things_View class]] || [sub isKindOfClass:[SC_PingJia_View class]] || [sub isKindOfClass:[SC_Deatils_View class]] || [sub isKindOfClass:[SC_Share_View class]]) {
                [sub removeFromSuperview];
            }
        }
        things_view.hidden = YES;
        pingJia_view.hidden = NO;
        details.hidden = YES;
        shareView.hidden = YES;
        pingJia_view = [[SC_PingJia_View alloc]init];
        [self.view beginLoading];
        [self getData];
        [self.view addSubview:pingJia_view];
        [pingJia_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    };
    
    list_view.share_block = ^{
        for (id sub in [self.view subviews]) {
            if ([sub isKindOfClass:[SC_Things_View class]] || [sub isKindOfClass:[SC_PingJia_View class]] || [sub isKindOfClass:[SC_Deatils_View class]] || [sub isKindOfClass:[SC_Share_View class]]) {
                [sub removeFromSuperview];
            }
        }
        things_view.hidden = YES;
        pingJia_view.hidden = YES;
        details.hidden = YES;
        shareView.hidden = NO;
        shareView = [[SC_Share_View alloc]init];
        [self.view addSubview:shareView];
        [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    };
    
    [self.view addSubview:list_view];
    [list_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    things_view = [[SC_Things_View alloc]init];
    [self.view beginLoading];
    __weak SC_Details_ViewController *weakSelf = self;
    things_view.next_block = ^(NSDictionary *dic){
        __strong SC_Details_ViewController *strongSelf = weakSelf;
        SC_Sure_Order_ViewController *VC = [[SC_Sure_Order_ViewController alloc]init];
        VC.contentDic = dic;
        [strongSelf.navigationController pushViewController:VC animated:YES];
    };
    things_view.addCart_Block = ^{
        __strong SC_Details_ViewController *strongSelf = weakSelf;
        SC_Login_ViewController *vc = [[SC_Login_ViewController alloc]init];
        strongSelf.hidesBottomBarWhenPushed = YES;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:things_view];
    [things_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self getData];
}

- (void)getData {
    [[APPNetAPIManager sharedManager]request_Xqshop_WithGoods_id:self.goods_id andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            DebugLog(@"=================%@",data);
            self.contentDic = [[data mutableCopy] objectAtIndex:0];
            things_view.contentDic = self.contentDic;
            pingJia_view.contentDic = self.contentDic;
            details.contentDic = self.contentDic;
        }
    }];
}

@end
