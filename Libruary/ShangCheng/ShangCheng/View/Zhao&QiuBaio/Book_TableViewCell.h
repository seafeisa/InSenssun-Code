//
//  Book_TableViewCell.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/4/19.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Book_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture_image;
@property (nonatomic,copy)void(^addPicture_Block)();
@property (nonatomic,copy)void(^SendBook_Block)(NSString *title,NSString *content,NSString *is_zhao,NSString *fbz,NSString *link_tel);
@end
