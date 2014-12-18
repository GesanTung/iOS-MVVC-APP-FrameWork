//
//  MCProgressBarView.h
//  MCProgressBarView
//
//  Created by Baglan on 12/29/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColorProgressBar : UIView

//当前进度
@property (nonatomic, assign) double  progress;

//进度条头位置坐标
@property (nonatomic, readonly) CGPoint trackPoint;

//进度条背景图片
@property (nonatomic, retain) UIImage *backgroundImage;

//进度条前景图片
@property (nonatomic, retain) UIImage *foregroundImage;

//进度条背景颜色
@property (nonatomic, retain) UIColor *backgroundColor;

//进度条前景颜色
@property (nonatomic, retain) UIColor *foregroundColor;

@end
