//
//  SC_Home_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Home_ViewController.h"
#import "SC_Select_ViewController.h"
#import "Home_Head_View.h"
#import "Home_Shop_Cell.h"

#import "Seller_HotShop.h"
#import "Home_ZhaoBiao_TableViewCell.h"
#import "ZhaoBiao_Content_TableViewCell.h"
#import "Home_ZhaoBiao.h"
#import "YouZhiShop_TableViewCell.h"
#import "ZiXun_TableViewCell.h"
#import "TuiJian_TableViewCell.h"
#import "Web_ViewController.h"
#import "ZiXun_ViewController.h"
#import "SC_Select_ViewController.h"
#import "SC_Details_ViewController.h"
#import "ShangJia_Details_ViewController.h"
#import "Hot_Shop_ViewController.h"
#import "Search_ViewController.h"
#import "SC_Zhao_Qiu_Biao_ViewController.h"
#import "SC_Shop_Host_ViewController.h"


@interface SC_Home_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    Home_Head_View *list_view;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *hotShop;
@property (nonatomic,strong)NSMutableArray *zhaobiao;
@property (nonatomic,strong)NSMutableArray *youzhiShop;
@property (nonatomic,strong)NSMutableArray *zixun;
@property (nonatomic,strong)NSMutableArray *tuijian;
@property (nonatomic,strong)NSMutableArray *top_image;
@property (nonatomic,strong)NSMutableArray *bottom_image;
@property (nonatomic,strong)NSMutableArray *cycle_arr;
@end

@implementation SC_Home_ViewController

- (NSMutableArray *)cycle_arr {
    if (_cycle_arr == nil) {
        _cycle_arr = [NSMutableArray array];
    }
    return _cycle_arr;
}

- (NSMutableArray *)hotShop {
    if (_hotShop == nil) {
        _hotShop = [NSMutableArray array];
    }
    return _hotShop;
}

- (NSMutableArray *)zhaobiao {
    if (_zhaobiao == nil) {
        _zhaobiao = [NSMutableArray array];
    }
    return _zhaobiao;
}

- (NSMutableArray *)youzhiShop {
    if (_youzhiShop == nil) {
        _youzhiShop = [NSMutableArray array];
    }
    return _youzhiShop;
}

