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
@property (nonatomic, strong) NSString *endPoint;

/***/
@property (nonatomic, strong) NSMutableDictionary *urlAttributes;

/**Could be a dictionary or whatever needs serialising*/
@property (nonatomic, strong) id bodyObject;

///**Body of call. Stored as a dictionar*/
//@property (nonatomic, strong) NSString *body;

@property (nonatomic) NSInteger restType;

/**Post object*/
@property (nonatomic, strong) id objectToPost;

/**Takes an enum REST_TYPE*/
+(instancetype)withRestType:(NSInteger)type;

/**Headers for the request*/
-(void)setHeaderKey:(NSString*)key andValue:(NSString*)value;

/**key value for, say ?text=mytext or &height=12*/
-(void)setAttWithKey:(NSString*)key andValue:(NSString*)value;

-(NSString *)getFullAddress;


@end
