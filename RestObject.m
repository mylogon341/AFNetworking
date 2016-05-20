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

@implementation NSString (NSString_Extended)

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end
@implementation RestObject

-(instancetype)initWithRestType:(NSInteger)type{
    self = [super init];
    self.restType = type;
    self.urlAttributes = [NSMutableDictionary dictionary];
    return self;
}

+(instancetype)withRestType:(NSInteger)type{
    return [[RestObject alloc]initWithRestType:type];
}

-(void)addAttWithKey:(NSString *)key andValue:(NSString *)value{
    [self.urlAttributes setValue:value forKey:key];
}

-(NSString*)getFullAtt{
    NSMutableString* att = [[NSMutableString alloc]initWithString:@"?"];
    
    for (NSString *key in self.urlAttributes.allKeys) {
        if (att.length > 1) {
            [att appendString:@"&"];
        }

        [att appendString:[NSString stringWithFormat:@"%@=%@",key,[[self.urlAttributes valueForKey:key] urlencode]]];
    }
    return [att copy];
}

-(NSString *)getFullAddress{
    
    if (!self.baseUrl) {
        self.baseUrl = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_GLOBAL_BASE];
    }
    
    NSString * attString = [self getFullAtt];
    
    if ([[attString substringToIndex:1] isEqualToString:@"?"] &&
        [[self.baseUrl substringFromIndex:1]isEqualToString:@"/"]) {
        
        self.baseUrl = [self.baseUrl substringToIndex:self.baseUrl.length-1];
        
    }else if (![[self.baseUrl substringFromIndex:self.baseUrl.length-1]isEqualToString:@"/"] &&
              ![[attString substringToIndex:1] isEqualToString:@"?"]){
        
        self.baseUrl = [self.baseUrl stringByAppendingString:@"/"];
    }
    
    return [NSString stringWithFormat:@"%@%@",self.baseUrl,attString];
}

-(void)setHeaderKey:(NSString *)key andValue:(NSString *)value{
    
    if (!_httpHeaders) {
        _httpHeaders = [NSMutableDictionary dictionary];
    }
    [_httpHeaders setValue:value forKey:key];
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

        NSDictionary * headers = [coder decodeObjectForKey:KEY_Headers];
        for (NSString * key in headers.allKeys) {
            [self setValue:[headers valueForKey:key] forKey:key];
        }
        
        self.baseUrl = [coder decodeObjectForKey:KEY_BaseURL];
        self.urlAttributes = [coder decodeObjectForKey:KEY_URLAtt];
        self.object = [coder decodeObjectForKey:KEY_Serial_OBJ];
        self.body = [coder decodeObjectForKey:KEY_BODY];
        self.restType = [coder decodeIntegerForKey:KEY_Rest_Type];
    }
    return self;
}

@end

