//
//  Mine_Account_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/4.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Mine_Account_ViewController.h"
#import "Mine_Account_Cell.h"
#import "Change_Info_ViewController.h"
#import "SC_Login_ViewController.h"
#import "SDImageCache.h"
#import "Member_ViewController.h"
#import "Change_Phone_ViewController.h"

@interface Mine_Account_ViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController *imagePicker;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)NSArray *title_arr;
@property (nonatomic,strong)NSArray *details_arr;

@end

@implementation Mine_Account_ViewController

- (NSArray *)title_arr {
    if (!_title_arr) {
        _title_arr = @[@"手机号",@"昵称",@"会员等级"];
    }
    return _title_arr;
}

- (NSArray *)details_arr {
    if (!_details_arr) {
        _details_arr = @[@"158****8798\t",@"葱根绿的小白菜",@"黄钻"];
    }
    return _details_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"账户管理";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"Mine_Account_Cell" bundle:nil] forCellReuseIdentifier:@"Mine_Account_Cell"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49.f, 0);
        tableView.contentInset = insets;
        tableView.scrollIndicatorInsets = insets;
        tableView.tableFooterView = [self customFootView];
        tableView;
    });
}

- (UIView *)customFootView {
    UIView *bg = [[UIView alloc]init];
    bg.frame = CGRectMake(0, 0, kScreen_Width, 100);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"退出登录" forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.backgroundColor = MainColor;
    [btn addTarget:self action:@selector(resignLogin) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreen_Width - 100);
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    return bg;
}

- (void)resignLogin {
    [Login_Total delete_LoginDta];
    SC_Login_ViewController *vc = [[SC_Login_ViewController alloc]init];
    vc.IsQuitLogin = YES;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.title_arr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 80.f : 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Mine_Account_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_Account_Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.iconImage = [Login_Total curLoginUser].touxiang;
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = [UIColor hexStringToColor:@"#eeeeee"];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
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
    cell.textLabel.text = self.title_arr[indexPath.row - 1];
    if (indexPath.row == 1) {
        if ([Login_Total curLoginUser].phone) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[Login_Total curLoginUser].phone];
        }
    }
    if (indexPath.row == 2) {
        if ([Login_Total curLoginUser].nicheng) {
            cell.detailTextLabel.text = [Login_Total curLoginUser].nicheng;
        }
    }
    if (indexPath.row == 3) {
        if ([Login_Total curLoginUser].is_money) {
            if ([[Login_Total curLoginUser].is_money intValue] == 0) {
                cell.detailTextLabel.text = @"普通会员";
            }else if ([[Login_Total curLoginUser].is_money intValue] == 1){
                cell.detailTextLabel.text = @"充值会员";
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        Change_Info_ViewController *vc = [[Change_Info_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        vc.get_info_Block = ^(NSString *info) {
            [self.myTableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pickImageFromCamera];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pickImageFromAlbum];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if (indexPath.row == 1) {
        Change_Phone_ViewController *vc = [[Change_Phone_ViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
//    if (indexPath.row == 3) {
//        Member_ViewController *vc = [[Member_ViewController alloc]init];
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

#pragma mark 从摄像头获取活动图片
- (void)pickImageFromCamera
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark 从用户相册获取活动图片
- (void)pickImageFromAlbum
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.view endLoading];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSData* imageData = UIImageJPEGRepresentation(image, 0.08);
    NSString *image64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [self.view beginLoading];
    [[APPNetAPIManager sharedManager]request_updatetx_Withid:[Login_Total curLoginUser].id photo:image64 andBlock:^(id data, NSError *error) {
        if (data) {
            [[APPNetAPIManager sharedManager]request_Login_WithPhone:[Login_Total curLoginUser].phone WithPwd:[[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"] andBlock:^(id data, NSError *error) {
                [self.view endLoading];
                if (data) {
                    [self.myTableView reloadData];
                }
            }];
        }
    }];
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
