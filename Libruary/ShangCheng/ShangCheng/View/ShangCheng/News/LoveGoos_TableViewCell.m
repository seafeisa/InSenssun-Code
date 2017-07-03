//
//  LoveGoos_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/13.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "LoveGoos_TableViewCell.h"
#import "Love_Goods_CollectionViewCell.h"

@interface LoveGoos_TableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *momentCollectionView;

@end

@implementation LoveGoos_TableViewCell

- (void)setContentArray:(NSMutableArray *)contentArray {
    _contentArray = contentArray;
    [self.momentCollectionView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width - 20 - 2) / 2, 100);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    self.momentCollectionView.showsHorizontalScrollIndicator = NO;
    self.momentCollectionView.scrollEnabled = NO;
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"Love_Goods_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Love_Goods_CollectionViewCell"];
    [self addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Love_Goods_CollectionViewCell";
    Love_Goods_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.image = self.contentArray[indexPath.item][@"pic"];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.contentArray[indexPath.item];
    NSString *ID = @"";
    if ([dic[@"type_id"] isEqualToString:@"6"]) {
        ID = dic[@"goods_id"];
    }else if ([dic[@"type_id"] isEqualToString:@"5"]){
        ID = dic[@"shangjia_id"];
    }
    if (self.details_Block) {
        self.details_Block(ID,dic[@"type_id"]);
    }
}

@end
