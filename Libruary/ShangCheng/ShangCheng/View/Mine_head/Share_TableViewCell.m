//
//  Share_TableViewCell.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/6/5.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Share_TableViewCell.h"

@interface Share_TableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;

@end

@implementation Share_TableViewCell

- (void)setImage:(NSString *)image {
    _image = image;
    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageWithColor:MainColor]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)shsre_button:(id)sender {
    if (self.share_block) {
        self.share_block();
    }
}

- (IBAction)down_button:(id)sender {
    [self beginLoading];
    [self loadImageFinished:self.icon_image.image];
    
}

- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [self endLoading];
    [NSObject showHudTipStr:@"已保存到相册"];
    DebugLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

@end
