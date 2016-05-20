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

@interface RestObject : NSObject

/**Dictionary of key:values*/
@property (nonatomic, strong) NSMutableDictionary *httpHeaders;

/**https://nine.testworks.co.uk/api*/
@property (nonatomic, strong) NSString *baseUrl;

/**?group=test&name=luke*/
@property (nonatomic, strong) NSMutableDictionary *urlAttributes;

/**Could be a dictionary or whatever needs serialising*/
@property (nonatomic, strong) id object;

/**Body of call*/
@property (nonatomic, strong) NSString *body;

@property (nonatomic) NSInteger restType;

/**Takes an enum REST_TYPE*/
+(instancetype)withRestType:(NSInteger)type;

-(void)setHeaderKey:(NSString*)key andValue:(NSString*)value;

/**key value for, say ?text=mytext or &height=12*/
-(void)addAttWithKey:(NSString*)key andValue:(NSString*)value;

-(NSString *)getFullAddress;

@end
