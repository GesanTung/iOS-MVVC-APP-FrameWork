//
//  Message.m
//  AppCore
//
//  Created by Gesantung on 14-12-19.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import "Message.h"
#import <objc/runtime.h>
@implementation Message

+(id)Message{
    return [[self alloc]initMessaget];
}

-(id)initMessaget{
    self = [self init];
    if(self){
        [self loadMessage];
    }
    return self;
}

-(void)loadMessage{
    self.output = nil;
    self.discription = @"";
    self.progress = 0.0f;
    self.freezable = NO;
    self.SCHEME = @"";
    self.HOST = @"";
    self.PATH = @"";
    self.METHOD = @"GET";
}

- (BOOL)succeed
{
    if(self.output == nil){
        return NO;
    }
    return SuccessState == _state ? YES : NO;
}
- (BOOL)failed
{
    return FailState == _state || ErrorState == _state ? YES : NO;
}
- (BOOL)sending
{
    return SendingState == _state ? YES : NO;
}

+(NSString *)requestKey{
    return NSStringFromClass([self class]);
}
-(NSString *)requestKey{
    return NSStringFromClass([self class]);
}

-(NSMutableDictionary *)requestParams{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *key in [self getPropertyList:[self class]]) {
        if(![[self valueForKey:key] isKindOfClass:[NSNull class]] && [self valueForKey:key] !=nil){
            [dict setObject:[self valueForKey:key] forKey:key];
        }
    }
    return dict;
}

-(NSString *)appendPathInfo{
    __block NSString *pathInfo = self.pathInfo;

    return pathInfo;
}

-(NSString *)pathInfo{
    return nil;
}

-(NSArray *)getPropertyList:(Class)klass{
    NSMutableArray *propertyNamesArray = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(klass, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNamesArray addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNamesArray;
}
@end