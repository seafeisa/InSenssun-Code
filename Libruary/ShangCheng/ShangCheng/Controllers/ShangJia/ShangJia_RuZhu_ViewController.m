//
//  ShangJia_RuZhu_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/6.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "ShangJia_RuZhu_ViewController.h"
#import "ShangJia_RuZhu_Cell.h"
#import "HKImageClipperViewController.h"
#import "Check_TableViewCell.h"
#import "Web_ViewController.h"
#import "YaJin_ViewController.h"

@interface ShangJia_RuZhu_ViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    UIImagePickerController * imagePicker;
    
    NSString *tempPhoto;
    NSString *tempPicture;
    
    NSString *tempXinYong;
    NSString *tempKaihuxuke;
    
    BOOL IsPhoto;
    
    NSInteger photoIndex;
    
    NSString *tempTips;
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;

@end

@implementation ShangJia_RuZhu_ViewController

- (void)viewWillAppear:(BOOL)animated {
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title = @"商家申请入驻";
    
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        //Check_TableViewCell
        [tableView registerNib:[UINib nibWithNibName:@"ShangJia_RuZhu_Cell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShangJia_RuZhu_Cell"];
        [tableView registerNib:[UINib nibWithNibName:@"Check_TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Check_TableViewCell"];
        
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
    tempPicture = @"";
    tempTips = @"";
    tempXinYong = @"";
    tempKaihuxuke = @"";
    
    IsPhoto = YES;
    photoIndex = 0;
    
}

- (void)getData {
    [self.view beginLoading];
    NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"];
    if ([Login_Total curLoginUser].id) {
        [[APPNetAPIManager sharedManager]request_Login_WithPhone:[Login_Total curLoginUser].phone WithPwd:pwd andBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                if ([[Login_Total curLoginUser].sf_money integerValue] == 0 && [[Login_Total curLoginUser].is_ok isEqualToString:@"1"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"资料上传成功，缴纳保证金等待审核" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }]];
                    [alert addAction:[UIAlertAction actionWithTitle:@"去缴纳" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        YaJin_ViewController *vc = [[YaJin_ViewController alloc]init];
                        self.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                    }]];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    [self.myTableView reloadData];
                }
                if ([[Login_Total curLoginUser].is_ok isEqualToString:@"2"]) {
                    [self.view beginLoading];
                    [[APPNetAPIManager sharedManager]request_getcont_WithId:[Login_Total curLoginUser].id andBlock:^(id data, NSError *error) {
                        [self.view endLoading];
                        if (data) {
                            tempTips = data[@"cont"];
                            [self.myTableView reloadData];
                        }
                    }];
                }
                [self.myTableView reloadData];
            }
        }];
    }
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[Login_Total curLoginUser].is_ok isEqualToString:@"0"]){
        return 1100;
    }
    return kScreen_Height - 64 - 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[Login_Total curLoginUser].is_ok isEqualToString:@"0"]) {
        ShangJia_RuZhu_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangJia_RuZhu_Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.protocal_Block = ^{
            [self.view endEditing:YES];
            Web_ViewController *vc = [[Web_ViewController alloc]init];
            vc.url = @"http://tx.sebon.com.cn/index.php/home/shopxy/xydetail";
            vc.isProtocal = YES;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        cell.photo_shop_Block = ^{
            [self.view endEditing:YES];
//            IsPhoto = YES;
            photoIndex = 0;
            [self addPhoto];
        };
        cell.picture_Block = ^{
            [self.view endEditing:YES];
//            IsPhoto = NO;
            photoIndex = 1;
            [self addPhoto];
        };
        cell.xinyong_Block = ^{
            [self.view endEditing:YES];
//            IsPhoto = YES;
            photoIndex = 2;
            [self addPhoto];
        };
        cell.kaihuxuke_Block = ^{
            [self.view endEditing:YES];
//            IsPhoto = YES;
            photoIndex = 3;
            [self addPhoto];
        };
        cell.joinShop_Block = ^(NSString *shop_name, NSString *shop_desc, NSString *shop_linkman, NSString *shop_tel) {
            [self.view endEditing:YES];
            if (!tempPhoto || tempPhoto.length == 0 || [tempPhoto isEqualToString:@""]) {
                [NSObject showHudTipStr:@"请上传商家图片"];
                return;
            }
            if (!tempPicture || tempPicture.length == 0 || [tempPicture isEqualToString:@""]) {
                [NSObject showHudTipStr:@"请上传商家营业执照"];
                return;
            }
            if (!tempXinYong || tempXinYong.length == 0 || [tempXinYong isEqualToString:@""]) {
                [NSObject showHudTipStr:@"请上传商家信用机构代码证"];
                return;
            }
            if (!tempKaihuxuke || tempKaihuxuke.length == 0 || [tempKaihuxuke isEqualToString:@""]) {
                [NSObject showHudTipStr:@"请上传商家开户许可证"];
                return;
            }
            [self.view endEditing:YES];
            [self.view beginLoading];
            [[APPNetAPIManager sharedManager]request_shopRz_WithShop_name:shop_name shop_logo:tempPhoto shop_zhizhao:tempPicture shop_desc:shop_desc shop_linkman:shop_linkman shop_tel:shop_tel id:[Login_Total curLoginUser].id jgdaima:tempXinYong xukezheng:tempKaihuxuke andBlock:^(id data, NSError *error) {
                [self.view endLoading];
                if (data) {
                    [self getData];
                }
            }];
        };
        return cell;
    }
    Check_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Check_TableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[Login_Total curLoginUser].is_ok isEqualToString:@"1"]) {
        cell.icon_iamge.image = [UIImage imageNamed:@"normal_hui"];
        cell.content_textView.text = @"资料上传成功，缴纳保证金等待审核";
        cell.content_textView.font = [UIFont systemFontOfSize:16];
    }else{
        cell.icon_iamge.image = [UIImage imageNamed:@"select_lv"];
        cell.content_textView.text = tempTips;
    
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:tempTips];
        NSRange range = [tempTips rangeOfString:@"http://tx.sebon.com.cn/index.php/back/login/login.html"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
        [str addAttribute:NSLinkAttributeName value:@"http://tx.sebon.com.cn/index.php/back/login/login.html" range:range];
        cell.content_textView.attributedText = str;
    
        cell.content_textView.font = [UIFont systemFontOfSize:16];
    
    }
    return cell;
}

- (void)addPhoto {
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

#pragma mark 从用户相册获取活动图片
- (void)pickImageFromAlbum
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark 从摄像头获取活动图片
- (void)pickImageFromCamera
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - imagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = info[@"UIImagePickerControllerOriginalImage"];
    ShangJia_RuZhu_Cell *cell = (ShangJia_RuZhu_Cell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (photoIndex == 0) {
        cell.photo_shop_image.image = image;
        NSData *data = UIImageJPEGRepresentation(image, 0.25);
        NSString *image64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        tempPhoto = image64;
    }else if (photoIndex == 1){
        cell.picture_yingye_image.image = image;
        NSData *data = UIImageJPEGRepresentation(image, 0.25);
        NSString *image64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        tempPicture = image64;
    }else if (photoIndex == 2){
        cell.xinyong_image.image = image;
        NSData *data = UIImageJPEGRepresentation(image, 0.25);
        NSString *image64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        tempXinYong = image64;
    }else {
        cell.kaihuxuke_image.image = image;
        NSData *data = UIImageJPEGRepresentation(image, 0.25);
        NSString *image64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        tempKaihuxuke = image64;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
