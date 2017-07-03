//
//  Mine_Order_cell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Mine_Order_cell.h"
#import "Goods_CollectionViewCell.h"

@interface Mine_Order_cell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *momentCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *pay_button;
@property (weak, nonatomic) IBOutlet UIButton *ping_jia_button;
@property (weak, nonatomic) IBOutlet UIButton *delete_button;
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *info_label;
@property (weak, nonatomic) IBOutlet UILabel *price_label;
@property (weak, nonatomic) IBOutlet UILabel *shop_nums_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;

@property (weak, nonatomic) IBOutlet UIView *content_view;

@property (weak, nonatomic) IBOutlet UILabel *orderID_label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_height;
@property (weak, nonatomic) IBOutlet UILabel *yunFei_label;

@end

@implementation Mine_Order_cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.pay_button.layer.borderColor = [UIColor redColor].CGColor;
    self.pay_button.layer.borderWidth = 1;
    
    self.ping_jia_button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.ping_jia_button.layer.borderWidth = 1;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreen_Width, 90);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 1; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.momentCollectionView.delegate = self;
    self.momentCollectionView.dataSource =self;
    self.momentCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.momentCollectionView.showsVerticalScrollIndicator = NO;
    self.momentCollectionView.scrollEnabled = NO;
    [self.momentCollectionView registerNib:[UINib nibWithNibName:@"Goods_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Goods_CollectionViewCell"];
    [self.content_view addSubview:self.momentCollectionView];
    [self.momentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}


- (IBAction)delete_button:(id)sender {
    if (self.delete_Block) {
        self.delete_Block();
    }
}

- (IBAction)pingJia_button:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([btn.currentTitle isEqualToString:@"评价"]) {
        if (self.PingJia_Block) {
            self.PingJia_Block();
        }
    }else if ([btn.currentTitle isEqualToString:@"确认收货"]){
        if (self.GetGoos_Block) {
            self.GetGoos_Block();
        }
    }else if ([btn.currentTitle isEqualToString:@"再次购买"]){
        
    }
}
- (IBAction)pay_button:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([btn.currentTitle isEqualToString:@"去支付"]) {
        if (self.pay_Block) {
            self.pay_Block();
        }
    }else if ([btn.currentTitle isEqualToString:@"查看物流"]){
        if (self.CheckWuLiu_Block) {
            self.CheckWuLiu_Block();
        }
    }else if ([btn.currentTitle isEqualToString:@"去评价"]){
        if (self.PingJia_Block) {
            self.PingJia_Block();
        }
    }else if ([btn.currentTitle isEqualToString:@"再次购买"]){
        
    }
}

- (void)setOrder:(NSDictionary *)order {
    _order = order;
    self.orderID_label.text = [NSString stringWithFormat:@"订单号：%@",order[@"out_trade_no"]];
    self.time_label.text = [NSString stringWithFormat:@"下单时间：%@",order[@"addtime"]];
    self.yunFei_label.text = [NSString stringWithFormat:@"运费金额：¥%@",order[@"total_yfprice"]];
    self.shop_nums_label.text = [NSString stringWithFormat:@"共 %@ 件商品   合计：¥%@",order[@"total_num"],order[@"total_price"]];
    
    NSRange range = [self.shop_nums_label.text rangeOfString:@"合计"];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.shop_nums_label.text];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(range.location, self.shop_nums_label.text.length - range.location)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, self.shop_nums_label.text.length - range.location)];
    self.shop_nums_label.attributedText = AttributedStr;
    
    
    NSString *status = [NSString stringWithFormat:@"%@",order[@"pay_status"]];
    //支付状态： 1-待付款 3-确认收货 4-已付款 5-待评价 6-已评价
    self.ping_jia_button.hidden = NO;
    if ([status isEqualToString:@"1"]) {
        self.ping_jia_button.hidden = YES;
        [self.pay_button setTitle:@"去支付" forState:0];
    }else if ([status isEqualToString:@"4"]) {
        self.ping_jia_button.hidden = NO;
        [self.ping_jia_button setTitle:@"确认收货" forState:0];
        [self.pay_button setTitle:@"查看物流" forState:0];
    }else if ([status isEqualToString:@"5"]) {
        self.ping_jia_button.hidden = NO;
        [self.ping_jia_button setTitle:@"再次购买" forState:0];
        [self.pay_button setTitle:@"去评价" forState:0];
    }else if ([status isEqualToString:@"6"]) {
        self.ping_jia_button.hidden = YES;
        [self.pay_button setTitle:@"再次购买" forState:0];
    }else{
        self.ping_jia_button.hidden = YES;
        [self.pay_button setTitle:@"再次购买" forState:0];
    }
    NSArray *array = self.order[@"goodsInfo"];
    self.content_height.constant = array.count * 90;
    [self.momentCollectionView reloadData];
}

- (void)setRowHeight:(CGFloat)rowHeight {
    NSArray *array = self.order[@"goodsInfo"];
    self.content_height.constant = array.count * 90 + rowHeight - 10;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = self.order[@"goodsInfo"];
    NSDictionary *dic = array[indexPath.item];
    CGRect rect = [dic[@"goods_desc"] boundingRectWithSize:CGSizeMake(kScreen_Width - 75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil];
    return CGSizeMake(kScreen_Width, rect.size.height + 80);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = self.order[@"goodsInfo"];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"Goods_CollectionViewCell";
    Goods_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSArray *array = self.order[@"goodsInfo"];
    cell.dic = array[indexPath.item];
    return cell;
}

- (void)cellForOrder{
//    [self.ping_jia_button setTitle:@"评价" forState:0];
//    self.ping_jia_button.hidden = NO;
//    [self.pay_button setTitle:@"再次购买" forState:0];
}

- (void)cellForThings{
//    [self.ping_jia_button setTitle:@"查看物流" forState:0];
//    self.ping_jia_button.hidden = NO;
//    [self.pay_button setTitle:@"确认收货" forState:0];
}

- (void)cellForWaitMoney{
//    [self.pay_button setTitle:@"去支付" forState:0];
//    self.ping_jia_button.hidden = YES;
}

@end
