//
//  DataLog.h
//  AppCore
//
//  Created by Gesantung on 14-12-19.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetServe.h"
#import "Message.h"
#import "ReactiveCocoa.h"
@interface DataLog : NSObject
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,strong)NetServe *action;
@property(nonatomic,assign)BOOL active;
+ (id)DataLog;
- (void)handleActionMsg:(Message *)msg;
- (void)SEND_ACTION:(Message *)msg;
- (void)SEND_CACHE_ACTION:(Message *)msg;

- (void)loadSceneModel;
- (void)loadActive;
- (void)activeRequest;
@end
