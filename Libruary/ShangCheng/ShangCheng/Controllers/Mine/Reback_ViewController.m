//
//  Reback_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/6/8.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Reback_ViewController.h"
#import "Reback_TableViewCell.h"

@interface Reback_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation Reback_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的反馈";
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.backgroundColor = [UIColor whiteColor];
        
        [tableView registerNib:[UINib nibWithNibName:@"Reback_TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Reback_TableViewCell"];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
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
    Reback_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reback_TableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.reback_blcok = ^(NSString *tips, NSString *phone, NSString *name) {
        [self.view beginLoading];
        [[APPNetAPIManager sharedManager]request_userfk_WithContent:tips member_id:[Login_Total curLoginUser].id name:name tel:phone andBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                [NSObject showHudTipStr:data];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    };
    return cell;
}

@end
