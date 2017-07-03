//
//  SC_Login_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Login_ViewController.h"
#import "Login_Cell.h"
#import "SC_Register_ViewController.h"
#import "SC_Mine_ViewController.h"
#import "Forget_Psw_ViewController.h"

@interface SC_Login_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;

@end

@implementation SC_Login_ViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if (self.IsQuitLogin == YES) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(quitLogin)];
    }
    
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        
        [tableView registerNib:[UINib nibWithNibName:@"Login_Cell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Login_Cell"];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
}

- (void)quitLogin {
    if (self.login_Block) {
        self.login_Block();
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Login_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Login_Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.register_Block = ^{
        [self.view endEditing:YES];
        SC_Register_ViewController *VC = [[SC_Register_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    };
    cell.login_Block = ^(NSString *phone, NSString *pwd){
        [self.view endEditing:YES];
        [self.view beginLoading];
        [[APPNetAPIManager sharedManager]request_Login_WithPhone:phone WithPwd:pwd andBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                [[NSUserDefaults standardUserDefaults]setObject:pwd forKey:@"pwd"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                if (self.login_Block) {
                    self.login_Block();
                }
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    };
    //Forget_Psw_ViewController
    cell.forget_Block = ^{
        [self.view endEditing:YES];
        Forget_Psw_ViewController *vc = [[Forget_Psw_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

@end
