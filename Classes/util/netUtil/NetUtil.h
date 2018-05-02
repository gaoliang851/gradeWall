//
//  NetUtil.h
//  gradeWallTest
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 NULL.gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetUtil : NSObject
+ (void)get:(NSString *)url
   success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable reponse))success
   failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
+ (void)post:(NSString *)url
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable response))success
     failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
@end
