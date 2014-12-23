//
//  NetServe.h
//  AppCore
//
//  Created by Gesantung on 14-12-19.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCSingletonTemplate.h"
#import "AFHTTPAccessor.h"
#import "Message.h"
@interface NetServe : NSObject
@property(nonatomic,assign)BOOL cacheEnable;
@property(nonatomic,assign)BOOL dataFromCache;

@property(nonatomic,strong)NSString *HOST_URL;//服务端域名:端口
@property(nonatomic,strong)NSString *CLIENT;//自定义客户端识别
@property(nonatomic,retain)NSString *CODE_KEY;//错误码key,支持路径 如 data/code
@property(nonatomic,assign)NSUInteger RIGHT_CODE;//正确校验码
@property(nonatomic,strong)NSString *MSG_KEY;//消息提示msg,支持路径 如 data/msg
+(id)netServe;
-(void)send:(Message *)msg;
SYNTHESIZE_SINGLETON_FOR_HEADER(NetServe)
@end
