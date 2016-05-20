//
//  DoTheRest.m
//  AFNetworking
//
//  Created by Luke Sadler on 12/05/2016.
//  Copyright © 2016 AFNetworking. All rights reserved.
//

#import "DoTheRest.h"
#import "AFHTTPSessionManager.h"

#define KEY_GLOBAL_HEADERS @"globalHeadersDict"

@implementation DoTheRest

#pragma mark read/write global settings
+(void)setGlobalBaseUrl:(NSString *)url{
    [[NSUserDefaults standardUserDefaults]setObject:url forKey:KEY_GLOBAL_BASE];
}

+(void)removeGlobalBaseUrl{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:KEY_GLOBAL_BASE];
}

+(void)setGlobalHeaderKey:(NSString *)key andValue:(NSString *)value{
    
    NSMutableDictionary * headers = [[[NSUserDefaults standardUserDefaults]objectForKey:KEY_GLOBAL_HEADERS] mutableCopy];
    if (!headers) {
        headers = [NSMutableDictionary dictionary];
    }
    
    [headers setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults]setObject:headers forKey:KEY_GLOBAL_HEADERS];
}

+(void)removeGlobalHeaders{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:KEY_GLOBAL_HEADERS];
}

+(void)addOnGlobalHeaders:(AFHTTPSessionManager*)manager{
    NSDictionary * headers = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_GLOBAL_HEADERS];
    
    for (NSString * key in headers.allKeys) {
        [manager.requestSerializer setValue:[headers valueForKey:key] forHTTPHeaderField:key];
    }
}

#pragma mark -

+(AFHTTPSessionManager*)getManagerWithObject:(RestObject*)obj{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self addOnGlobalHeaders:manager];
    
    for (NSString* key in obj.httpHeaders.allKeys) {
        [manager.requestSerializer setValue:[obj.httpHeaders valueForKey:key]
                         forHTTPHeaderField:key];
    }
    return manager;
}


+(void)sendRestObject:(RestObject *)obj response:(void (^)(id))response error:(void (^)(NSError *))error{
    
    AFHTTPSessionManager * manager = [self getManagerWithObject:obj];
    
    switch (obj.restType) {
        case GET:
        {
            [manager GET:[obj getFullAddress]
              parameters:obj.bodyObject
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
        case PUT:
        {
            [manager PUT:[obj getFullAddress]
              parameters:obj.bodyObject
                 success:^(NSURLSessionDataTask * task, id ob){
                     response(ob);
                 }failure:^(NSURLSessionDataTask * task, NSError * err){
                     error(err);
                 }];
        }
            break;
        case DELETE:
        {
            [manager DELETE:[obj getFullAddress]
                 parameters:obj.bodyObject
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


+(void)sendRestObjectEventually:(RestObject *)obj{
    
    if (obj.restType == GET) {
        NSLog(@"\n\nUNABLE TO GET EVENTUALLY\n\n");
        return;
    }
    
    AFHTTPSessionManager * manager = [self getManagerWithObject:obj];
    
    
    switch (obj.restType) {
        case POST:
        {
            [manager POST:[obj getFullAddress]
               parameters:nil
constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
    //TODO test this
    formData = obj.objectToPost;
}
                 progress:nil
                  success:^(NSURLSessionDataTask * task, id ob){
                      
                  }failure:^(NSURLSessionDataTask * task, NSError * err){
                      
                  }];
        }
            break;
        case PUT:
        {
            [manager PUT:[obj getFullAddress]
              parameters:obj.bodyObject
                 success:^(NSURLSessionDataTask * task, id ob){
                     
                 }failure:^(NSURLSessionDataTask * task, NSError * err){
                     
                 }];
        }
            break;
        case DELETE:
        {
            [manager DELETE:[obj getFullAddress]
                 parameters:obj.bodyObject
                    success:^(NSURLSessionDataTask * task, id ob){
                        
                    }failure:^(NSURLSessionDataTask * task, NSError * err){
                        
                    }];
        }
        default:
            break;
    }
}


@end
