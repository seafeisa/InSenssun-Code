//
//  Device_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/21.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Device_TableViewCell.h"
#import "Device_CollectionViewCell.h"

@interface Device_TableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>{
}
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (weak, nonatomic) IBOutlet UIView *content_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bg_image_Top;
@property (weak, nonatomic) IBOutlet UILabel *title_label;

@end

@implementation Device_TableViewCell

- (void)setDevice_arr:(NSMutableArray *)device_arr{
    _device_arr = device_arr;
    self.bg_image_Top.constant = 0;
    [self.momentCollectionView reloadData];
}

- (void)setName:(NSString *)name {
    _name = name;
    self.title_label.text = name;
}

- (IBAction)more_button:(id)sender {
    if (self.more_button) {
        self.more_button();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreen_Width / 3, 160);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 2; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    self.momentCollectionView.showsHorizontalScrollIndicator = NO;
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"Device_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Device_CollectionViewCell"];
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
    return self.device_arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Device_CollectionViewCell";
    Device_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentDic = self.device_arr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.device_arr[indexPath.item];
    if (self.shop_details_Block) {
        self.shop_details_Block(dic[@"id"]);
    }
}

@end
