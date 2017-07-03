//
//  Index_Special_Cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Index_Special_Cell.h"
#import "Special_CollectionViewCell.h"

@interface Index_Special_Cell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (weak, nonatomic) IBOutlet UIView *content_view;

@end

@implementation Index_Special_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width - 30) / 2, 80);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 1; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    self.momentCollectionView.showsHorizontalScrollIndicator = NO;
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"Special_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Special_CollectionViewCell"];
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
    return self.special_array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Special_CollectionViewCell";
    Special_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.hotShop = self.special_array[indexPath.item];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


@end
