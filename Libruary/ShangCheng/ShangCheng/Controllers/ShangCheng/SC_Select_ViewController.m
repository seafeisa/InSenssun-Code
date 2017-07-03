//
//  SC_Select_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Select_ViewController.h"
#import "List_Head_View.h"
#import "List_Content_Cell.h"
#import "List_Head_ReusableView.h"
#import "SC_Details_ViewController.h"

@interface SC_Select_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSString *tempOrder;
}
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (nonatomic,strong)NSMutableArray *total_arr;
@end

@implementation SC_Select_ViewController

- (NSMutableArray *)total_arr {
    if (_total_arr == nil) {
        _total_arr = [NSMutableArray array];
    }
    return _total_arr;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    List_Head_View *list_view = [[[NSBundle mainBundle]loadNibNamed:@"List_Head_View" owner:nil options:nil]firstObject];
    list_view.return_block = ^{
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:list_view];
    [list_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(60);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width - 5) / 2, 200);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0.f, 0, 0.f, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor whiteColor];
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"List_Content_Cell" bundle:nil] forCellWithReuseIdentifier:@"List_Content_Cell"];
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"List_Head_ReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"List_Head_ReusableView"];
    [self.view addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(70);
        make.bottom.mas_equalTo(0);
    }];
    self.momentCollectionView.backgroundColor = [UIColor hexStringToColor:@"#eeeeee"];
    
    tempOrder = @"id";
    
    [self getData];
}

- (void)getData {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_goodslist_WithOrder:tempOrder cat_id:@"" andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.total_arr = [data mutableCopy];
            [self.momentCollectionView reloadData];
        }
    }];
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_getcat_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            DebugLog(@"-----%@",data[0][@"cat_name"]);
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.total_arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"List_Content_Cell";
    List_Content_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (self.total_arr.count > 0) {
        cell.shop = self.total_arr[indexPath.item];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SC_Details_ViewController *VC = [[SC_Details_ViewController alloc]init];
    ZongHe_Shop *shop = self.total_arr[indexPath.item];
    VC.goods_id = shop.id;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    List_Head_ReusableView *header;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"List_Head_ReusableView" forIndexPath:indexPath];
    }
    header.zonghe_Block = ^{
        tempOrder = @"id";
        [self.total_arr removeAllObjects];
        [self getData];
    };
    header.jiage_Block = ^{
        tempOrder = @"shop_price";
        [self.total_arr removeAllObjects];
        [self getData];
    };
    header.xiaoliang_Block = ^{
        tempOrder = @"goods_sales_num";
        [self.total_arr removeAllObjects];
        [self getData];
    };
    return header;
}

//执行的 headerView 代理  返回 headerView 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreen_Width, 40);
}


@end
