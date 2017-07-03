//
//  APPNetAPIClient.h
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/15.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, NetworkMethod) {
    Get = 0,
    Post
};

@interface APPNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestAliJsonDataWithPath:(NSString *)aPath
                        withParams:(NSDictionary*)params
                    withMethodType:(NetworkMethod)method
                     autoShowError:(BOOL)autoShowError
                          andBlock:(void (^)(id data, NSError *error))block;

- (void)uploadImage:(NSString *)aPath
         withParams:(NSDictionary *)params
          imageData:(NSArray *)imageDataArr
     withMethodType:(NetworkMethod)method
            success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
            failuer:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
