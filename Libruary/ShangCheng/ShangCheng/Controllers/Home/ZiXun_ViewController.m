//
//  ZiXun_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "ZiXun_ViewController.h"
#import "More_Zixun_TableViewCell.h"
#import "Web_ViewController.h"

@interface ZiXun_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *zixun;
@end

@implementation ZiXun_ViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}
- (NSMutableArray *)zixun {
    if (_zixun == nil) {
        _zixun = [NSMutableArray array];
    }
    return _zixun;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"头条资讯";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"More_Zixun_TableViewCell" bundle:nil] forCellReuseIdentifier:@"More_Zixun_TableViewCell"];
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
    [[APPNetAPIManager sharedManager]request_titlelist_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.zixun = [data mutableCopy];
            [self.myTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.zixun.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    More_Zixun_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"More_Zixun_TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentDic = self.zixun[indexPath.row];
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.zixun[indexPath.row];
    Web_ViewController *vc = [[Web_ViewController alloc]init];
    vc.url = dic[@"url"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
