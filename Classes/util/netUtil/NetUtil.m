//
//  NetUtil.m
//  gradeWallTest
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 NULL.gao. All rights reserved.
//

#import "NetUtil.h"
#import "NSString+MD5Str.h"
#import <AFNetworking.h>
@implementation NetUtil
+(void)get:(NSString *)url
   success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable response))success
   failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager GET:url parameters:nil progress:nil success:success failure:failure];
}
+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable response))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    NSString* UnixTime = [NSString stringWithFormat:@"%ld",(long int)[[NSDate date] timeIntervalSince1970] * 1000];
    NSString* syncKey = [self encryptedDict:parameters withTime:UnixTime];
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [dict setValue:syncKey forKey:@"syncKey"];
    [dict setValue:UnixTime forKey:@"syncTime"];
    [manager POST:url parameters:dict progress:nil success:success failure:failure];
}


#pragma 加密相关
+(NSString*)encryptedDict:(NSDictionary*)param withTime:(NSString*)time{
    NSMutableDictionary* newParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [newParam setObject:time forKey:@"syncTime"];
    NSArray* paramKeys = [newParam allKeys];
    NSArray *newArray = [paramKeys sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString* paraStr = [NSMutableString string];
    for (NSString* str in newArray) {
        [paraStr appendFormat:@"%@%@",str,[newParam objectForKey:str]];
    }
    [paraStr appendString:@"69403C1B2C93F8D1"];
    //NSLog(@"加密前参数%@",paraStr);
    NSString* localStr = [NSString md5WithString:paraStr];
    //NSLog(@"加密后参数%@",localStr);
    return localStr;
}
@end
