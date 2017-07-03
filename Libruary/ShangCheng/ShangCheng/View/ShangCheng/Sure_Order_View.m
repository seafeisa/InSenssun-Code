//
//  Sure_Order_View.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/7.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "Sure_Order_View.h"

@interface Sure_Order_View ()

@end

@implementation Sure_Order_View
- (IBAction)return_button:(id)sender {
    if (self.return_block) {
        self.return_block();
    }
}


@end
