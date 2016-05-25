//
//  MCNetworking.m
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/2.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import "MCNetworking.h"

@implementation MCNetworking


//POST网络请求
+ (void)POST:(NSString *)urlString
  parameters:(id)parameters
     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 防止解析不出来
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    urlString = [testUrlString stringByAppendingString:urlString];
    [manager POST:urlString
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(operation, responseObject);

              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(operation, error);
              }
          }];
}

//GET网络请求
+ (void)GET:(NSString *)urlString
 parameters:(id)parameters
    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 防止解析不出来
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    urlString = [testUrlString stringByAppendingString:urlString];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(operation, responseObject);

        }
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure) {
                 failure(operation, error);
             }
         }];
}


@end
