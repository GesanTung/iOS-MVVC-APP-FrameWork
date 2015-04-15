//
//  BaseScrollCellView.h
//  AppCore
//
//  Created by Gesantung on 15-4-15.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollViewDelegate.h"
@interface BaseScrollCellView : UIView

@property (nonatomic, retain) NSDictionary *dict;

@property (nonatomic, assign) id <ScrollViewDelegate> delegate;

- (void)initCellView;

@end
