//
//  SC_Sure_Order_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Sure_Order_ViewController.h"
#import "Sure_Order_View.h"
#import "Order_Info_Cell.h"
#import "Order_Things_Cell.h"
#import "Order_Price_Cell.h"
#import "Order_Pay_View.h"
#import "Change_Adress_ViewController.h"
#import "Ali_Pay_ViewController.h"

@interface SC_Sure_Order_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    Order_Pay_View *order_pay_view;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *data_arr;

@end

@implementation SC_Sure_Order_ViewController

- (NSMutableArray *)data_arr {
    if (_data_arr == nil) {
        _data_arr = [NSMutableArray array];
    }
    return _data_arr;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tabBarController.tabBar.hidden = YES;
    
    [self getData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Sure_Order_View *list_view = [[[NSBundle mainBundle]loadNibNamed:@"Sure_Order_View" owner:nil options:nil]firstObject];
    list_view.return_block = ^{
        if (self.updata_Block) {
            self.updata_Block();
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:list_view];
    [list_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(60);
    }];
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];

        //Order_Price_Cell
        [tableView registerNib:[UINib nibWithNibName:@"Order_Price_Cell" bundle:nil] forCellReuseIdentifier:@"Order_Price_Cell"];
        [tableView registerNib:[UINib nibWithNibName:@"Order_Things_Cell" bundle:nil] forCellReuseIdentifier:@"Order_Things_Cell"];
        [tableView registerNib:[UINib nibWithNibName:@"Order_Info_Cell" bundle:nil] forCellReuseIdentifier:@"Order_Info_Cell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(70);
            make.bottom.mas_equalTo(0);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
    [self addFootView];
}

- (void)getData {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_cxaddress_WithMember_id:[Login_Total curLoginUser].id andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.data_arr = [data mutableCopy];
            [self.myTableView reloadData];
        }
    }];
}

- (void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    [self.myTableView reloadData];
}

- (void)addFootView {
    order_pay_view = [[[NSBundle mainBundle]loadNibNamed:@"Order_Pay_View" owner:nil options:nil]firstObject];
    order_pay_view.contentDic = self.contentDic;
    __weak SC_Sure_Order_ViewController *weakSelf = self;
    order_pay_view.pay_Block = ^(NSString *totalPrice){
        if (self.data_arr.count == 0) {
            [NSObject showHudTipStr:@"请添加收获地址"];
            return;
        }
        __strong SC_Sure_Order_ViewController *strongSelf = weakSelf;
        Ali_Pay_ViewController *vc = [[Ali_Pay_ViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.Trade_No = strongSelf.contentDic[@"data"][@"out_trade_no"];
        vc.totalPrice = totalPrice;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [self.view addSubview:order_pay_view];
    [order_pay_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return [self.contentDic[@"goodsInfo"] count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 100;
    }else if (indexPath.section == 0){
        if (self.data_arr.count > 0) {
            NSDictionary *dic = self.data_arr[0];
            CGRect rect = [dic[@"shr_address"] boundingRectWithSize:CGSizeMake(kScreen_Width - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            return 50 + rect.size.height;
        }else{
            return 50;
        }
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 100;
    }else if (indexPath.section == 0){
        if (self.data_arr.count > 0) {
            return 70;
        }else{
            return 50;
        }
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.data_arr.count > 0) {
            Order_Info_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Order_Info_Cell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.contentDic = self.data_arr[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            cell.textLabel.text = @"去设置收货地址";
            return cell;
        }
    }else if (indexPath.section == 1) {
        Order_Things_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Order_Things_Cell" forIndexPath:indexPath];
        if (self.contentDic) {
            cell.dataDic = self.contentDic[@"data"];
            cell.contentDic = self.contentDic[@"goodsInfo"][indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
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
        if (self.contentDic) {
            if (indexPath.section == 2) {
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.text = @"订单编号";
                cell.detailTextLabel.text = self.contentDic[@"data"][@"out_trade_no"];
            }
            if (indexPath.section == 3) {
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.text = @"生成时间";
                cell.detailTextLabel.text = self.contentDic[@"data"][@"addtime"];
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Change_Adress_ViewController *vc = [[Change_Adress_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
