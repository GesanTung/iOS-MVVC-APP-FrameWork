//
//  AFHTTPAccessor.m
//  TibetVoice
//
//  Created by TRS on 13-7-11.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import "AFHTTPAccessor.h"
#import "Globals.h"

#define HTTPRequestSuffix   @"lmt.txt"
#define NSErrorTimeStamp    @"the timestamp is latest"  //数据对比时间戳未更新提示
#define URITimestamp        @"timestamp"    //存放在NSUserDefaults中的键

@implementation AFHTTPAccessor

/*客户端在请求指定url的数据时，为了避免多次请求服务器端的数据，需要根据时间戳判断数据文件是否发生变化.
 客户端在获取数据时，需要请求服务器端最新的lmt.txt文件，并与本地之前存储的lmt.txt文件进行比较，如果有变化，则获取最新数据文件；否则直接使用本地文件。
 */
+ (void)jsonRequestWithUrl:(NSString *)url
                    method:(NSString *)method
                      body:(NSData *)body
               compareType:(CompareType)type
                   success:(AFHTTPSuccessCallback)success
                   failure:(AFHTTPFailureCallback)failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    if(![AFHTTPAccessor isLocalJSONFile:url]) {
    
        if(type != CompareTypeNone) {
            NSString *url_lmt = nil;
            if(type == CompareTypeOverview) { //概览文件， 添加随机数避免网络cache
                url_lmt = [NSString stringWithFormat:@"%@/%@?%d", [url stringByDeletingLastPathComponent], HTTPRequestSuffix,  (int)(random()%10000)];
            }
            else { //细缆文件
                url_lmt = [NSString stringWithFormat:@"%@_%@?%d", [url stringByDeletingPathExtension], HTTPRequestSuffix, (int)(random()%10000)];
            }
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url_lmt] ];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                if([responseObject isKindOfClass:[NSData class] ]) {
                    NSString *timestamp = [NSString stringFromUTF8Data:responseObject];
                    if([self isUpdate:timestamp uri:url isWritten:NO]) { //时间戳更新，获取最新数据
                        [self jsonRequestWithUrl:url method:method body:body timestamp:timestamp success:success failure:failure];
                    }
                    else { //时间戳未更新，告知上层
                        if(failure) {
                            NSError *error = [NSError errorWithDomain:NSArgumentDomain code:-100 userInfo: [NSDictionary dictionaryWithObjectsAndKeys:NSErrorTimeStamp, NSLocalizedFailureReasonErrorKey, NSErrorTimeStamp, NSLocalizedDescriptionKey, nil] ];
                            
                            NSLog(@"%s -- > response status : %d, url : %@, error : %@", __FUNCTION__, operation.response.statusCode, operation.response.URL.absoluteString, error.localizedDescription);
                            failure([NSURLRequest requestWithURL:[NSURL URLWithString:url] ], operation.response, error);
                            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                        }
                    }
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //告知上层
                if(failure) {
                    NSLog(@"%s -- > response status : %d, url : %@, error : %@", __FUNCTION__, operation.response.statusCode, operation.response.URL.absoluteString, error.localizedDescription);
                    
                    failure([NSURLRequest requestWithURL:[NSURL URLWithString:url] ], operation.response, error);
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }
            }];
            [operation start];
        }
        else {
            [self jsonRequestWithUrl:url method:method body:body timestamp:nil success:success failure:failure];
        }
    }
    else {
        [self requestLocalRequest:url success:success failure:failure];
    }
}

//post方式等发送body数据到指定url地址，并返回json数据
+ (void)jsonRequestWithUrl:(NSString *)url
               compareType:(CompareType)type
                   success:(AFHTTPSuccessCallback)success
                   failure:(AFHTTPFailureCallback)failure;
{
    [self jsonRequestWithUrl:url
                      method:nil
                        body:nil
                 compareType:type
                     success:success
                     failure:failure];
}

/*真正获取从服务器返回的JSON数据*/
+ (void)jsonRequestWithUrl:(NSString *)url
                    method:(NSString *)method
                      body:(NSData *)body
                  timestamp:(NSString *)timestamp
                    success:(AFHTTPSuccessCallback)success
                    failure:(AFHTTPFailureCallback)failure
{
    NSString *requestUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl] ];
    if(method != nil ) {[request setHTTPMethod:method];} //设置HTTP发送方式
    if(body != nil ) {[request setHTTPBody:body];} //设置HTTP发送内容， 另底层的HTTP是默认处理cookie的
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (success) {
             NSLog(@"%s -- > response status : %d, url : %@", __FUNCTION__, operation.response.statusCode, [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
             
             success(operation.request, operation.response, responseObject);
             if(timestamp != nil) {
                 [self isUpdate:timestamp uri:url isWritten:YES];
             }
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         }
                                                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             NSLog(@"%s -- > response status : %d, url : %@, error : %@", __FUNCTION__, operation.response.statusCode, [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding], error.localizedDescription);
             
             failure(operation.request, operation.response, error);
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         }
                                                                     }];
    [operation start];
}

