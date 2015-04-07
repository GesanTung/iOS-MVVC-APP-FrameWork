//
//  ActionDelegate.h

//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@protocol ActionDelegate <NSObject>
-(void)handleActionMsg:(Message *)msg;
@optional
-(void)handleProgressMsg:(Message *)msg;
@end
