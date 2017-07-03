//
//  SC_Zhao_Qiu_Biao_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Zhao_Qiu_Biao_ViewController.h"
#import "Zhao_Qiu_Select_Cell.h"
#import "Zhao_Qiu_Content_Cell.h"
#import "Web_ViewController.h"
#import "Send_Book_ViewController.h"
#import "SC_Login_ViewController.h"

@interface SC_Zhao_Qiu_Biao_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    BOOL isZhaoBiao;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *zhao_qiu_arr;

@end

@implementation SC_Zhao_Qiu_Biao_ViewController

- (NSMutableArray *)zhao_qiu_arr {
    if (_zhao_qiu_arr == nil) {
        _zhao_qiu_arr = [NSMutableArray array];
    }
    return _zhao_qiu_arr;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title = @"招求标";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStylePlain target:self action:@selector(message)];
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Zhao_Qiu_Select_Cell" bundle:nil] forCellReuseIdentifier:@"Zhao_Qiu_Select_Cell"];
        [tableView registerNib:[UINib nibWithNibName:@"Zhao_Qiu_Content_Cell" bundle:nil] forCellReuseIdentifier:@"Zhao_Qiu_Content_Cell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        
        tableView.tableHeaderView = [self customWithHeaderView];
        
        tableView;
    });
    
    isZhaoBiao = YES;
    
    [self.view beginLoading];
    [self getData];
}

- (void)getData {
    if (isZhaoBiao == YES) {
        [[APPNetAPIManager sharedManager]request_Zblist_WithBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                if (self.zhao_qiu_arr.count > 0) {
                    [self.zhao_qiu_arr removeAllObjects];
                }
                self.zhao_qiu_arr = [data mutableCopy];
                [self.myTableView reloadData];
            }else{
                if (self.zhao_qiu_arr.count > 0) {
                    [self.zhao_qiu_arr removeAllObjects];
                }
                [self.myTableView reloadData];
            }
        }];
    }else{
        [[APPNetAPIManager sharedManager]request_Qblist_WithBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                self.zhao_qiu_arr = [data mutableCopy];
                [self.myTableView reloadData];
            }else{
                if (self.zhao_qiu_arr.count > 0) {
                    [self.zhao_qiu_arr removeAllObjects];
                }
                [self.myTableView reloadData];
            }
        }];
    }
}

- (void)message {
    if ([Login_Total curLoginUser].id) {
        Send_Book_ViewController *vc = [[Send_Book_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        SC_Login_ViewController *vc = [[SC_Login_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (UIView *)customWithHeaderView {
    UIView *bg = [[UIView alloc]init];
    bg.frame = CGRectMake(0, 0, kScreen_Width, 150);
    bg.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"img_zhaobiao_1"];
    [bg addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bg);
    }];
    return bg;
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.zhao_qiu_arr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 40.f : 100.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40;
    }
    Zhao_Qiu_Biao *zhao = self.zhao_qiu_arr[indexPath.row - 1];
    CGRect rect = [zhao.title boundingRectWithSize:CGSizeMake(kScreen_Width - 125, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return 80 + rect.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Zhao_Qiu_Select_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Zhao_Qiu_Select_Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.zhaoBiao_Block = ^{
            isZhaoBiao = YES;
            [self.zhao_qiu_arr removeAllObjects];
            [self.view beginLoading];
            [self getData];
        };
        cell.qiuBiao_Block = ^{
            isZhaoBiao = NO;
            [self.zhao_qiu_arr removeAllObjects];
            [self.view beginLoading];
            [self getData];
        };
        return cell;
    }else{
        Zhao_Qiu_Content_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Zhao_Qiu_Content_Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.zhao_qiu_arr.count > 0) {
            cell.zhaobiao = self.zhao_qiu_arr[indexPath.row - 1];
        }
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) {
        Zhao_Qiu_Biao *zhaobiao = self.zhao_qiu_arr[indexPath.row - 1];
        Web_ViewController *vc = [[Web_ViewController alloc]init];
        vc.url = zhaobiao.url;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}


@end
