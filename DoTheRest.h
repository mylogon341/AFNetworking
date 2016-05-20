//
//  DoTheRest.h
//  AFNetworking
//
//  Created by Luke Sadler on 12/05/2016.
//  Copyright © 2016 AFNetworking. All rights reserved.
//
#import "RestObject.h"
#import "RetryController.h"
#import <Foundation/Foundation.h>

#define KEY_GLOBAL_BASE @"globalBase"

@interface DoTheRest : NSObject

+(void)sendRestObject:(RestObject*)obj response:(void(^)(id))response error:(void(^)(NSError*))error;

/**This will PUT, POST or DELETE as soon as it can. Handles failure well*/
+(void)sendRestObjectEventually:(RestObject*)obj;

/**Only use this is the app connects to one url*/
+(void)setGlobalBaseUrl:(NSString*)url;
+(void)removeGlobalBaseUrl;

/**Headers for the request*/
+(void)setGlobalHeaderKey:(NSString*)key andValue:(NSString*)value;
+(void)removeGlobalHeaders;


@end
