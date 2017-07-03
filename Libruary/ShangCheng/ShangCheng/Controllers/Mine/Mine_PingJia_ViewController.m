//
//  Mine_PingJia_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Mine_PingJia_ViewController.h"
#import "Mine_PingJia_TableViewCell.h"
#import "PingJia_Content_TableViewCell.h"
#import "PingJia_Details_ViewController.h"

@interface Mine_PingJia_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *data_arr;

@end

@implementation Mine_PingJia_ViewController

- (NSMutableArray *)data_arr {
    if (_data_arr == nil) {
        _data_arr = [NSMutableArray array];
    }
    return _data_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"评论";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        //PingJia_Content_TableViewCell
        [tableView registerNib:[UINib nibWithNibName:@"PingJia_Content_TableViewCell" bundle:nil] forCellReuseIdentifier:@"PingJia_Content_TableViewCell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
    
    [self getData];
}

- (void)getData {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_gopj_WithOrder_id:self.OrderID andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            if (self.data_arr > 0) {
                [self.data_arr removeAllObjects];
            }
            self.data_arr = [data mutableCopy];
            [self.myTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data_arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.data_arr[indexPath.row];
    CGRect rect = [dic[@"goods_desc"] boundingRectWithSize:CGSizeMake(kScreen_Width - 20 - 60 - 5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    if (rect.size.height < 30) {
        return 80;
    }else{
        return 80 + rect.size.height - 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PingJia_Content_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PingJia_Content_TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentDic = self.data_arr[indexPath.row];
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.data_arr[indexPath.row];
    PingJia_Details_ViewController *vc = [[PingJia_Details_ViewController alloc]init];
    vc.goods_id = dic[@"goods_id"];
    vc.order_id = self.OrderID;
    vc.contentDic = dic;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
