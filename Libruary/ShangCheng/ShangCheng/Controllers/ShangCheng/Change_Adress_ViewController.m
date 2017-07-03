//
//  Change_Adress_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/19.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Change_Adress_ViewController.h"
#import "Change_Address_TableViewCell.h"

@interface Change_Adress_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;

@end

@implementation Change_Adress_ViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"收货地址";
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Change_Address_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Change_Address_TableViewCell"];
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
    Change_Address_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Change_Address_TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.change_Address_Block = ^(NSString *name, NSString *phone, NSString *address) {
        [self.view endEditing:YES];
        [self.view beginLoading];
        [[APPNetAPIManager sharedManager]request_addaddress_WithAddress:address member_id:[Login_Total curLoginUser].id name:name tel:phone andBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    };
    return cell;
}


@end
