//
//  SC_Things_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Things_View.h"
#import "Things_Content_Cell.h"
#import "SC_Login_ViewController.h"
#import "JZLCycleView.h"

@interface SC_Things_View ()<UITableViewDelegate, UITableViewDataSource,JZLCycleViewDelegate>{
    UIImageView *image;
    NSString *num;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *title_arr;
@property (nonatomic, weak) JZLCycleView *cycleView;

@end

@implementation SC_Things_View

- (NSArray *)title_arr {
    if (!_title_arr) {
        _title_arr = @[@"数量",@"运费"];
    }
    return _title_arr;
}

- (id)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        
        num = @"1";
        
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] init];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.backgroundColor = [UIColor whiteColor];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self addSubview:tableView];
            [tableView registerNib:[UINib nibWithNibName:@"Things_Content_Cell" bundle:nil] forCellReuseIdentifier:@"Things_Content_Cell"];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
            
            tableView;
        });
        
        [self addFootView];
    }
    return self;
}

- (void)setContentDic:(NSMutableDictionary *)contentDic {
    _contentDic = contentDic;
    [self.myTableView reloadData];
}

- (void)addFootView {
    UIView *bg = [[UIView alloc]init];
    bg.backgroundColor = [UIColor whiteColor];
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    NSArray *array = @[@"加入购物车",@"立即购买"];
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [button setTitle:array[i] forState:0];
        button.tag = i;
        [button addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
        [bg addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreen_Width / 2);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo((kScreen_Width / 2) * i);
        }];
        if (i == 0) {
            button.backgroundColor = [UIColor redColor];
        }else{
            button.backgroundColor = [UIColor yellowColor];
        }
    }
}

- (void)addCart:(UIButton *)btn {
    [self endEditing:YES];
    if ([Login_Total curLoginUser].id) {
        if (btn.tag == 0) {
            [self beginLoading];
            [[APPNetAPIManager sharedManager]request_addcart_WithMember_id:[Login_Total curLoginUser].id goods_id:self.contentDic[@"id"] goods_number:num andBlock:^(id data, NSError *error) {
                [self endLoading];
            }];
        }else{
            [self beginLoading];
            [[APPNetAPIManager sharedManager]request_buy_WithMember_id:[Login_Total curLoginUser].id goods_id:self.contentDic[@"id"] goods_number:num andBlock:^(id data, NSError *error) {
                [self endLoading];
                if (data) {
                    if (self.next_block) {
                        self.next_block(data);
                    }
                }
            }];
        }
    }else{
        if (self.addCart_Block) {
            self.addCart_Block();
        }
    }
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.title_arr.count + 2;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        NSString *str = self.contentDic[@"goods_name"];
        CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreen_Width - 25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        return 45 + rect.size.height;
    }
    if (indexPath.row == 0) {
        return kScreen_Width / 1.5;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        Things_Content_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Things_Content_Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentDic = self.contentDic;
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
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
    if (indexPath.row > 1) {
        cell.textLabel.text = self.title_arr[indexPath.row - 2];
    }
    if (indexPath.row == 0) {
        for (id sub in [self subviews]) {
            if ([sub isKindOfClass:[JZLCycleView class]]) {
                [sub removeFromSuperview];
            }
        }
        _cycleView = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width / 1.5) PlaceholderImage:[UIImage imageNamed:@"img_pro_xq.png"]];
        _cycleView.pageControl.pageIndicatorTintColor = [UIColor orangeColor];
        _cycleView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _cycleView.delegate = self;
        _cycleView.imageArray = self.contentDic[@"pic"];
        [cell addSubview:_cycleView];
    }
    if (indexPath.row == 2) {
        for (id sub in [cell subviews]) {
            if ([sub isKindOfClass:[UIView class]]) {
                UIView *view = (UIView *)sub;
                if (view.tag == 101) {
                    [view removeFromSuperview];
                }
            }
        }
        UIView *bg = [[UIView alloc]init];
        bg.tag = 101;
        [cell addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(40);
        }];
        UIButton *jian_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [jian_button setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:0];
        [jian_button addTarget:self action:@selector(changeNum:) forControlEvents:UIControlEventTouchUpInside];
        [bg addSubview:jian_button];
        [jian_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(0.35 * 120);
        }];
        UIButton *jia_button = [UIButton buttonWithType:UIButtonTypeCustom];
        jian_button.tag = 1;
        jia_button.tag = 2;
        [jia_button setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:0];
        [jia_button addTarget:self action:@selector(changeNum:) forControlEvents:UIControlEventTouchUpInside];
        [bg addSubview:jia_button];
        [jia_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(0.35 * 120);
        }];
        
        UITextField *text_field = [[UITextField alloc]init];
        text_field.font = [UIFont systemFontOfSize:13];
        text_field.tag = 3;
        text_field.text = @"1";
        [text_field addTarget:self action:@selector(updateNum:) forControlEvents:UIControlEventEditingChanged];
        text_field.keyboardType = UIKeyboardTypeNumberPad;
        text_field.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:text_field];
        [text_field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0.35 * 120);
            make.right.mas_equalTo(- 0.35 * 120);
        }];
    }
    if (indexPath.row == 3) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@",self.contentDic[@"goods_yfprice"]];
    }
    
    return cell;
}

- (void)updateNum:(UITextField *)textField {
    num = textField.text;
}

- (void)changeNum:(UIButton *)btn {
    [self endEditing:YES];
    UITextField *text_field = [[btn superview] viewWithTag:3];
    NSInteger i = [text_field.text integerValue];
    if (btn.tag == 1) {
        if (i == 1) {
            return;
        }
        i --;
    }else{
        i ++;
    }
    text_field.text = [NSString stringWithFormat:@"%zd",i];
    num = text_field.text;
}

//代理跳转
- (void)selectItemAtIndex:(NSInteger)index {
    DebugLog(@"%zd",index);
}


@end
