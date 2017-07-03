//
//  ShangJia_Details_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "ShangJia_Details_ViewController.h"
#import "Details_Head_TableViewCell.h"
#import "Details_Photo_TableViewCell.h"

@interface ShangJia_Details_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *data_arr;
@end

@implementation ShangJia_Details_ViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (NSMutableArray *)xsbuy_arr {
    if (_data_arr == nil) {
        _data_arr = [NSMutableArray array];
    }
    return _data_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"商家详情";
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Details_Head_TableViewCell" bundle:nil] forCellReuseIdentifier:@"Details_Head_TableViewCell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView;
    });
    
    [self getData];
}

- (void)getData {
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_shop_detail_WithId:self.shop_id andBlock:^(id data, NSError *error) {
        [self.view endLoading];
        if (data) {
            self.data_arr = [data mutableCopy];
            [self.myTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return kScreen_Width / 1.5;
    }else if (indexPath.row == 5){
        if (self.data_arr.count > 0) {
            Shop_Details_MTL *details = self.data_arr[0];
            NSString *str = [NSString stringWithFormat:@"\n商家介绍:\n\t%@\n",details.shop_desc];
            CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreen_Width - 25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
            if (rect.size.height < 50) {
                rect.size.height = 50;
            }
            return rect.size.height + 10;
        }
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Details_Head_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Details_Head_TableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.data_arr.count > 0) {
            cell.details = self.data_arr[0];
        }
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = [UIColor hexStringToColor:@"#eeeeee"];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    if (self.data_arr.count > 0) {
        Shop_Details_MTL *details = self.data_arr[0];
        if (indexPath.row == 1) {
            cell.textLabel.text = details.shop_name;
        }else if (indexPath.row == 2){
            cell.textLabel.text = details.shop_desc;
        }else if (indexPath.row == 3){
            cell.textLabel.text = [NSString stringWithFormat:@"联系人 : %@",details.shop_linkman];
        }else if (indexPath.row == 4){
            cell.textLabel.text = [NSString stringWithFormat:@"手机 : %@",details.shop_tel];
        }else if (indexPath.row == 5){
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.text = [NSString stringWithFormat:@"\n商家介绍 :\n\t%@\n",details.shop_desc];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:cell.textLabel.text];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(1, 4)];
            cell.textLabel.attributedText = AttributedStr;
        }
    }
    return cell;
}

@end
