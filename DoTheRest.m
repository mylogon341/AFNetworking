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

+(void)sendRestObject:(RestObject *)obj response:(void (^)(id))response error:(void (^)(NSError *))error{
    
    switch (obj.restType) {
        case GET:
        {
         [[self getManager] GET:[obj getFullAddress]
                     parameters:nil
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


+(AFHTTPSessionManager*)getManager{
    return [AFHTTPSessionManager manager];
}


@end
