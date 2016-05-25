//
//  MCNetworkingLogin.h
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/31.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCNetworkingLogin : NSObject

+ (void)postLogin:(NSString *)urlString
  parameters:(id)parameters
     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)getLogin:(NSString *)urlString
 parameters:(id)parameters
    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;



+(void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                     parameterOfimages:(NSString *)parameter
                        parametersDict:(NSDictionary *)parameters
                      compressionRatio:(float)ratio
                          succeedBlock:(void(^)(id operation, id responseObject))succeedBlock
                           failedBlock:(void(^)(id operation, NSError *error))failedBlock
                   uploadProgressBlock:(void(^)(float uploadPercent,long long totalBytesWritten,long long totalBytesExpectedToWrite))uploadProgressBlock;
@end
