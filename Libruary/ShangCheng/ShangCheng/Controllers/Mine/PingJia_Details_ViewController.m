//
//  PingJia_Details_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/18.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "PingJia_Details_ViewController.h"
#import "Mine_PingJia_TableViewCell.h"

@interface PingJia_Details_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;

@end

@implementation PingJia_Details_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"评价";
    
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Mine_PingJia_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Mine_PingJia_TableViewCell"];
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
    return kScreen_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Mine_PingJia_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_PingJia_TableViewCell"];
    cell.contentDic = self.contentDic;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.pingJia_Block = ^(NSString *str) {
        [self.view beginLoading];
        [[APPNetAPIManager sharedManager]request_pjgoods_WithMember_id:[Login_Total curLoginUser].id goods_id:self.goods_id content:str order_id:self.order_id andBlock:^(id data, NSError *error) {
            if (data) {
                [self.view endLoading];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    };
    return cell;
}


@end
