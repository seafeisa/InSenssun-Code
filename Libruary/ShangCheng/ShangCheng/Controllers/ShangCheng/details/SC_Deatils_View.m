//
//  SC_Deatils_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "SC_Deatils_View.h"

@interface SC_Deatils_View ()
@property (strong, nonatomic)UIWebView *myWebVIew;
@end

@implementation SC_Deatils_View

- (void)setContentDic:(NSMutableDictionary *)contentDic {
    _contentDic = contentDic;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:contentDic[@"url"]]];
    [self.myWebVIew loadRequest:request];
}

- (id)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        
//        [self beginLoading];
        self.myWebVIew = [[UIWebView alloc]init];
        self.myWebVIew.scalesPageToFit = YES;
        [self addSubview:self.myWebVIew];
        [self.myWebVIew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
