//
//  BaseViewController.h
//  AppCore
//
//  Created by Gesantung on 14-12-18.
//  Copyright (c) 2014年 Gesantung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)setNavTitle:(NSString*)text;
- (void)setNavLeftBtn:(NSString*)content;
- (void)setNavRightBtn:(NSString*)content;

- (void)leftButtonTouch;
- (void)rightButtonTouch;
@end
