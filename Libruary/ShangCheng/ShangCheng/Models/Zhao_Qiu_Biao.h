//
//  Zhao_Qiu_Biao.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/16.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Zhao_Qiu_Biao : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong)NSString *id, *title, *content, *img, *addtime, *is_zhao, *is_ok, *promulgator, *is_show, *browse_num, *link_tel, *url;

@end
