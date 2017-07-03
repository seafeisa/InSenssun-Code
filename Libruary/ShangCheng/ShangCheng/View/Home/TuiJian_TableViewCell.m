//
//  TuiJian_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/21.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "TuiJian_TableViewCell.h"
#import "Image_CollectionViewCell.h"

@interface TuiJian_TableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *top_image;
@property (weak, nonatomic) IBOutlet UIImageView *bottom_image;
@property (weak, nonatomic) IBOutlet UIView *content_view;

@end

@implementation TuiJian_TableViewCell

- (void)setCenter_arr:(NSMutableArray *)center_arr {
    _center_arr = center_arr;
    [self.momentCollectionView reloadData];
}

- (void)setTop_imageName:(NSString *)top_imageName {
    [self.top_image sd_setImageWithURL:[NSURL URLWithString:top_imageName] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xeeeeee"]]];
}

- (void)setBottom_imageName:(NSString *)bottom_imageName {
    [self.bottom_image sd_setImageWithURL:[NSURL URLWithString:bottom_imageName] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xeeeeee"]]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width - 20) / 3, CGRectGetHeight(self.content_view.frame));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor whiteColor];
    self.momentCollectionView.showsHorizontalScrollIndicator = NO;
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"Image_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Image_CollectionViewCell"];
    [self.content_view addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.top_image.userInteractionEnabled = YES;
    self.bottom_image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.top_image addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1)];
    [self.bottom_image addGestureRecognizer:tap1];
}

- (void)tap{
    if (self.TopDetails_Block) {
        self.TopDetails_Block();
    }
}

- (void)tap1{
    if (self.BottomDetails_Block) {
        self.BottomDetails_Block();
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.center_arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Image_CollectionViewCell";
    Image_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.imageName = self.center_arr[indexPath.item][@"pic"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 6;
    cell.layer.masksToBounds = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.center_arr[indexPath.item];
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
