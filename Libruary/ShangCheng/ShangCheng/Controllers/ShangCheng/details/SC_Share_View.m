//
//  SC_Share_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/6/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Share_View.h"
#import "Share_TableViewCell.h"

@interface SC_Share_View ()<UITableViewDelegate, UITableViewDataSource>{
    NSString *tempPhoto;
    NSString *tempUrl;
}

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation SC_Share_View

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] init];
            tableView.backgroundColor = [UIColor whiteColor];
            
            [tableView registerNib:[UINib nibWithNibName:@"Share_TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Share_TableViewCell"];
            
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            tableView;
        });
        
        tempPhoto = @"";
        tempUrl = @"";
        
        [self getdata];
    }
    return self;
}

- (void)getdata {
    [self beginLoading];
    [[APPNetAPIManager sharedManager]request_erweima_WithBlock:^(id data, NSError *error) {
        [self endLoading];
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
        [[self findViewController] presentViewController:activityViewController animated:YES completion:nil];
        
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

- (UIViewController *)findViewController
{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


@end
