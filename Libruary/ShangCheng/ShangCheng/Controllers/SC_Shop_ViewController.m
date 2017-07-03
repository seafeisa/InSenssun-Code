//
//  SC_Shop_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Shop_ViewController.h"
#import "SC_Select_ViewController.h"
#import "Index_Head_View.h"
#import "Device_TableViewCell.h"
#import "Recomend_TableViewCell.h"
#import "SC_Details_ViewController.h"
#import "LoveGoos_TableViewCell.h"
#import "ShangJia_Details_ViewController.h"
#import "LZCartViewController.h"
#import "SC_Login_ViewController.h"
#import "Search_Shop_ViewController.h"
#import "Hot_Shop_ViewController.h"

@interface SC_Shop_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    Index_Head_View *list_view;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *xsbuy_arr;
@property (nonatomic,strong)NSMutableArray *device_arr;
@property (nonatomic,strong)NSMutableArray *tuijian_arr;
@property (nonatomic,strong)NSMutableArray *loveGoods_arr;
@end

@implementation SC_Shop_ViewController

- (NSMutableArray *)loveGoods_arr {
    if (_loveGoods_arr == nil) {
        _loveGoods_arr = [NSMutableArray array];
    }
    return _loveGoods_arr;
}

- (NSMutableArray *)xsbuy_arr {
    if (_xsbuy_arr == nil) {
        _xsbuy_arr = [NSMutableArray array];
    }
    return _xsbuy_arr;
}

- (NSMutableArray *)device_arr {
    if (_device_arr == nil) {
        _device_arr = [NSMutableArray array];
    }
    return _device_arr;
}

- (NSMutableArray *)tuijian_arr {
    if (_tuijian_arr == nil) {
        _tuijian_arr = [NSMutableArray array];
    }
    return _tuijian_arr;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Device_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Device_TableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"Recomend_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Recomend_TableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"Index_Like_Cell" bundle:nil] forCellReuseIdentifier:@"Index_Like_Cell"];
        [tableView registerNib:[UINib nibWithNibName:@"Index_Shop_Cell" bundle:nil] forCellReuseIdentifier:@"Index_Shop_Cell"];
        [tableView registerNib:[UINib nibWithNibName:@"LoveGoos_TableViewCell" bundle:nil] forCellReuseIdentifier:@"LoveGoos_TableViewCell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(-20);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        tableView.tableHeaderView = [self addHeaderView];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
    [self getData];
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
    }];
    //进入就进行一次刷新
//    [self.myTableView.mj_header beginRefreshing];
    
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.myTableView.mj_header endRefreshing];
    });
}

- (void)getData {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_Sjshowimg_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            list_view.img_arr = [data mutableCopy];
        }
    }];
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_lovegoods_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.loveGoods_arr = [data mutableCopy];
            //一个section刷新
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            //你需要更新的组数
            [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_Showgoods_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            NSArray *array = [data mutableCopy];
            for (int i = 0; i < array.count; i ++) {
                NSDictionary *dic = array[i];
                if ([dic[@"goodsInfo"] isKindOfClass:[NSArray class]]) {
                    [self.device_arr addObject:dic];
                }
            }
            //一个section刷新
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            //你需要更新的组数
            [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//            [self.myTableView reloadData];
        }
    }];
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_Tuijian_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.tuijian_arr = [data mutableCopy];
            //一个section刷新
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            //你需要更新的组数
            [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//            [self.myTableView reloadData];
        }
    }];
}

