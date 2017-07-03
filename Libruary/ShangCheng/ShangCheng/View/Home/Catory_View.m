//
//  Catory_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/20.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Catory_View.h"

@interface Catory_View ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic,strong)NSMutableArray *data_arr;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation Catory_View

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.data_arr = [NSMutableArray array];
    [self getData];
}


- (void)getData {
    [self beginLoading];
    [[APPNetAPIManager sharedManager]request_getcat_WithBlock:^(id data, NSError *error) {
        [self endLoading];
        if (data) {
            [self.data_arr addObjectsFromArray:data];
            [self.myTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data_arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
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
    cell.textLabel.text = self.data_arr[indexPath.row][@"cat_name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.data_arr[indexPath.row];
    if (self.getName_Block) {
        self.getName_Block(dic[@"cat_name"], dic[@"id"]);
    }
}

@end
