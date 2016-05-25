//
//  MCNetworking.h
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/2.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface MCNetworking : NSObject

+ (void)POST:(NSString *)urlString
  parameters:(id)parameters
     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)GET:(NSString *)urlString
 parameters:(id)parameters
    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
