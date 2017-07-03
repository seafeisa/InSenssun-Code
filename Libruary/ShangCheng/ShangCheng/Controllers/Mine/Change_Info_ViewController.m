//
//  Change_Info_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Change_Info_ViewController.h"
#import "Change_Info_TableViewCell.h"

@interface Change_Info_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSString *tempInfo;
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;

@end

@implementation Change_Info_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改昵称";
    
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Change_Info_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Change_Info_TableViewCell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
    
    tempInfo = @"";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
}

- (void)save {
    if ([tempInfo isEqualToString:@""]) {
        [NSObject showHudTipStr:@"昵称不能为空"];
        return;
    }
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_changename_WithId:[Login_Total curLoginUser].id name:tempInfo andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            [Login_Total changeNickname:data[0][@"nicheng"]];
            if (self.get_info_Block) {
                self.get_info_Block(data[0][@"nicheng"]);
            }
            [self.navigationController popViewControllerAnimated:YES];
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
    return kScreen_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Change_Info_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Change_Info_TableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.change_name_Block = ^(NSString *info) {
        tempInfo = info;
    };
    return cell;
}

@end
