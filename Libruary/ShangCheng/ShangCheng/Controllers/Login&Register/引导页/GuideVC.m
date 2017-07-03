//
//  GuideVC.m
//  Workers
//
//  Created by 黄丹丹 on 16/8/2.
//  Copyright © 2016年 HuangDandan. All rights reserved.
//

#import "GuideVC.h"
#import "ViewController.h"


@interface GuideVC ()<UIScrollViewDelegate,UIPageViewControllerDelegate>{
    NSArray *imageNames;
    UIButton *button;
    
    UIScrollView *myScrollView;
}
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Width;

@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initGuide];
    
    
    imageNames = @[@"come_1.jpg",
                   @"come_2.jpg",
//                   @"come_3.jpg"// 本地图片请填写全名
                   ];
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self createScrollView];
}

- (void)createScrollView {
    myScrollView = [[UIScrollView alloc]init];
    myScrollView.delegate = self;
    myScrollView.contentSize = CGSizeMake(kScreen_Width *imageNames.count, kScreen_Height);
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
    [myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    for (int i = 0; i < imageNames.count; i ++) {
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:imageNames[i]];
        [myScrollView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kScreen_Width * i);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreen_Width);
            make.height.mas_equalTo(kScreen_Height);
        }];
    }
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor colorWithHexString:@"eeeeee"].CGColor;
    button.layer.borderWidth = 1;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor blackColor] forState:0];
    button.alpha = 0;;
    
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    self.view.hidden = YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int X = scrollView.contentOffset.x;
    int offset = kScreen_Width;
    
    if (X / offset == imageNames.count - 1) {
        button.alpha = 1;
    }else{
        button.alpha = 0;
    }
}

- (void)firstpressed
{
    ViewController *VC = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = nav;
//    YiWei_Login_VC *loginVC = [[YiWei_Login_VC alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    [self presentViewController:nav animated:NO completion:nil];
}
@end
