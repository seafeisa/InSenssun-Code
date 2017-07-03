//
//  Index_Head_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Index_Head_View.h"
#import "JZLCycleView.h"

@interface Index_Head_View ()<JZLCycleViewDelegate>
@property (nonatomic, weak) JZLCycleView *cycleView;
@property (weak, nonatomic) IBOutlet UILabel *Seach_Label;
@property (weak, nonatomic) IBOutlet UIView *search_view;
@property (weak, nonatomic) IBOutlet UIButton *fen_lei_button;
@property (weak, nonatomic) IBOutlet UIButton *shop_cart_button;

@end

@implementation Index_Head_View

- (void)setImg_arr:(NSMutableArray *)img_arr {
    _img_arr = img_arr;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < img_arr.count; i ++) {
        NSDictionary *dic = img_arr[i];
        [array addObject:dic[@"pic"]];
    }
    self.cycleView.imageArray = array;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _cycleView = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0, 0, kScreen_Width, 200) PlaceholderImage:[UIImage imageNamed:@"banner"]];
    _cycleView.pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    _cycleView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _cycleView.delegate = self;
//    _cycleView.clickItemBlock = ^(NSInteger index){
//        NSLog(@"%ld",(long)index);
//    };
    [self addSubview:_cycleView];
    
    [self sendSubviewToBack:_cycleView];
    
    self.search_view.layer.cornerRadius = 6;
    self.search_view.layer.masksToBounds = YES;
    
    [self.fen_lei_button bk_addEventHandler:^(id sender) {
        DebugLog(@"dsjdckdf");
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.shop_cart_button bk_addEventHandler:^(id sender) {
        DebugLog(@"shabdhab00000");
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.search_view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(next_page)];
    [self.search_view addGestureRecognizer:tap];
}

//代理跳转
- (void)selectItemAtIndex:(NSInteger)index {
    if (self.url_Block) {
        self.url_Block(index);
    }
    NSLog(@"%zd",index);
}

- (void)next_page {
    if (self.nextPage_Block) {
        self.nextPage_Block ();
    }
}
- (IBAction)shopCart_button:(id)sender {
    if (self.shopCart_Block) {
        self.shopCart_Block();
    }
}

@end