//
//  SC_Shop_Host_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Shop_Host_ViewController.h"
#import "Shang_Jia_Cell.h"
#import "ShangJia_RuZhu_ViewController.h"
#import "ShangJia_Details_ViewController.h"
#import "SC_Login_ViewController.h"

@interface SC_Shop_Host_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (nonatomic,strong)NSMutableArray *shop_arr;
@end

@implementation SC_Shop_Host_ViewController

- (NSMutableArray *)shop_arr {
    if (_shop_arr == nil) {
        _shop_arr = [NSMutableArray array];
    }
    return _shop_arr;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"商家";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width - 15) / 2, 220);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(5.f, 5, 5.f, 5);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"Shang_Jia_Cell" bundle:nil] forCellWithReuseIdentifier:@"Shang_Jia_Cell"];
    [self.view addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    [right setTitle:@"入驻" forState:0];
    right.titleLabel.font = [UIFont systemFontOfSize:13];
    right.layer.borderColor = [UIColor whiteColor].CGColor;
    right.layer.borderWidth = 1;
    right.bounds = CGRectMake(0, 0, 50, 25);
    [right addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = item;
    
    [self getData];
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    self.momentCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
    }];
    //进入就进行一次刷新
//    [self.momentCollectionView.mj_header beginRefreshing];
    
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.momentCollectionView.mj_header endRefreshing];
    });
}

- (void)getData {
    [[APPNetAPIManager sharedManager]request_Shoplist_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.shop_arr = [data mutableCopy];
            [self.momentCollectionView reloadData];
        }
    }];
}

- (void)next {
    if ([Login_Total curLoginUser].id){
        ShangJia_RuZhu_ViewController *VC = [[ShangJia_RuZhu_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        SC_Login_ViewController *vc = [[SC_Login_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shop_arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Shang_Jia_Cell";
    Shang_Jia_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (self.shop_arr.count > 0) {
        cell.owner = self.shop_arr[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Shop_Owner *owner = self.shop_arr[indexPath.item];
    ShangJia_Details_ViewController *vc = [[ShangJia_Details_ViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    vc.shop_id = owner.id;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


@end
