//
//  APPNetAPIClient.m
//  ShangCheng
//
//  Created by 黄单单 on 2017/3/15.
//  Copyright © 2017年 黄单单. All rights reserved.
//

#import "APPNetAPIClient.h"

#define kNetworkMethodName @[@"Get", @"Post", @"Put", @"Delete"]

@implementation APPNetAPIClient

static APPNetAPIClient *_sharedClient = nil;
static dispatch_once_t onceToken;

+ (APPNetAPIClient *)sharedJsonClient {
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APPNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSObject baseURLStr]]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    self.securityPolicy.allowInvalidCertificates = YES;
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    DebugLog(@"\n======request later======\n %@\n %@\n %@", kNetworkMethodName[method], aPath, params);
    aPath = [aPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    switch (method) {
        case Get:
        {
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [self GET:aPath
           parameters:params
             progress:^(NSProgress * _Nonnull downloadProgress) {
                 ;
             }
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  DebugLog(@"\n====== response success ======\n %@\n %@", aPath, responseObject);
                  [NSObject handleResponse:responseObject];
                  block(responseObject, nil);
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DebugLog(@"\n====== response failure ======\n %@\n %@\n %@", aPath, error, task.taskDescription);
                  !autoShowError || [NSObject showError:error];
                  block(nil, error);
              }];
            
            break;
        }
            
        case Post:
        {
            [self POST:aPath
            parameters:params
              progress:^(NSProgress * _Nonnull uploadProgress) {
                  ;
              }
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                   DebugLog(@"\n====== response success ======\n %@\n %@", aPath, dic);
                   [NSObject handleResponse:dic];
                   block(dic, nil);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   DebugLog(@"\n====== response failure ======\n %@\n %@\n %@", aPath, error, task.taskDescription);
                   !autoShowError || [NSObject showError:error];
                   block(nil, error);
               }];
            break;
        }
        default:
            break;
    }
}

- (void)requestAliJsonDataWithPath:(NSString *)aPath
                        withParams:(NSDictionary*)params
                    withMethodType:(NetworkMethod)method
                     autoShowError:(BOOL)autoShowError
                          andBlock:(void (^)(id data, NSError *error))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    DebugLog(@"\n======request later======\n %@\n %@\n %@", kNetworkMethodName[method], aPath, params);
    aPath = [aPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    switch (method) {
        case Get:
        {
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [self GET:aPath
           parameters:params
             progress:^(NSProgress * _Nonnull downloadProgress) {
                 ;
             }
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  if (responseObject != nil) {
                      responseObject = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  }
                  DebugLog(@"\n====== response success ======\n %@\n %@", aPath, responseObject);
                  [NSObject handleResponse:responseObject];
                  block(responseObject, nil);
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DebugLog(@"\n====== response failure ======\n %@\n %@\n %@", aPath, error, task.taskDescription);
                  !autoShowError || [NSObject showError:error];
                  block(nil, error);
              }];
            
            break;
        }
            
        case Post:
        {
            [self POST:aPath
            parameters:params
              progress:^(NSProgress * _Nonnull uploadProgress) {
                  ;
              }
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if (responseObject != nil) {
                       responseObject = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                   }
                   DebugLog(@"\n====== response success ======\n %@\n %@", aPath, responseObject);
                   block(responseObject, nil);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   DebugLog(@"\n====== response failure ======\n %@\n %@\n %@", aPath, error, task.taskDescription);
                   !autoShowError || [NSObject showError:error];
                   block(nil, error);
               }];
            break;
        }
        default:
            break;
    }
}

- (void)uploadImage:(NSString *)aPath
         withParams:(NSDictionary *)params
          imageData:(NSArray *)imageDataArr
     withMethodType:(NetworkMethod)method
            success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
            failuer:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    switch (method) {
        case Post:
        {
            [self POST:aPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                //                [imageDataArr bk_each:^(id obj) {
                //                    if (obj) {
                //                        [formData appendPartWithFileData:obj name:[NSString stringWithFormat:@"uploadImage"] fileName:[NSString stringWithFormat:@"jpg"] mimeType:@"image/jpg"];
                //                    }
                //                }];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                //                DebugLog(@"图片上传进度");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseObject != nil) {
                    responseObject = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                }
                if (responseObject != nil) {
                    responseObject = [NSJSONSerialization JSONObjectWithData:[responseObject dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                }
                DebugLog(@"\n====== response success ======\n %@\n %@", aPath, responseObject);
                success(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\n====== response failure ======\n %@\n %@\n %@", aPath, error, task.taskDescription);
                [NSObject showError:error];
                failure(nil, error);
            }];
        }
            break;
        default:
            break;
    }
}

@end