- (UIView *)addHeaderView {
    UIView *bg = [[UIView alloc]init];
    bg.frame = CGRectMake(0, 0, kScreen_Width, 200);
    self.myTableView.tableHeaderView = bg;
    list_view = [[[NSBundle mainBundle]loadNibNamed:@"Index_Head_View" owner:nil options:nil]firstObject];
    __weak SC_Shop_ViewController *weakSelf = self;
    list_view.nextPage_Block = ^{
        __strong SC_Shop_ViewController *strongSelf = weakSelf;
        Search_Shop_ViewController *VC = [[Search_Shop_ViewController alloc]init];
        strongSelf.navigationController.hidesBottomBarWhenPushed = YES;
        [strongSelf.navigationController pushViewController:VC animated:YES];
        strongSelf.navigationController.hidesBottomBarWhenPushed = NO;
    };
    __weak Index_Head_View *weakView = list_view;
    list_view.url_Block = ^(NSInteger index) {
        __strong Index_Head_View *strongView = weakView;
        __strong SC_Shop_ViewController *strongSelf = weakSelf;
        NSDictionary *dic = strongView.img_arr[index];
        NSString *ID = @"";
        if ([dic[@"type_id"] isEqualToString:@"6"]) {
            ID = dic[@"goods_id"];
            SC_Details_ViewController *vc = [[SC_Details_ViewController alloc]init];
            vc.goods_id = ID;
            strongSelf.hidesBottomBarWhenPushed = YES;
            [strongSelf.navigationController pushViewController:vc animated:YES];
            strongSelf.hidesBottomBarWhenPushed = NO;
        }else if ([dic[@"type_id"] isEqualToString:@"5"]){
            ID = dic[@"shangjia_id"];
            ShangJia_Details_ViewController *vc = [[ShangJia_Details_ViewController alloc]init];
            vc.shop_id = ID;
            strongSelf.hidesBottomBarWhenPushed = YES;
            [strongSelf.navigationController pushViewController:vc animated:YES];
            strongSelf.hidesBottomBarWhenPushed = NO;
        }
    };
    list_view.shopCart_Block = ^{
        __strong SC_Shop_ViewController *strongSelf = weakSelf;
        if ([Login_Total curLoginUser].id) {
            LZCartViewController *VC = [[LZCartViewController alloc]init];
            strongSelf.hidesBottomBarWhenPushed = YES;
            [strongSelf.navigationController pushViewController:VC animated:YES];
            strongSelf.hidesBottomBarWhenPushed = NO;
        }else{
            SC_Login_ViewController *vc = [[SC_Login_ViewController alloc]init];
            strongSelf.hidesBottomBarWhenPushed = YES;
            [strongSelf.navigationController pushViewController:vc animated:YES];
            strongSelf.hidesBottomBarWhenPushed = NO;
        }
    };
    
    [bg addSubview:list_view];
    [list_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreen_Width);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    return bg;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 44) {
        list_view.my_head_view.backgroundColor = MainColor;
        [self.view addSubview:list_view.my_head_view];
        [list_view.my_head_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(64);
        }];
    }else{
        list_view.my_head_view.backgroundColor = [UIColor colorWithDisplayP3Red:0 green:0 blue:0 alpha:0.5];
    }
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.device_arr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 205;
    }else if (indexPath.section == 2){
        return 40 + 220 * (self.tuijian_arr.count / 2);
    }else if (indexPath.section == 0){
        return 20 + 100 * (self.loveGoods_arr.count / 2);
    }
    return 290;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        Recomend_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Recomend_TableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.goos_arr = self.tuijian_arr;
        cell.shop_details_Block = ^(NSString *goos_id) {
            SC_Details_ViewController *vc = [[SC_Details_ViewController alloc]init];
            vc.goods_id = goos_id;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        };
        cell.more_button = ^{
            Hot_Shop_ViewController *vc = [[Hot_Shop_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        };
        return cell;
    }
    if (indexPath.section == 0) {
        LoveGoos_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoveGoos_TableViewCell" forIndexPath:indexPath];
        cell.contentArray = self.loveGoods_arr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.details_Block = ^(NSString *ID,NSString *type) {
            if ([type isEqualToString:@"6"]) {
                SC_Details_ViewController *vc = [[SC_Details_ViewController alloc]init];
                vc.goods_id = ID;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if ([type isEqualToString:@"5"]){
                ShangJia_Details_ViewController *vc = [[ShangJia_Details_ViewController alloc]init];
                vc.shop_id = ID;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        };
        return cell;
    }
    Device_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Device_TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (id sub in [cell subviews]) {
        if ([sub isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)sub;
            if (label.tag == 101) {
                [label removeFromSuperview];
            }
        }
    }
    UILabel *line_label = [[UILabel alloc]init];
    line_label.tag = 101;
    [cell addSubview:line_label];
    line_label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [line_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(5);
    }];
    
    if (self.device_arr.count > 0) {
        cell.device_arr = self.device_arr[indexPath.row][@"goodsInfo"];
        cell.name = self.device_arr[indexPath.row][@"cat_name"];
    }
    cell.more_button = ^{
        Hot_Shop_ViewController *vc = [[Hot_Shop_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    };
    cell.shop_details_Block = ^(NSString *goos_id) {
        SC_Details_ViewController *vc = [[SC_Details_ViewController alloc]init];
        vc.goods_id = goos_id;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}



@end
