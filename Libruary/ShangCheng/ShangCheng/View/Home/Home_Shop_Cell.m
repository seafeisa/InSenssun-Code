//
//  Home_Shop_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/8.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Home_Shop_Cell.h"
#import "HotShop_CollectionViewCell.h"



@interface Home_Shop_Cell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIView *content_view;
@property (weak, nonatomic) IBOutlet UIButton *more_button;

@end

@implementation Home_Shop_Cell

- (void)setHotArr:(NSMutableArray *)hotArr {
    _hotArr = hotArr;
    [self.momentCollectionView reloadData];
}
- (IBAction)more_button:(id)sender {
    if (self.more_button_block) {
        self.more_button_block();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.more_button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreen_Width / 3, CGRectGetHeight(self.content_view.frame));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor whiteColor];
    self.momentCollectionView.showsHorizontalScrollIndicator = NO;
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"HotShop_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HotShop_CollectionViewCell"];
    [self.content_view addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hotArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"HotShop_CollectionViewCell";
    HotShop_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell cellWithHotShop:self.hotArr[indexPath.item]];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Seller_HotShop *hot = self.hotArr[indexPath.item];
    if (self.shop_details_Block) {
        self.shop_details_Block(hot.id);
    }
}

@end
