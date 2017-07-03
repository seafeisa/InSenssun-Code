//
//  Ali_Pay_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/18.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Ali_Pay_ViewController.h"
#import "Order_pay_TableViewCell.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface Ali_Pay_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation Ali_Pay_ViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择支付方式";
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Order_pay_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Order_pay_TableViewCell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
    
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreen_Height - 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Order_pay_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Order_pay_TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell cellForPay];
    cell.sure_pay_Block = ^(BOOL isWechat) {
        if (isWechat == YES) {
            [self.view beginLoading];
            [[APPNetAPIManager sharedManager]request_wxPay_WithTotal_price:self.totalPrice out_trade_no:self.Trade_No sj_money:@"" andBlock:^(id data, NSError *error) {
                [self.view endLoading];
                DebugLog(@"================%@",data);
                if (data) {
                    [self wechatPayWithDictionary:data[@"app_response"]];
                }
            }];
        }else{
            [self.view beginLoading];
            [[APPNetAPIManager sharedManager]request_alipaySign_WithTotal_price:self.totalPrice out_trade_no:self.Trade_No sj_money:@"" andBlock:^(id data, NSError *error) {
                [self.view endLoading];
                if (data) {
                    NSString *ordering = data;
                    if ([ordering isEqualToString:@"null"] || [ordering isEqualToString:@""] || ordering.length == 0) {
                        [NSObject showHudTipStr:@"请检查您的网络"];
                    }else if (ordering.length < 50){
                        [NSObject showHudTipStr:ordering];
                    }else{
                        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
                        NSString *appScheme = @"tongxin";
                        ordering = [ordering stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                        [[AlipaySDK defaultService] payOrder:ordering fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                            NSLog(@"支付结果 reslut = %@",resultDic);
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }
                }
            }];
        }
    };
    return cell;
}

- (void)wechatPayWithDictionary:(NSDictionary *)data{
    PayReq *request = [[PayReq alloc] init];
    /** 商家向财付通申请的商家id */
    request.partnerId = data[@"partnerid"];
    /** 预支付订单 */
    request.prepayId= data[@"prepayid"];
    /** 商家根据财付通文档填写的数据和签名 */
    request.package = data[@"package"];
    /** 随机串，防重发 */
    request.nonceStr= data[@"noncestr"];
    /** 时间戳，防重发 */
    request.timeStamp= [data[@"timestamp"] intValue];
    /** 商家根据微信开放平台文档对数据做的签名 */
    request.sign= data[@"sign"];
    /*! @brief 发送请求到微信，等待微信返回onResp
     *
     * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
     * SendAuthReq、SendMessageToWXReq、PayReq等。
     * @param req 具体的发送请求，在调用函数后，请自己释放。
     * @return 成功返回YES，失败返回NO。
     */
    [WXApi sendReq: request];
}



@end
