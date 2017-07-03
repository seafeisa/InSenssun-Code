//
//  ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "ViewController.h"
#import "SC_Mine_ViewController.h"
#import "SC_Shop_Host_ViewController.h"
#import "SC_Zhao_Qiu_Biao_ViewController.h"
#import "SC_Shop_ViewController.h"
#import "SC_Home_ViewController.h"

@interface ViewController ()
@property (strong,nonatomic)UITabBarController *tabBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self TabBarController];
}

- (void)TabBarController{
    SC_Mine_ViewController *mineVC = [[SC_Mine_ViewController alloc]init];
    mineVC.tabBarItem.title = @"我的";
    mineVC.title = mineVC.tabBarItem.title;
    
    SC_Shop_Host_ViewController *shop_hostVC = [[SC_Shop_Host_ViewController alloc]init];
    shop_hostVC.tabBarItem.title = @"商家";
    shop_hostVC.title = shop_hostVC.tabBarItem.title;
    
    SC_Zhao_Qiu_Biao_ViewController *zhaoVC = [[SC_Zhao_Qiu_Biao_ViewController alloc]init];
    zhaoVC.tabBarItem.title = @"招求标";
    zhaoVC.title = zhaoVC.tabBarItem.title;
    
    SC_Shop_ViewController *shopVC = [[SC_Shop_ViewController alloc]init];
    shopVC.tabBarItem.title = @"商城";
    shopVC.title = shopVC.tabBarItem.title;
    
    
    SC_Home_ViewController *homeVC = [[SC_Home_ViewController alloc]init];
    homeVC.tabBarItem.title = @"首页";
    homeVC.title = homeVC.tabBarItem.title;
    
    NSArray *toolBtnImage = [NSArray arrayWithObjects:@"icon_home_gray",@"icon_store_gray",@"icon_zhaobiao_gray",@"icon_business_gray",@"icon_my_gray",nil];
    NSArray *toolBtnImage1 = [NSArray arrayWithObjects:@"icon_home_blue",@"icon_store_blue",@"icon_zhaobiao_blue",@"icon_business_blue",@"icon_my_blue",nil];
    
    NSArray *array = @[homeVC,shopVC,zhaoVC,shop_hostVC,mineVC];
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:array[i]];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [nav.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName :[UIColor whiteColor] ,NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]}];
        nav.navigationBar.translucent = NO;
        [nav.navigationBar setBarTintColor :MainColor];
        
        [nav.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        nav.navigationBar.shadowImage = [[UIImage alloc] init];
        nav.navigationController.navigationBar.translucent = NO;
        nav.tabBarItem.image = [[UIImage imageNamed:[toolBtnImage objectAtIndex:i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:[toolBtnImage1 objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [viewControllers addObject:nav];
    }
    self.tabBar = [[UITabBarController alloc]init];
    self.tabBar.tabBar.tintColor = MainColor;
    self.tabBar.viewControllers = viewControllers;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = self.tabBar;
}


@end
