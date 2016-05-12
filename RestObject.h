//
//  RetryObject.h
//  AFNetworking
//
//  Created by Luke Sadler on 11/05/2016.
//  Copyright © 2016 AFNetworking. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    GET,
    POST,
    DELETE,
    PUT
} REST_TYPE;

@interface RetryObject : NSObject

/**Array of dictionaries with key:value for http header*/
@property (nonatomic, strong) NSMutableArray *httpHeaders;

/**https://nine.testworks.co.uk/api*/
@property (nonatomic, strong) NSString *baseUrl;

/**?group=test&name=luke*/
@property (nonatomic, strong) NSString *urlAttributes;

/**Could be a dictionary or whatever needs serialising*/
@property (nonatomic, strong) id object;

/**Body of call*/
@property (nonatomic, strong) NSString *body;

/**Takes an enum REST_TYPE*/
@property (nonatomic) NSInteger restType;

@end
