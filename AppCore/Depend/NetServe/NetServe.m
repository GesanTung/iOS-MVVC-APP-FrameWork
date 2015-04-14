//
//  NetServe.m
//  AppCore
//
//  Created by Gesantung on 14-12-19.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import "NetServe.h"

@implementation NetServe
SYNTHESIZE_SINGLETON_FOR_CLASS(NetServe)
+(void)actionConfigHost:(NSString *)host client:(NSString *)client codeKey:(NSString *)codeKey rightCode:(NSInteger)rightCode msgKey:(NSString *)msgKey{
    [NetServe sharedNetServe].HOST_URL = host;
    [NetServe sharedNetServe].CLIENT = client;
    [NetServe sharedNetServe].CODE_KEY = codeKey;
    [NetServe sharedNetServe].RIGHT_CODE = rightCode;
    [NetServe sharedNetServe].MSG_KEY = msgKey;
    [NetServe sharedNetServe];
}

+ (id)netServe{
    return [[[self class] alloc] init];
}
- (id)init
{
    self = [super init];
    if(self){
        _cacheEnable = NO;
        _dataFromCache = NO;
    }
    return self;
}

- (id)initWithCache
{
    self = [self init];
    _cacheEnable = YES;
    return self;
}

- (void)useCache{
    _cacheEnable = YES;
}

- (void)readFromCache{
    _dataFromCache = YES;
}
- (void)notReadFromCache{
    _dataFromCache = NO;
}

- (void)send:(Message *)msg{
    if([msg.METHOD isEqualToString:@"GET"]){
        return [self GET:msg];
    }else if([msg.METHOD isEqualToString:@"POST"]){
        return [self POST:msg];
    }
    else{
        msg.error = [NSError errorWithDomain:@"未定义数据请求类型" code:-1001 userInfo:nil];
        [self failed:msg];
    }
}

- (void) GET:(Message *)msg
{
    NSString *url = @"";
    if(!msg.SCHEME.length || !msg.HOST.length){
        url = [NSString stringWithFormat:@"http://%@%@",[NetServe sharedNetServe].HOST_URL,msg.PATH];
    }else{
        url = [NSString stringWithFormat:@"%@://%@%@",msg.SCHEME,msg.HOST,msg.PATH];
    }
    if(!msg.appendPathInfo.length || msg.appendPathInfo ==nil){
       // requestParams = msg.requestParams;
    }else{
        url = [url stringByAppendingString:msg.appendPathInfo];
    }
    if (msg.url.length) {
        url = msg.url;
    }
    
    [self sending:msg];
    
    //网络请求成功回调函数

    //网络请求成功回调函数
    AFHTTPSuccessCallback success = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        msg.output = JSON;
        [self success:msg];
    };
    
    //网络请求失败回调函数
    AFHTTPFailureCallback failure = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        msg.error = error;
        [self failed:msg];
    };
    
    [AFHTTPAccessor jsonRequestWithUrl:url
                           compareType:CompareTypeNone
                               success:success
                               failure:failure
     ];
  //  msg.url = url;
//    msg.output = [[TMCache sharedCache] objectForKey:msg.url.MD5];
    
}

- (void) POST:(Message *)msg
{
    NSString *url = @"";
    if(!msg.SCHEME.length || !msg.HOST.length){
        url = [NSString stringWithFormat:@"http://%@%@",[NetServe sharedNetServe].HOST_URL,msg.PATH];
    }else{
        url = [NSString stringWithFormat:@"%@://%@%@",msg.SCHEME,msg.HOST,msg.PATH];
    }
    if(!msg.appendPathInfo.length || msg.appendPathInfo ==nil){
        // requestParams = msg.requestParams;
    }else{
        url = [url stringByAppendingString:msg.appendPathInfo];
    }
    if (msg.url.length) {
        url = msg.url;
    }
    
    [self sending:msg];
    
    //网络请求成功回调函数
    
    //网络请求成功回调函数
    AFHTTPSuccessCallback success = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        msg.output = JSON;
        [self success:msg];
    };
    
    //网络请求失败回调函数
    AFHTTPFailureCallback failure = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        msg.error = error;
        [self failed:msg];
    };
    
    [AFHTTPAccessor httpRequestWithUrl:url
                                method:@"POST"
                                  body:msg.postData
                               success:success
                               failure:failure];
}

- (void)sending:(Message *)msg{
    msg.state = SendingState;
    if([self.aDelegaete respondsToSelector:@selector(handleActionMsg:)]){
        //[self.aDelegaete handleActionMsg:msg];
    }
    if (_netServeCallBack) {
        _netServeCallBack(msg);
    }
}

- (void)success:(Message *)msg{
    if (msg.state != SuccessState) {
        msg.state = SuccessState;
        if([self.aDelegaete respondsToSelector:@selector(handleActionMsg:)]){
            //[self.aDelegaete handleActionMsg:msg];
        }
        if (_netServeCallBack) {
            _netServeCallBack(msg);
        }
    }
}

- (void)failed:(Message *)msg{
    msg.state = FailState;
    if([self.aDelegaete respondsToSelector:@selector(handleActionMsg:)]){
        [self.aDelegaete handleActionMsg:msg];
    }
    if (_netServeCallBack) {
        _netServeCallBack(msg);
    }

}



@end

