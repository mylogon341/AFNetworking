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
    
    RestObject * obj = [RestObject new];
    [obj setRestType:GET];
    [obj setBaseUrl:@"http://learningdashboard.northumbria.nhs.uk/api/api"];
    [obj setUrlAttributes:@"Employee/listall"];
    
    [DoTheRest sendRestObject:obj
                     response:^(id returned){
                         done = YES;
                     }error:^(NSError* err){
                         done = YES;
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
