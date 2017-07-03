//
//  Share_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/6/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Share_ViewController.h"
#import "Share_TableViewCell.h"

@interface Share_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSString *tempPhoto;
    NSString *tempUrl;
}

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation Share_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"二维码分享";
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.backgroundColor = [UIColor whiteColor];
        
        [tableView registerNib:[UINib nibWithNibName:@"Share_TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Share_TableViewCell"];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    
    tempPhoto = @"";
    tempUrl = @"";
    
    [self getdata];
}

- (void)getdata {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_erweima_WithBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            tempUrl = data[@"url"];
            tempPhoto = data[@"img"];
            [self.myTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreen_Height - 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Share_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Share_TableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.image = tempPhoto;
    cell.share_block = ^{
        NSString *textToShare = @"买通信产品，就上通信家园。";
        UIImage *imageToShare = [UIImage imageNamed:@"Icon-60.png"];
        NSURL *urlToShare = [NSURL URLWithString:tempUrl];
        
        NSArray *activityItems = @[textToShare,imageToShare,urlToShare];
        
        // 服务类型控制器
        UIActivityViewController *activityViewController =
        [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        activityViewController.modalInPopover = true;
        [self presentViewController:activityViewController animated:YES completion:nil];
        
        // 选中分享类型
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
            
            // 显示选中的分享类型
            DebugLog(@"act type %@",activityType);
            
            if (completed) {
                DebugLog(@"ok");
            }else {
                DebugLog(@"no ok");
            }
            
        }];
    };
    return cell;
}


@end
