//
//  RetryController.h
//  AFNetworking
//
//  Created by Luke Sadler on 11/05/2016.
//  Copyright © 2016 AFNetworking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestObject.h"

@interface RetryController : NSObject

+(RetryController*)sharedInstance;

-(void)addRetryObject:(RestObject*)retry;

@end
