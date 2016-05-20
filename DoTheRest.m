//
//  DoTheRest.m
//  AFNetworking
//
//  Created by Luke Sadler on 12/05/2016.
//  Copyright © 2016 AFNetworking. All rights reserved.
//

#import "DoTheRest.h"
#import "AFHTTPSessionManager.h"

@implementation DoTheRest

+(void)setGlobalBaseUrl:(NSString *)url{
    [[NSUserDefaults standardUserDefaults]setObject:url forKey:KEY_GLOBAL_BASE];
}

+(void)removeGlobalBaseUrl{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:KEY_GLOBAL_BASE];
}

+(AFHTTPSessionManager *)getManager{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
//    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
//    manager.responseSerializer = responseSerializer;
    
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"image/jpeg",@"text/html",nil]];
    
    return manager;
}

+(void)sendRestObject:(RestObject *)obj response:(void (^)(id))response error:(void (^)(NSError *))error{

    AFHTTPSessionManager * manager = [self getManager];
    
    for (NSString* key in obj.httpHeaders.allKeys) {
        [manager.requestSerializer setValue:[obj.httpHeaders valueForKey:key]
                         forHTTPHeaderField:key];
    }
    switch (obj.restType) {
        case GET:
        {
         [manager GET:[obj getFullAddress]
                     parameters:nil
                       progress:nil
                        success:^(NSURLSessionDataTask * task, id ob){
                            response(ob);
                        }failure:^(NSURLSessionDataTask * task, NSError * err){
                            error(err);
                        }];
        }
            break;
         case POST:
        {
            [manager POST:[obj getFullAddress]
               parameters:nil
constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
    
}
                 progress:nil
                  success:^(NSURLSessionDataTask * task, id ob){
                      response(ob);
                  }failure:^(NSURLSessionDataTask * task, NSError * err){
                      error(err);
                  }];
        }
            break;
        default:
            break;
    }
}



@end
