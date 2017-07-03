//
//  Hot_Shop_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Hot_Shop_ViewController.h"
#import "List_Content_Cell.h"
#import "SC_Details_ViewController.h"
#import "SnailQuickMaskPopups.h"
#import "Catory_View.h"

@interface Hot_Shop_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SnailQuickMaskPopupsDelegate>{
    UIButton *agoBtn;
    UILabel *agoLabel;
    
    NSString *stateStr;
    
    
    NSString *tempCategory;
}
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (nonatomic,strong)NSMutableArray *shop_arr;
@property (nonatomic, strong) SnailQuickMaskPopups *popups;

@end

@implementation Hot_Shop_ViewController

- (NSMutableArray *)shop_arr {
    if (_shop_arr == nil) {
        _shop_arr = [NSMutableArray array];
    }
    return _shop_arr;
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
    
    self.title = @"商品列表";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width - 5) / 2, 200);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(5.f, 0, 5.f, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"List_Content_Cell" bundle:nil] forCellWithReuseIdentifier:@"List_Content_Cell"];
    [self.view addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(45);
        make.bottom.mas_equalTo(0);
    }];
    
    tempCategory = @"0";
    
    stateStr = @"id";
    
    [self customHeadView];
    
    [self getData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(getCatID)];
}

- (void)getCatID {
    for (id sub in [self.view subviews]) {
        if ([sub isKindOfClass:[Catory_View class]]) {
            [sub removeFromSuperview];
        }
    }
    Catory_View *view = [[[NSBundle mainBundle]loadNibNamed:@"Catory_View" owner:nil options:nil]firstObject];
    view.getName_Block = ^(NSString *name, NSString *nameId) {
        self.title = [NSString stringWithFormat:@"商品列表-%@",name];
        tempCategory = nameId;
        [self getData];
        [self dismiss];
    };
    view.frame = CGRectMake(0, 0, kScreen_Width / 2 + 50, kScreen_Height);
    
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:view];
    _popups.presentationStyle = PresentationStyleRight;
    _popups.isAllowPopupsDrag = YES;
    [_popups presentAnimated:YES completion:NULL];
}

#pragma mark - dismiss
- (void)dismiss {
    [_popups dismissAnimated:YES completion:NULL];
}

- (void)customHeadView {
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    NSArray *name = @[@"综合",@"销量",@"价格"];
    CGFloat width = kScreen_Width / name.count;
    for (int i = 0; i < name.count; i ++) {
        UIView *view = [[UIView alloc]init];
        [bg addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(width * i);
            make.width.mas_equalTo(width);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:MainColor forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor groupTableViewBackgroundColor]] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [btn setTitle:name[i] forState:0];
        [btn bk_addEventHandler:^(id sender) {
            agoBtn.selected = NO;
            btn.selected = YES;
            agoBtn = btn;
            agoLabel.backgroundColor = [UIColor lightGrayColor];
            label.backgroundColor = MainColor;
            agoLabel = label;
            
            if ([btn.currentTitle isEqualToString:@"综合"]) {
                stateStr = @"id";
            }else if ([btn.currentTitle isEqualToString:@"销量"]) {
                stateStr = @"goods_sales_num";
            }else if ([btn.currentTitle isEqualToString:@"价格"]) {
                stateStr = @"shop_price";
            }
            [self getData];
        } forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        if (i == 0) {
            label.backgroundColor = MainColor;
            btn.selected = YES;
            agoBtn = btn;
            agoLabel = label;
        }
    }
}

- (void)getData {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_goodslist_WithOrder:stateStr cat_id:tempCategory andBlock:^(id data, NSError *error){
        [self.view endLoading];
        if (data) {
            if (self.shop_arr.count > 0) {
                [self.shop_arr removeAllObjects];
            }
            self.shop_arr = [data mutableCopy];
            [self.momentCollectionView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shop_arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"List_Content_Cell";
    List_Content_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (self.shop_arr.count > 0) {
        cell.shop = self.shop_arr[indexPath.item];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SC_Details_ViewController *VC = [[SC_Details_ViewController alloc]init];
    ZongHe_Shop *shop = self.shop_arr[indexPath.item];
    VC.goods_id = shop.id;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

@end
