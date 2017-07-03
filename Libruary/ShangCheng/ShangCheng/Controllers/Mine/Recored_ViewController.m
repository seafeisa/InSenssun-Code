//
//  Recored_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/5/15.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Recored_ViewController.h"
#import "Record_TableViewCell.h"
#import "Web_ViewController.h"

@interface Recored_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *data_arr;

@end

@implementation Recored_ViewController

- (NSMutableArray *)data_arr {
    if (_data_arr == nil) {
        _data_arr = [NSMutableArray array];
    }
    return _data_arr;
}

- (void)viewWillAppear:(BOOL)animated {
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的发布记录";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Record_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Record_TableViewCell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
}

- (void)getData {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_record_WithMember_id:[Login_Total curLoginUser].id andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.data_arr = [data mutableCopy];
            self.data_arr = [ChangeNsnull changeType:self.data_arr];
            [self.myTableView reloadData];
        }else{
            if (self.data_arr.count > 0) {
                [self.data_arr removeAllObjects];
                [self.myTableView reloadData];
            }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Record_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Record_TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.data_arr.count > 0) {
        cell.contentDic = self.data_arr[indexPath.row];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dic = self.data_arr[indexPath.row];
        [self.view beginLoading];
        [[APPNetAPIManager sharedManager]request_delbiao_WithId:dic[@"id"] member_id:[Login_Total curLoginUser].id andBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                [NSObject showHudTipStr:data];
                [self getData];
            }
        }];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";//默认文字为 Delete
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *zhaobiao = self.data_arr[indexPath.row];
    Web_ViewController *vc = [[Web_ViewController alloc]init];
    vc.url = zhaobiao[@"url"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
