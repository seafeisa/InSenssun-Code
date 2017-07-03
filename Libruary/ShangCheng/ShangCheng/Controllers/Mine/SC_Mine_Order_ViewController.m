//
//  SC_Mine_Order_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Mine_Order_ViewController.h"
#import "Mine_Order_cell.h"
#import "Mine_PingJia_ViewController.h"
#import "Ali_Pay_ViewController.h"
#import "Check_WuLiu_ViewController.h"

@interface SC_Mine_Order_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *data_arr;

@end

@implementation SC_Mine_Order_ViewController

- (NSMutableArray *)data_arr {
    if (_data_arr == nil) {
        _data_arr = [NSMutableArray array];
    }
    return _data_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.title = @"我的订单";
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Mine_Order_cell" bundle:nil] forCellReuseIdentifier:@"Mine_Order_cell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [self getData];
}

- (void)getData {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_Orderlist_WithId:[Login_Total curLoginUser].id andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            if (self.data_arr.count > 0) {
                [self.data_arr removeAllObjects];
            }
            NSArray *arr = [data mutableCopy];
            for (int i = 0; i < arr.count; i ++) {
                NSDictionary *dic = arr[i];
                if ([dic[@"goodsInfo"] isKindOfClass:[NSArray class]]) {
                    [self.data_arr addObject:dic];
                }
            }
            self.data_arr = [ChangeNsnull changeType:self.data_arr];
            [self.myTableView reloadData];
        }else{
            if (self.data_arr.count > 0) {
                [self.data_arr removeAllObjects];
            }
            [self.myTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data_arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 270;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.data_arr[indexPath.section][@"goodsInfo"];
    CGFloat height = 0.0;
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dic = array[i];
        CGRect rect = [dic[@"goods_desc"] boundingRectWithSize:CGSizeMake(kScreen_Width - 75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
        height = rect.size.height + height - 10 * i;
    }
    return 240 + array.count * 90 + height - 90 - 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Mine_Order_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_Order_cell"forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.order = self.data_arr[indexPath.section];
    [cell cellForOrder];
    NSArray *array = self.data_arr[indexPath.section][@"goodsInfo"];
    CGFloat height = 0.0;
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dic = array[i];
        CGRect rect = [dic[@"goods_desc"] boundingRectWithSize:CGSizeMake(kScreen_Width - 75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
        height = rect.size.height + height - 10 * i;
    }
    cell.rowHeight = height;
    NSDictionary *dic = self.data_arr[indexPath.section];
    cell.PingJia_Block = ^{
        Mine_PingJia_ViewController *vc = [[Mine_PingJia_ViewController alloc]init];
        vc.OrderID = dic[@"id"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.pay_Block = ^{
        Ali_Pay_ViewController *vc = [[Ali_Pay_ViewController alloc]init];
        vc.totalPrice = dic[@"total_price"];
        vc.Trade_No = dic[@"out_trade_no"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.delete_Block = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要删除此订单吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.view beginLoading];
            [[APPNetAPIManager sharedManager]request_delorder_WithMember_id:[Login_Total curLoginUser].id order_id:dic[@"id"] andBlock:^(id data, NSError *error) {
                [self.view endLoading];
                if (data) {
                    [self.data_arr removeAllObjects];
                    [self getData];
                }
            }];
        }];
        [alert addAction:action];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
    };
    cell.GetGoos_Block = ^{
        [self getGoosWithOrder_id:dic[@"id"]];
    };
    cell.CheckWuLiu_Block = ^{
        Check_WuLiu_ViewController *vc = [[Check_WuLiu_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        vc.trade_No = dic[@"out_trade_no"];
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

///确认收货
- (void)getGoosWithOrder_id:(NSString *)order_id {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_qrsh_WithMember_id:[Login_Total curLoginUser].id order_id:order_id andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            [self getData];
        }
    }];
}



@end