/*判断时间戳时候发生变化，若发生变化则存储最近的时间戳*/
+ (BOOL)isUpdate:(NSString *)timestamp uri:(NSString *)uri isWritten:(BOOL)isWritten
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *timestampValue = [NSMutableDictionary dictionaryWithDictionary:[userDefaults dictionaryForKey:URITimestamp]];
    
	//时间戳键值都不存在时，创建该uri键值的数据词典并存入到NSUserDefaults中。
    if(timestampValue == nil) {
		if(isWritten) {
			timestampValue = [NSMutableDictionary dictionaryWithObjectsAndKeys:timestamp, uri, nil];
			[userDefaults setObject:timestampValue forKey:URITimestamp];
			[userDefaults synchronize];
		}
        return YES; //时间戳不存在时，需更新获取数据
    }
    else {
        NSString *timestamp_old = [timestampValue valueForKey:uri];
		
        //对应的uri的时间戳存在时，且时间戳数值不相等时，存入当前时间戳并返回YES。
		if(timestamp_old == nil || ([timestamp doubleValue] != [timestamp_old doubleValue] )) {
			if(isWritten) {
				[timestampValue setObject:timestamp forKey:uri];
				[userDefaults setObject:timestampValue forKey:URITimestamp];
				[userDefaults synchronize];
			}
			return YES;
		}
	}
	return NO; //时间戳值相等
}

#pragma mark - 本地JSON文件

/*判断请求地址时候为本地JSON数据文件加载*/
+ (BOOL)isLocalJSONFile:(NSString *)url
{
    return [url rangeOfString:@"file://"].location != NSNotFound;
}

/*本地JSON文件数据记载*/
+ (void)requestLocalRequest:(NSString *)url
                    success:(AFHTTPSuccessCallback)success
                    failure:(AFHTTPFailureCallback)failure
{
    NSRange range = [url rangeOfString:@"file://"];
    if(range.location != NSNotFound) {
        NSString *filename = [url substringFromIndex:range.location + range.length];
        NSString *path = [[NSBundle mainBundle] pathForResource:[filename stringByDeletingPathExtension] ofType:@"json"];
        NSData *responseData = [NSData dataWithContentsOfFile:path];
        if(responseData) {
            NSError *error = nil;
            id responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            if(!error) {
                success([NSURLRequest requestWithURL:[NSURL URLWithString:url]], nil, responseJSON);
            }
            else {
                failure([NSURLRequest requestWithURL:[NSURL URLWithString:url]], nil, error);
            }
        }
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - 请求HTTP数据
//post方式等发送body数据获取指定url地址返回的http数据, 并转换为JSON数据返回
+ (void)httpRequestWithUrl:(NSString *)url
                    method:(NSString *)method
                      body:(NSData *)body
                   success:(AFHTTPSuccessCallback)success
                   failure:(AFHTTPFailureCallback)failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *requestUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl] ];
    if(method != nil ) {[request setHTTPMethod:method];} //设置HTTP发送方式
    if(body != nil ) {[request setHTTPBody:body];} //设置HTTP发送内容， 另底层的HTTP是默认处理cookie的

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%s -- > response status : %d, url : %@", __FUNCTION__, operation.response.statusCode, [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        
        if(success) {success(operation.request, operation.response, responseObject);}
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%s -- > response status : %d, url : %@, error : %@", __FUNCTION__, operation.response.statusCode, [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding], error.localizedDescription);
        
        if(failure) {failure(operation.request, operation.response, error);}
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    [operation start];
}

//获取指定url地址返回的http数据, 并转换为JSON数据返回
+ (void)httpRequestWithUrl:(NSString *)url
                   success:(AFHTTPSuccessCallback)success
                   failure:(AFHTTPFailureCallback)failure
{
    [AFHTTPAccessor httpRequestWithUrl:url
                                method:nil
                                  body:nil
                               success:success
                               failure:failure];
}

@end
