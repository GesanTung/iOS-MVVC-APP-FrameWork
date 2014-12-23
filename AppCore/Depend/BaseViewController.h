//
//  BaseViewController.h
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataLog.h"
@interface BaseViewController : UIViewController
//y坐标
@property (nonatomic, assign) CGFloat   offset_y;
//数据层
@property (nonatomic, strong) DataLog   *dataLog;
- (void)setNavTitle:(NSString*)text;
- (void)setNavLeftBtn:(NSString*)content;
- (void)setNavRightBtn:(NSString*)content;

- (void)leftButtonTouch;
- (void)rightButtonTouch;

- (void)requstData:(Message*)message;

- (void)updateThisUI:(id)json;
@end
