//
//  RetryTest.m
//  AFNetworking
//
//  Created by Luke Sadler on 12/05/2016.
//  Copyright © 2016 AFNetworking. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RestObject.h"
#import "RetryController.h"
#import "DoTheRest.h"

@interface RetryTest : XCTestCase

@end

@implementation RetryTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGet{
    
    __block BOOL done;
    
    RestObject * obj = [RestObject withRestType:GET];
    
//    https://ronreiter-meme-generator.p.mashape.com/meme?bottom=Bottom+text&font=Impact&font_size=50&meme=Condescending+Wonka&top=Top+text
    
    [obj setBaseUrl:@"https://yoda.p.mashape.com/yoda"];
    [obj addAttWithKey:@"sentence" andValue:@"This is a sentence"];
    
    [obj setHeaderKey:@"X-Mashape-Key" andValue:@"2cdhYEYUrfmshSQiI6FC2HbfEhcCp1Ey2wJjsnV3GHD35YdWWi"];
    [obj setHeaderKey:@"Content-Type" andValue:@"image/jpeg"];
     
    NSLog(@"%@",[obj getFullAddress]);
    [DoTheRest sendRestObject:obj
                     response:^(id returned){
                         NSLog(@"%@",returned);
                         UIImage * image = [UIImage imageWithData:returned];
                         NSLog(@"%@",image);
                         done = YES;
                     }error:^(NSError* err){
                         done = YES;
                         NSLog(@"%@",err.userInfo);
                         assert(!err);
                     }];
    
    while(!done) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
