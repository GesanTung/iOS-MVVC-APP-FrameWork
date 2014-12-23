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
        self.data = msg.output;
        NSLog(@"success:%@",msg.output);
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

