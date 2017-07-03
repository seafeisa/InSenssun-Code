//
//  AppDelegate.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "GuideVC.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self customizeInterface];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    DebugLog(@"======%@----%@",version,[[NSUserDefaults standardUserDefaults]objectForKey:@"version"]);
    
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"version"] isEqualToString:version]) {
        [[NSUserDefaults standardUserDefaults]setObject:version forKey:@"version"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        DebugLog(@"第一次启动");
        GuideVC *VC = [[GuideVC alloc]init];
        [self.window setRootViewController:VC];
    }else{
        DebugLog(@"不是第一次启动");
        ViewController *VC = [[ViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        self.window.rootViewController = nav;
    }
    
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLanch1"]){
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLanch1"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        DebugLog(@"第一次启动");
//        GuideVC *VC = [[GuideVC alloc]init];
//        [self.window setRootViewController:VC];
//    }else{
//        DebugLog(@"不是第一次启动");
//        ViewController *VC = [[ViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
//        self.window.rootViewController = nav;
//    }
    
//    ViewController *VC = [[ViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
//    self.window.rootViewController = nav;
    
    // 打开网络指示器
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    // 打开网络监听
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status != AFNetworkReachabilityStatusNotReachable) {
            // 有网络
        } else {
            // 没有网络了
            [self netwrokReachability];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [WXApi registerApp:@"wx308505d05fe0db27"];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        DebugLog(@"result = %@",resultDic);
    }];
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        DebugLog(@"result = %@",resultDic);
    }];
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        DebugLog(@"result = %@",resultDic);
    }];
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 */
- (void)onResp:(BaseResp *)resp
{
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg = [NSString stringWithFormat:@"支付结果"];
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            DebugLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            break;
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            DebugLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setTintColor:[UIColor whiteColor]];
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17], NSForegroundColorAttributeName: [UIColor whiteColor]};
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    navigationBarAppearance.translucent = NO;
    //    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xD10F1D"]] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:MainColor] forBarMetrics:UIBarMetricsDefault];
    navigationBarAppearance.shadowImage = [[UIImage alloc] init];
    //    [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"0xD10F1D"]];
    //    [[UITextView appearance] setTintColor:[UIColor colorWithHexString:@"0xD10F1D"]];
    [[UITextView appearance]setTintColor:MainColor];
    [[UITextField appearance]setTintColor:MainColor];
}

- (void)netwrokReachability {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前网络链接不可用" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"忽略" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"前往设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
            
        }];
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
