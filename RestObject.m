//
//  RetryObject.m
//  AFNetworking
//
//  Created by Luke Sadler on 11/05/2016.
//  Copyright © 2016 AFNetworking. All rights reserved.
//

#import "RestObject.h"
#import "DoTheRest.h"

#define KEY_Headers @"headers"
#define KEY_BaseURL @"baseurl"
#define KEY_URLAtt @"urlAtt"
#define KEY_Serial_OBJ @"obj"
#define KEY_BODY @"body"
#define KEY_Rest_Type @"type"

@implementation RestObject

-(NSString *)getFullAddress{
    
    if (!self.baseUrl) {
        self.baseUrl = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_GLOBAL_BASE];
    }
    
    if ([[self.urlAttributes substringToIndex:1] isEqualToString:@"?"] &&
        [[self.baseUrl substringFromIndex:1]isEqualToString:@"/"]) {
        
        self.baseUrl = [self.baseUrl substringToIndex:self.baseUrl.length-1];
        
    }else if (![[self.baseUrl substringFromIndex:self.baseUrl.length-1]isEqualToString:@"/"]){
        
        self.baseUrl = [self.baseUrl stringByAppendingString:@"/"];
    }
    
    return [NSString stringWithFormat:@"%@%@",self.baseUrl,self.urlAttributes];
}

#pragma mark - De/Encoding objects for NSUserDefaults
- (void)encodeWithCoder:(NSCoder *)coder{
    
    [coder encodeObject:self.httpHeaders forKey:KEY_Headers];
    [coder encodeObject:self.baseUrl forKey:KEY_BaseURL];
    [coder encodeObject:self.urlAttributes forKey:KEY_URLAtt];
    [coder encodeObject:self.object forKey:KEY_Serial_OBJ];
    [coder encodeObject:self.body forKey:KEY_BODY];
    [coder encodeInteger:self.restType forKey:KEY_Rest_Type];
}

- (id)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self != nil)
    {
        self.httpHeaders = [coder decodeObjectForKey:KEY_Headers];
        self.baseUrl = [coder decodeObjectForKey:KEY_BaseURL];
        self.urlAttributes = [coder decodeObjectForKey:KEY_URLAtt];
        self.object = [coder decodeObjectForKey:KEY_Serial_OBJ];
        self.body = [coder decodeObjectForKey:KEY_BODY];
        self.restType = [coder decodeIntegerForKey:KEY_Rest_Type];
    }
    return self;
}

@end

