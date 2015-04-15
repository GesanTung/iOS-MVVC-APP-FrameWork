//
//  ScrollViewController.h
//  AppCore
//
//  Created by Gesantung on 15-4-15.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseScrollCellView.h"
@interface ScrollViewController : UIViewController

//isHorizontal 为真表示水平滚动，默认竖直滚动
@property (nonatomic,assign) BOOL isHorizontal;

- (void)setDataByList:(NSArray*)list className:(NSString*)name delegate:(id<ScrollViewDelegate>)delegate;

@end
