//
//  Forget_Psw_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/18.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Forget_Psw_ViewController.h"
#import "Forget_Psw_TableViewCell.h"

@interface Forget_Psw_ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    BOOL timeStart;
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;

@end

@implementation Forget_Psw_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"忘记密码";
    
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        
        [tableView registerNib:[UINib nibWithNibName:@"Forget_Psw_TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Forget_Psw_TableViewCell"];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    timeStart = NO;
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 310;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Forget_Psw_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Forget_Psw_TableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak Forget_Psw_TableViewCell *weakCell = cell;
    cell.code_Block = ^(NSString *phone){
        [self.view beginLoading];
        [[APPNetAPIManager sharedManager]request_Duanxin_WithPhone:phone andBlock:^(id data, NSError *error) {
            [self.view endLoading];
            __strong Forget_Psw_TableViewCell *strongCell = weakCell;
            if (data) {
                if ([data[@"ErrorCode"]integerValue] == 0000) {
                    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:strongCell.code_button repeats:YES];
                    timeStart = YES;
                }
            }
        }];
    };
    cell.complete_Block = ^(NSString *phone, NSString *code, NSString *psw) {
        [self.view beginLoading];
        [[APPNetAPIManager sharedManager]request_xgpwd_WithPhone:phone pwd:psw code:code andBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                [NSObject showHudTipStr:@"密码已修改完成"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    };
    return cell;
}

#pragma mark  计时器
- (void)timerFireMethod:(NSTimer *)theTimer
{
    UIButton *btn = (UIButton *)theTimer.userInfo;
    
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDateComponents *endTime = [[NSDateComponents alloc] init];    //初始化目标时间...
    NSDate *today = [NSDate date];    //得到当前时间
    
    NSDate *date = [NSDate dateWithTimeInterval:60 sinceDate:today];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    static int year;
    static int month;
    static int day;
    static int hour;
    static int minute;
    static int second;
    if(timeStart) {//从NSDate中取出年月日，时分秒，但是只能取一次
        year = [[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
        month = [[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
        day = [[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
        hour = [[dateString substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[dateString substringWithRange:NSMakeRange(14, 2)] intValue];
        second = [[dateString substringWithRange:NSMakeRange(17, 2)] intValue];
        timeStart= NO;
    }
    
    [endTime setYear:year];
    [endTime setMonth:month];
    [endTime setDay:day];
    [endTime setHour:hour];
    [endTime setMinute:minute];
    [endTime setSecond:second];
    NSDate *todate = [cal dateFromComponents:endTime]; //把目标时间装载入date
    
    //用来得到具体的时差，是为了统一成北京时间
    unsigned int unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute| NSCalendarUnitSecond;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    NSString *fen = [NSString stringWithFormat:@"%ld", (long)[d minute]];
    if([d minute] < 10) {
        fen = [NSString stringWithFormat:@"0%ld",(long)[d minute]];
    }
    NSString *miao = [NSString stringWithFormat:@"%ld", (long)[d second]];
    if([d second] < 10) {
        miao = [NSString stringWithFormat:@"0%ld",(long)[d second]];
    }
    if ([d second] > 0) {
        [btn setTitle:[NSString stringWithFormat:@"%@s",miao] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.enabled = NO;
    }else if([d second] == 0) {
        //计时1分钟结束，do_something
        [btn setTitle:@"重新获取" forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.enabled = YES;
    } else{
        [theTimer invalidate];
    }
}

@end
