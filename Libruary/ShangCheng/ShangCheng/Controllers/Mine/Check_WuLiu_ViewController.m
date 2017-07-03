//
//  Check_WuLiu_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/25.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Check_WuLiu_ViewController.h"
#import "Check_WuLiu_TableViewCell.h"

@interface Check_WuLiu_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSDictionary *dataDic;

@end

@implementation Check_WuLiu_ViewController

- (NSDictionary *)dataDic {
    if (_dataDic == nil) {
        _dataDic = [NSDictionary dictionary];
    }
    return _dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"查看物流";
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Check_WuLiu_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Check_WuLiu_TableViewCell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
    
    [self chaKanWuLiu];
    
}

///查看物流
- (void)chaKanWuLiu {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_ckwl_WithMember_id:[Login_Total curLoginUser].id out_trade_no:self.trade_No andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.dataDic = [data mutableCopy];
            [self.myTableView reloadData];
        }
    }];
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
    Check_WuLiu_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Check_WuLiu_TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentDic = self.dataDic;
    return cell;
}

@end
