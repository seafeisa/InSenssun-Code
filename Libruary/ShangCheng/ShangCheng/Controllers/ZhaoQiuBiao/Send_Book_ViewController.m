//
//  Send_Book_ViewController.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/19.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Send_Book_ViewController.h"
#import "Book_TableViewCell.h"

@interface Send_Book_ViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController * imagePicker;
    
    NSString *imageName;
}

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;

@end

@implementation Send_Book_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发布";
    
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        
        [tableView registerNib:[UINib nibWithNibName:@"Book_TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Book_TableViewCell"];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    
    imageName = @"";
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 800;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Book_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_TableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.addPicture_Block = ^{
        [self.view endEditing:YES];
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
    };
    cell.SendBook_Block = ^(NSString *title, NSString *content, NSString *is_zhao, NSString *fbz, NSString *link_tel) {
        [self.view endEditing:YES];
        if (!imageName || imageName.length == 0 || [imageName isEqualToString:@""]) {
            [NSObject showHudTipStr:@"请上传标书图片"];
            return;
        }
        [self.view beginLoading];
        [[APPNetAPIManager sharedManager]request_releasebiao_WithTitle:title content:content is_zhao:is_zhao fbz:fbz link_tel:link_tel photo:imageName id:[Login_Total curLoginUser].id andBlock:^(id data, NSError *error) {
            [self.view endLoading];
            if (data) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    };
    return cell;
}

#pragma mark 从摄像头获取活动图片
- (void)pickImageFromCamera
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:imagePicker animated:YES completion:nil];
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

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.view endLoading];
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    Book_TableViewCell *cell = (Book_TableViewCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.picture_image.image = image;
    NSData *data = UIImageJPEGRepresentation(image, 0.25);
    NSString *image64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    imageName = image64;
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
