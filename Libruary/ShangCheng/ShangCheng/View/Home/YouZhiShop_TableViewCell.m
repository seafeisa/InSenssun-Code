//
//  YouZhiShop_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "YouZhiShop_TableViewCell.h"
#import "Youzhi_CollectionViewCell.h"

@interface YouZhiShop_TableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *more_button;
@property (weak, nonatomic) IBOutlet UIView *content_view;

@end

@implementation YouZhiShop_TableViewCell

- (void)setYouzhiArr:(NSMutableArray *)youzhiArr {
    _youzhiArr = youzhiArr;
    [self.momentCollectionView reloadData];
}
- (IBAction)more_button:(id)sender {
    if (self.more_Block) {
        self.more_Block();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.more_button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width - 2 - 20) / 2, 80);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor whiteColor];
    self.momentCollectionView.showsHorizontalScrollIndicator = NO;
    self.momentCollectionView.scrollEnabled =NO;
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"Youzhi_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Youzhi_CollectionViewCell"];
    [self.content_view addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.youzhiArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Youzhi_CollectionViewCell";
    Youzhi_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.youzhishop = self.youzhiArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Youzhi_Shop *youzhishop = self.youzhiArr[indexPath.item];
    if (self.shop_details_Block) {
        self.shop_details_Block(youzhishop.id);
    }
}

@end
