//
//  SC_Mine_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Mine_ViewController.h"
#import "Mine_Head_Cell.h"
#import "SC_Mine_Order_ViewController.h"
#import "Mine_Things_ViewController.h"
#import "Mine_Account_ViewController.h"
#import "SC_Login_ViewController.h"
#import "LZCartViewController.h"
#import "WaitMoney_ViewController.h"
#import "PingJia_ViewController.h"
#import "Recored_ViewController.h"
#import "Share_ViewController.h"
#import "Reback_ViewController.h"


@interface SC_Mine_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSString *tempUrl;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSArray *title_arr;
@property (nonatomic,strong)NSArray *image_arr;

@end

@implementation SC_Mine_ViewController

- (NSArray *)title_arr {
    if (!_title_arr) {
        _title_arr = @[@"我的订单",@"我的购物车",@"待付款",@"待收货",@"我的评价",@"我的发布记录",@"我的反馈"];
    }
    return _title_arr;
}

- (NSArray *)image_arr {
    if (!_image_arr) {
        _image_arr = @[@"my_dingdan",@"my_shoppingcart",@"my_daifukuan",@"my_daishouhuo",@"my_pingjia",@"my_pingjia",@"my_pingjia"];
    }
    return _image_arr;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.myTableView reloadData];
    [self getUrl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    self.title = @"我的";
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Mine_Head_Cell" bundle:nil] forCellReuseIdentifier:@"Mine_Head_Cell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
    
    tempUrl = @"";
}

- (void)getUrl {
    [[APPNetAPIManager sharedManager]request_ishare_WithBlock:^(id data, NSError *error) {
        if (data) {
            tempUrl = [data stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            tempUrl = [tempUrl stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        }
    }];
}

- (void)setting {
    Share_ViewController *vc= [[Share_ViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.title_arr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 100.f : 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Mine_Head_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_Head_Cell"];
        cell.iconImage = [Login_Total curLoginUser].touxiang;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accountSet_Block = ^{
            Mine_Account_ViewController *vc = [[Mine_Account_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        };
        cell.login_Block = ^{
            SC_Login_ViewController *vc = [[SC_Login_ViewController alloc]init];
            vc.login_Block = ^{
                [self.myTableView reloadData];
            };
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        };
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = [UIColor hexStringToColor:@"#eeeeee"];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    cell.textLabel.text = self.title_arr[indexPath.row - 1];
    cell.imageView.image = [UIImage imageNamed:self.image_arr[indexPath.row - 1]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([Login_Total curLoginUser].id) {
        if (indexPath.row == 1) {
            SC_Mine_Order_ViewController *VC = [[SC_Mine_Order_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        if (indexPath.row == 2) {
            LZCartViewController *VC = [[LZCartViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        if (indexPath.row == 4) {
            Mine_Things_ViewController *VC = [[Mine_Things_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        if (indexPath.row == 3) {
            WaitMoney_ViewController *VC = [[WaitMoney_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        if (indexPath.row == 5) {
            PingJia_ViewController *VC = [[PingJia_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        if (indexPath.row == 6) {
            Recored_ViewController *VC = [[Recored_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        if (indexPath.row == 7) {
            Reback_ViewController *VC = [[Reback_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }else{
        SC_Login_ViewController *vc = [[SC_Login_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}



@end
