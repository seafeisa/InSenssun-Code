//
//  Recomend_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/22.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Recomend_TableViewCell.h"
#import "Recomend_CollectionViewCell.h"

@interface Recomend_TableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (weak, nonatomic) IBOutlet UIView *content_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_height;

@end

@implementation Recomend_TableViewCell

- (void)setGoos_arr:(NSMutableArray *)goos_arr{
    _goos_arr = goos_arr;
    self.content_height.constant = 220 * (goos_arr.count / 2);
    [self.momentCollectionView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width - 20 - 2) / 2, 220);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    self.momentCollectionView.showsHorizontalScrollIndicator = NO;
    self.momentCollectionView.scrollEnabled = NO;
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"Recomend_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Recomend_CollectionViewCell"];
    [self.content_view addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}
- (IBAction)more_button:(id)sender {
    if (self.more_button) {
        self.more_button();
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goos_arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Recomend_CollectionViewCell";
    Recomend_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.shop = self.goos_arr[indexPath.item];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZongHe_Shop *shop = self.goos_arr[indexPath.item];
    if (self.shop_details_Block) {
        self.shop_details_Block(shop.id);
    }
}

@end
