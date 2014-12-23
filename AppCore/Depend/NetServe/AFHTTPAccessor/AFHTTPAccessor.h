//
//  AFHTTPAccessor.h
//  TibetVoice
//
//  Created by TRS on 13-7-11.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CompareTypeNone = 0x00,    //不做比较
    CompareTypeOverview,       //概览比较
    CompareTypeDetail          //细缆比较
}CompareType;

//JSON数据请求回调
typedef void (^AFHTTPSuccessCallback)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON);
typedef void (^AFHTTPFailureCallback)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error);

@interface AFHTTPAccessor : NSObject

/*客户端在请求指定url的数据时，为了避免多次请求服务器端的数据，需要根据时间戳判断数据文件是否发生变化.
 客户端在获取数据时，需要请求服务器端最新的lmt.txt文件，并与本地之前存储的lmt.txt文件进行比较，如果有变化，则获取最新数据文件；否则直接使用本地文件。
 */

/************************************************************************
 *函数名称:jsonRequestWithUrl:compareType:success:failure:
 *函数功能:获取指定url地址返回的JSON数据
 *输入参数:url 访问地址，compare 是否需要先对比 success 成功回调函数 failure 失败回调函数
 *返 回 值:BOOL 操作是否成功 
 *其它说明:回调函数 注意uri参数用于返回表示该请求对应的唯一UDID
 ***********************************************************************/
+ (void)jsonRequestWithUrl:(NSString *)url
               compareType:(CompareType)type
                   success:(AFHTTPSuccessCallback)success
                   failure:(AFHTTPFailureCallback)failure;


/************************************************************************
 *函数名称:jsonRequestWithUrl:method:body:compareType:success:failure:
 *函数功能:post方式等发送body数据到指定url地址，并返回json数据
 *输入参数:url 访问地址，method HTTP请求方式，body HTTP请求发送主体 compare 是否需要先对比 success 成功回调函数 failure 失败回调函数
 *返 回 值:BOOL 操作是否成功
 *其它说明:回调函数 注意uri参数用于返回表示该请求对应的唯一UDID
 ***********************************************************************/
+ (void)jsonRequestWithUrl:(NSString *)url
                    method:(NSString *)method
                      body:(NSData *)body
               compareType:(CompareType)type
                   success:(AFHTTPSuccessCallback)success
                   failure:(AFHTTPFailureCallback)failure;


/************************************************************************
 *函数名称:httpRequestWithUrl:success:failure:
 *函数功能:获取指定url地址返回的http数据, 并转换为JSON数据返回
 *输入参数:url 访问地址 success 成功回调函数 failure 失败回调函数
 *返 回 值:BOOL 操作是否成功
 *其它说明:回调函数 注意uri参数用于返回表示该请求对应的唯一UDID
 ***********************************************************************/
+ (void)httpRequestWithUrl:(NSString *)url
                   success:(AFHTTPSuccessCallback)success
                   failure:(AFHTTPFailureCallback)failure;


/************************************************************************
 *函数名称:httpRequestWithUrl:method:body:success:failure:
 *函数功能:post方式等发送body数据获取指定url地址返回的http数据, 并转换为JSON数据返回
 *输入参数:url 访问地址 method HTTP请求方式，body HTTP请求发送主体 success 成功回调函数 failure 失败回调函数
 *返 回 值:BOOL 操作是否成功
 *其它说明:回调函数 注意uri参数用于返回表示该请求对应的唯一UDID
 ***********************************************************************/
+ (void)httpRequestWithUrl:(NSString *)url
                    method:(NSString *)method
                      body:(NSData *)body
                   success:(AFHTTPSuccessCallback)success
                   failure:(AFHTTPFailureCallback)failure;


@end
