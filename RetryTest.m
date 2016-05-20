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
    [DoTheRest setGlobalBaseUrl:@"http://jobs.hodgson-sayers.co.uk:3000/parse"];
    [DoTheRest setGlobalHeaderKey:@"X-Parse-Master-Key" andValue:@"ULkcYeFfNCpR8qipXptmrwv7JKKF2JJW4ynNOvz0"];
    [DoTheRest setGlobalHeaderKey:@"X-Parse-REST-API-Key" andValue:@"46oqwMG9epRfB753H06PvP2wgpvxeftXfKpjvUqt"];
    [DoTheRest setGlobalHeaderKey:@"X-Parse-Application-Id" andValue:@"YtvY2vhKEWIma6CXzgYf5N1hIvYOu2sKmYy4OS0k"];
    [DoTheRest setGlobalHeaderKey:@"Content-Type" andValue:@"application/json"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGet{
    
    __block BOOL done;
    
    RestObject * obj = [RestObject withRestType:PUT];
    [obj setEndPoint:@"users/TBgYCHxSsk"];
    [obj setBodyObject:@{
                         @"inUserTeam": @{
                                 @"__type": @"Pointer",
                                 @"className": @"_User",
                                 @"objectId": @"TBgYCHxSsk"
                                 }
                         }];
    
    [DoTheRest sendRestObject:obj
                     response:^(id returned){
                         
                         done = YES;
                     }error:^(NSError* err){
                         done = YES;
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
