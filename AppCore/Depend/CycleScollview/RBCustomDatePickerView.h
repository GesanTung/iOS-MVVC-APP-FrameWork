//
//  RBCustomDatePickerView.h
//  RBCustomDateTimePicker
//  e-mail:rbyyy924805@163.com
//  Created by renbing on 3/17/14.
//  Copyright (c) 2014 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXSCycleScrollView.h"

@protocol RBCustomDatePickerViewDelegate <NSObject>

@optional
- (void)didselectTime:(int )n moth:(int)y day:(int)r atIndex:(NSString*)index;
@end
@interface RBCustomDatePickerView : UIView <MXSCycleScrollViewDatasource,MXSCycleScrollViewDelegate>
@property (nonatomic,assign) id<RBCustomDatePickerViewDelegate>  delegate;
@end
