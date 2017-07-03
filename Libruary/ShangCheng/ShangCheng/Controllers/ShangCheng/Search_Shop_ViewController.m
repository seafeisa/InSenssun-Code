//
//  Search_Shop_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/19.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Search_Shop_ViewController.h"
#import "Shang_Jia_Cell.h"
#import "ShangJia_Details_ViewController.h"
#import "List_Content_Cell.h"
#import "SC_Details_ViewController.h"

@interface Search_Shop_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UITextField *text_field;
}
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (nonatomic,strong)NSMutableArray *shop_arr;
@property (nonatomic,strong)NSMutableArray *shopOwner_arr;

@end

@implementation Search_Shop_ViewController

- (NSMutableArray *)shop_arr {
    if (_shop_arr == nil) {
        _shop_arr = [NSMutableArray array];
    }
    return _shop_arr;
}

- (NSMutableArray *)shopOwner_arr {
    if (_shopOwner_arr == nil) {
        _shopOwner_arr = [NSMutableArray array];
    }
    return _shopOwner_arr;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title = @"商家/商品搜索";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.headerReferenceSize = CGSizeMake(kScreen_Width, 40);
    layout.itemSize = CGSizeMake((kScreen_Width - 15) / 2, 220);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0.f, 5, 5.f, 5);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"List_Content_Cell" bundle:nil] forCellWithReuseIdentifier:@"List_Content_Cell"];
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"Shang_Jia_Cell" bundle:nil] forCellWithReuseIdentifier:@"Shang_Jia_Cell"];
    [self.momentCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"header"];
    [self.view addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(50);
        make.bottom.mas_equalTo(0);
    }];
    
    [self customHeadView];
}

- (void)customHeadView {
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:bg];
    
    UIView *search_view = [[UIView alloc]init];
    search_view.backgroundColor = [UIColor whiteColor];
    search_view.layer.cornerRadius = 4;
    search_view.layer.masksToBounds = YES;
    [bg addSubview:search_view];
    [search_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreen_Width - 20);
        make.height.mas_equalTo(35);
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    
    text_field = [[UITextField alloc]init];
    text_field.placeholder = @"请输入商品/商家名称";
    text_field.font = [UIFont systemFontOfSize:14];
    [search_view addSubview:text_field];
    [text_field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-80);
    }];
    
    UIButton *search_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    search_btn.backgroundColor = MainColor;
    [search_btn setTitle:@"搜索" forState:0];
    [search_btn addTarget:self action:@selector(seachShop) forControlEvents:UIControlEventTouchUpInside];
    search_btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [search_view addSubview:search_btn];
    [search_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(55);
    }];
}

- (void)seachShop {
    [self.view endEditing:YES];
    if (text_field.text.length == 0) {
        [NSObject showHudTipStr:@"请输入商品/商家名称"];
        return;
    }
    [self getGoods];
}

- (void)getGoods {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_searchshop_WithContent:text_field.text andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            if (self.shop_arr.count > 0) {
                [self.shop_arr removeAllObjects];
            }
            if (self.shopOwner_arr.count > 0) {
                [self.shopOwner_arr removeAllObjects];
            }
            NSError *oneError;
            self.shop_arr = [[MTLJSONAdapter modelsOfClass:[ZongHe_Shop class] fromJSONArray:data[@"goodsInfo"] error:&oneError] mutableCopy];
            self.shopOwner_arr = [[MTLJSONAdapter modelsOfClass:[Shop_Owner class] fromJSONArray:data[@"shopInfo"] error:&oneError] mutableCopy];
            if (self.shop_arr.count == 0) {
                [NSObject showHudTipStr:@"暂无商品"];
            }
            if (self.shopOwner_arr.count == 0) {
                [NSObject showHudTipStr:@"暂无商家"];
            }
            if (self.shop_arr.count == 0 && self.shopOwner_arr.count == 0) {
                [NSObject showHudTipStr:@"暂无数据"];
            }
            [self.momentCollectionView reloadData];
        }
    }];
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake((kScreen_Width - 15) / 2, 200);
    }
    return CGSizeMake((kScreen_Width - 15) / 2, 220);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.shop_arr.count;
    }
    return self.shopOwner_arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identify = @"List_Content_Cell";
        List_Content_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        if (self.shop_arr.count > 0) {
            cell.shop = self.shop_arr[indexPath.item];
        }
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    static NSString *identify = @"Shang_Jia_Cell";
    Shang_Jia_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (self.shopOwner_arr.count > 0) {
        cell.owner = self.shopOwner_arr[indexPath.item];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        for (id sub in [headerView subviews]) {
            if ([sub isKindOfClass:[UIView class]]) {
                [sub removeFromSuperview];
            }
        }
        [headerView addSubview:[self createHeaderViewWithIndex:indexPath.section]];
        return headerView;
    }
    return nil;
}

- (UIView *)createHeaderViewWithIndex:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreen_Width - 20, 40)];
    if (self.shop_arr.count > 0 || self.shopOwner_arr.count > 0) {
        if (section == 0) {
            label.text = @"商品搜索结果";
        }else{
            label.text = @"商家搜索结果";
        }
    }
    [view addSubview:label];
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SC_Details_ViewController *VC = [[SC_Details_ViewController alloc]init];
        ZongHe_Shop *shop = self.shop_arr[indexPath.item];
        VC.goods_id = shop.id;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        Shop_Owner *owner = self.shopOwner_arr[indexPath.item];
        ShangJia_Details_ViewController *vc = [[ShangJia_Details_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        vc.shop_id = owner.id;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}


@end
