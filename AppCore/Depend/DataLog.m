//
//  DataLog.m
//  AppCore
//
//  Created by Gesantung on 14-12-19.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import "DataLog.h"

@implementation DataLog

+(id)DataLog{
    return [[self alloc]initDataLog];
}

- (id)initDataLog{
    self = [super init];
    if(self){
        [self loadSceneModel];
    }
    return self;
}

- (void)loadSceneModel{
    self.action = [NetServe netServe];
    self.action.aDelegaete = self;
    __block DataLog *weakself = self;
    self.action.netServeCallBack = ^(Message *msg){
        [weakself handleActionMsg:msg];
    };
}

- (void)loadActive{
    self.active = NO;
    @weakify(self);
    [[RACObserve(self,active)
      filter:^BOOL(NSNumber *active) {
          return [active boolValue];
      }]
     subscribeNext:^(NSNumber *active) {
         @strongify(self);
         [self activeRequest];
         self.active = NO;
     }];
}

- (void)activeRequest{
    
}

- (void)handleActionMsg:(Message *)msg{
    if(msg.sending){
        NSLog(@"sending:%@",msg.url);
    }else if(msg.succeed){
        self.data = [NSDictionary dictionaryWithDictionary:msg.output] ;
        NSLog(@"success:%@",msg.output);
        if (self.callBack) {
            _callBack(self.data);
        }
    }else if(msg.failed){
        NSLog(@"failed:%@",msg.error);
    }
}

- (void)handleProgressMsg:(Message *)msg{
    
}

- (void)SEND_ACTION:(Message *)msg{
    if(msg !=nil){
        [self.action send:msg];
    }
}

- (void)SEND_CACHE_ACTION:(Message *)msg{
    //to read from cache
    [self SEND_ACTION:msg];
}



@end

