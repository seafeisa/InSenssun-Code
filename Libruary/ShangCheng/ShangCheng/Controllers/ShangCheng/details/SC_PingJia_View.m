//
//  SC_PingJia_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_PingJia_View.h"
#import "Ping_Jia_Cell.h"

@interface SC_PingJia_View ()<UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *data_arr;
@end

@implementation SC_PingJia_View

- (void)setContentDic:(NSMutableDictionary *)contentDic {
    _contentDic = contentDic;
    if ([contentDic[@"goods_comment"] isKindOfClass:[NSArray class]]) {
        self.data_arr = contentDic[@"goods_comment"];
    }else{
        [NSObject showHudTipStr:@"暂无评论"];
    }
    [self.myTableView reloadData];
}

- (NSMutableArray *)data_arr {
    if (_data_arr == nil) {
        _data_arr = [NSMutableArray array];
    }
    return _data_arr;
}

- (id)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] init];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.backgroundColor = [UIColor whiteColor];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self addSubview:tableView];
            [tableView registerNib:[UINib nibWithNibName:@"Ping_Jia_Cell" bundle:nil] forCellReuseIdentifier:@"Ping_Jia_Cell"];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
            tableView;
        });
    }
    return self;
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data_arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.data_arr.count > 0) {
        PingLun_MTL *pinglun = [PingLun_MTL modelObjectWithDictionary:self.data_arr[indexPath.row]];
        CGRect rect = [pinglun.content boundingRectWithSize:CGSizeMake(kScreen_Width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        return 70 + rect.size.height;
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Ping_Jia_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Ping_Jia_Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.data_arr.count > 0) {
        cell.pinglun = [PingLun_MTL modelObjectWithDictionary:self.data_arr[indexPath.row]];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    return cell;
}

@end
