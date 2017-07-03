//
//  PingJia_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/13.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "PingJia_ViewController.h"
#import "Ping_Jia_Cell.h"

@interface PingJia_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *data_arr;

@end

@implementation PingJia_ViewController

- (NSMutableArray *)data_arr {
    if (_data_arr == nil) {
        _data_arr = [NSMutableArray array];
    }
    return _data_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的评价";
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Ping_Jia_Cell" bundle:nil] forCellReuseIdentifier:@"Ping_Jia_Cell"];
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
    [[APPNetAPIManager sharedManager]request_mypj_WithMember_id:[Login_Total curLoginUser].id andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.data_arr = [data mutableCopy];
            self.data_arr = [ChangeNsnull changeType:self.data_arr];
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.data_arr.count > 0) {
        PingLun_MTL *pinglun = [PingLun_MTL modelObjectWithDictionary:self.data_arr[indexPath.row]];
        CGRect rect = [pinglun.content boundingRectWithSize:CGSizeMake(kScreen_Width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        return 70 + rect.size.height;
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Ping_Jia_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Ping_Jia_Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.data_arr.count > 0) {
        cell.pinglun = [PingLun_MTL modelObjectWithDictionary:self.data_arr[indexPath.row]];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    return cell;
}

@end
