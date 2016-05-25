//
//  MCNetworkingLogin.m
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/31.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import "MCNetworkingLogin.h"

@implementation MCNetworkingLogin

+(void)postLogin:(NSString *)urlString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"token"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
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

+(void)getLogin:(NSString *)urlString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"token"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
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



/**
 *  上传带图片的内容，允许多张图片上传（URL）POST
 *
 *  @param url                 网络请求地址
 *  @param images              要上传的图片数组（注意数组内容需是图片）
 *  @param parameter           图片数组对应的参数
 *  @param parameters          其他参数字典
 *  @param ratio               图片的压缩比例（0.0~1.0之间）
 *  @param succeedBlock        成功的回调
 *  @param failedBlock         失败的回调
 *  @param uploadProgressBlock 上传进度的回调
 */
+(void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                     parameterOfimages:(NSString *)parameter
                        parametersDict:(NSDictionary *)parameters
                      compressionRatio:(float)ratio
                          succeedBlock:(void (^)(id, id))succeedBlock
                           failedBlock:(void (^)(id, NSError *))failedBlock
                   uploadProgressBlock:(void (^)(float, long long, long long))uploadProgressBlock{
    
    if (images.count == 0) {
        NSLog(@"上传内容没有包含图片");
        return;
    }
    for (int i = 0; i < images.count; i++) {
        if (![images[i] isKindOfClass:[UIImage class]]) {
            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
            return;
        }
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"token"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlString = [testUrlString stringByAppendingString:url];
    
    AFHTTPRequestOperation *operation = [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy_MM_dd"];
        NSString *dateString = [formatter stringFromDate:date];
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg",dateString,i];
            
            NSData *imageData;
            UIImage *img = [[UIImage alloc] init];
            
            if (ratio > 0.0f && ratio < 1.0f) {
                img = [image makeThumbnailFromImage:image scale:ratio];
            }else{
                img = [image makeThumbnailFromImage:image scale:1.0];
            }
            
//            img = [image scaleToSize:image size:CGSizeMake(<#CGFloat width#>, <#CGFloat height#>)]
            imageData = UIImageJPEGRepresentation(img, 1.0f);
            
            //image/jpg/png/jpeg
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@%d",parameter,i] fileName:fileName mimeType:@"image/jpeg"];
            i ++;
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succeedBlock(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        failedBlock(operation,error);
        
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat percent = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
        uploadProgressBlock(percent,totalBytesWritten,totalBytesExpectedToWrite);
    }];
    
}

@end
