//
//  RetryController.m
//  AFNetworking
//
//  Created by Luke Sadler on 11/05/2016.
//  Copyright © 2016 AFNetworking. All rights reserved.
//

#import "RetryController.h"
#import "AFHTTPSessionManager.h"

@implementation RetryController


+(RetryController *)sharedInstance{
    
    static RetryController * retry;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        retry = [[RetryController alloc]init];
    });
    
    return retry;
}

-(void)addRetryObject:(RestObject *)retry{
    
    switch (retry.restType) {
        case GET:
            
            break;
        case PUT:
            
            break;
        case POST:
            
            break;
        case DELETE:
            
            break;
        default:
            break;
    }
}



@end
