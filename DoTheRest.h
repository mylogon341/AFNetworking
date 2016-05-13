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

/**Only use this is the app connects to one url*/
+(void)setGlobalBaseUrl:(NSString*)url;

+(void)removeGlobalBaseUrl;

@end