- (NSMutableArray *)zixun {
    if (_zixun == nil) {
        _zixun = [NSMutableArray array];
    }
    return _zixun;
}
- (NSMutableArray *)tuijian {
    if (_tuijian == nil) {
        _tuijian = [NSMutableArray array];
    }
    return _tuijian;
}
- (NSMutableArray *)top_image {
    if (_top_image == nil) {
        _top_image = [NSMutableArray array];
    }
    return _top_image;
}
- (NSMutableArray *)bottom_image {
    if (_bottom_image == nil) {
        _bottom_image = [NSMutableArray array];
    }
    return _bottom_image;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
        //Home_ZhaoBiao_TableViewCell
        [tableView registerNib:[UINib nibWithNibName:@"Home_Shop_Cell" bundle:nil] forCellReuseIdentifier:@"Home_Shop_Cell"];
        [tableView registerNib:[UINib nibWithNibName:@"Home_ZhaoBiao_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Home_ZhaoBiao_TableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ZhaoBiao_Content_TableViewCell" bundle:nil] forCellReuseIdentifier:@"ZhaoBiao_Content_TableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"YouZhiShop_TableViewCell" bundle:nil] forCellReuseIdentifier:@"YouZhiShop_TableViewCell"];
        //ZiXun_TableViewCell
        [tableView registerNib:[UINib nibWithNibName:@"ZiXun_TableViewCell" bundle:nil] forCellReuseIdentifier:@"ZiXun_TableViewCell"];
        //TuiJian_TableViewCell
        [tableView registerNib:[UINib nibWithNibName:@"TuiJian_TableViewCell" bundle:nil] forCellReuseIdentifier:@"TuiJian_TableViewCell"];
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

- (void)getData{
    [self.view beginLoading];
    NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"];
    if ([Login_Total curLoginUser].id) {
        [[APPNetAPIManager sharedManager]request_Login_WithPhone:[Login_Total curLoginUser].phone WithPwd:pwd andBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                DebugLog(@"====%@",data);
            }
        }];
    }
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_Syshowimg_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.cycle_arr = [data mutableCopy];
            list_view.img_arr = self.cycle_arr;
        }
    }];
    
    [[APPNetAPIManager sharedManager]request_Gettitle_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            if (self.zixun.count > 0) {
                [self.zixun removeAllObjects];
            }
            self.zixun = [data mutableCopy];
            //一个section刷新
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            //你需要更新的组数
            [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//            [self.myTableView reloadData];
        }
    }];
    [[APPNetAPIManager sharedManager]request_Gethot_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.hotShop = [data mutableCopy];
            //一个section刷新
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            //你需要更新的组数
            [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//            [self.myTableView reloadData];
        }
    }];
    [[APPNetAPIManager sharedManager]request_Getbiao_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.zhaobiao = [data mutableCopy];
            //一个section刷新
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            //你需要更新的组数
            [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    
    [[APPNetAPIManager sharedManager]request_Getshop_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.youzhiShop = [data mutableCopy];
            
            DebugLog(@"++++++++++++++++++++%@",self.youzhiShop);
            
            //一个section刷新
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
            //你需要更新的组数
            [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    
    [[APPNetAPIManager sharedManager]request_Getad_WithAd_weizhi:@"" andBlock:^(id data, NSError *error) {
        if (data) {
            for (int i = 0; i < 5; i ++) {
                NSDictionary *dic = data[i];
                [self.tuijian addObject:dic];
                if (i == 5) {
                    return;
                }
            }
            [self.top_image addObject:[self.tuijian firstObject]];
            [self.bottom_image addObject:[self.tuijian lastObject]];
            [self.tuijian removeObject:[self.tuijian firstObject]];
            [self.tuijian removeObject:[self.tuijian lastObject]];
            //一个section刷新
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:4];
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
    list_view = [[[NSBundle mainBundle]loadNibNamed:@"Home_Head_View" owner:nil options:nil]firstObject];
    __weak SC_Home_ViewController *weakSelf = self;
    list_view.nextPage_Block = ^{
        __strong SC_Home_ViewController *strongSelf = weakSelf;
        Search_ViewController *VC = [[Search_ViewController alloc]init];
        strongSelf.navigationController.hidesBottomBarWhenPushed = YES;
        [strongSelf.navigationController pushViewController:VC animated:YES];
        strongSelf.navigationController.hidesBottomBarWhenPushed = NO;
    };
    list_view.url_Block = ^(NSInteger index) {
        __strong SC_Home_ViewController *strongSelf = weakSelf;
        NSDictionary *dic = strongSelf.cycle_arr[index];
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.zhaobiao.count + 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 40;
    }else if (indexPath.section == 1) {
        return 170;
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 40;
        }
        return 80;
    }else if (indexPath.section == 3) {
        if (self.youzhiShop.count % 2 == 0) {
            return 40 + (self.youzhiShop.count / 2) * 80 + 10;
        }else{
            return 40 + ((self.youzhiShop.count + 1) / 2) * 80 + 10;
        }
    }
    return 360 + 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZiXun_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZiXun_TableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.zixun.count > 0) {
            cell.nameArr = self.zixun;
        }
        cell.moreButton_Block = ^{
            ZiXun_ViewController *vc = [[ZiXun_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        };
        cell.getID_Block = ^(NSString *url) {
            Web_ViewController *vc = [[Web_ViewController alloc]init];
            vc.url = url;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        };
        return cell;
    }
    Home_Shop_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Home_Shop_Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        cell.hotArr = self.hotShop;
        cell.more_button_block = ^{
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
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            Home_ZhaoBiao_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Home_ZhaoBiao_TableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.more_Block = ^{
                SC_Zhao_Qiu_Biao_ViewController *vc = [[SC_Zhao_Qiu_Biao_ViewController alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            };
            return cell;
        }
        ZhaoBiao_Content_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZhaoBiao_Content_TableViewCell" forIndexPath:indexPath];
        cell.zhaoBiao = self.zhaobiao[indexPath.row - 1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        return cell;
    }
    if (indexPath.section == 3) {
        YouZhiShop_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouZhiShop_TableViewCell"];
        cell.youzhiArr = self.youzhiShop;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shop_details_Block = ^(NSString *shop_id) {
            ShangJia_Details_ViewController *vc = [[ShangJia_Details_ViewController alloc]init];
            vc.shop_id = shop_id;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        };
        cell.more_Block = ^{
            SC_Shop_Host_ViewController *vc = [[SC_Shop_Host_ViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        };
        return cell;
    }
    if (indexPath.section == 4) {
        TuiJian_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TuiJian_TableViewCell" forIndexPath:indexPath];
        if (self.tuijian.count > 0) {
            cell.center_arr = self.tuijian;
        }
        if (self.top_image.count > 0) {
            cell.top_imageName = self.top_image[0][@"pic"];
        }
        if (self.bottom_image.count > 0) {
            cell.bottom_imageName = self.bottom_image[0][@"pic"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.TopDetails_Block = ^{
            NSDictionary *dic = self.top_image[0];
            NSString *ID = @"";
            if ([dic[@"type_id"] isEqualToString:@"6"]) {
                ID = dic[@"goods_id"];
                SC_Details_ViewController *vc = [[SC_Details_ViewController alloc]init];
                vc.goods_id = ID;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if ([dic[@"type_id"] isEqualToString:@"5"]){
                ID = dic[@"shangjia_id"];
                ShangJia_Details_ViewController *vc = [[ShangJia_Details_ViewController alloc]init];
                vc.shop_id = ID;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        };
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
        cell.BottomDetails_Block = ^{
            NSDictionary *dic = self.bottom_image[0];
            NSString *ID = @"";
            if ([dic[@"type_id"] isEqualToString:@"6"]) {
                ID = dic[@"goods_id"];
                SC_Details_ViewController *vc = [[SC_Details_ViewController alloc]init];
                vc.goods_id = ID;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else if ([dic[@"type_id"] isEqualToString:@"5"]){
                ID = dic[@"shangjia_id"];
                ShangJia_Details_ViewController *vc = [[ShangJia_Details_ViewController alloc]init];
                vc.shop_id = ID;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        };
        return cell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row != 0) {
        Home_ZhaoBiao *zhaobiao = self.zhaobiao[indexPath.row - 1];
        Web_ViewController *vc = [[Web_ViewController alloc]init];
        vc.url = zhaobiao.url;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if (indexPath.section == 0){
        NSDictionary *dic = self.zixun[0];
        Web_ViewController *vc = [[Web_ViewController alloc]init];
        vc.url = dic[@"url"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 1;
}


@end
