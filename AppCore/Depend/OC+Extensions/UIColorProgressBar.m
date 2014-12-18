//
//  MCProgressBarView.m
//  MCProgressBarView
//
//  Created by Baglan on 12/29/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import "UIColorProgressBar.h"

#define IOSVersion5  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)

@interface UIColorProgressBar ()

- (void)initlizationUI;

@end

@implementation UIColorProgressBar {
    UIImageView *_backgroundImageView;
    UIImageView *_foregroundImageView;
    CGFloat minimumForegroundWidth;
    CGFloat availableWidth;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initlizationUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initlizationUI];
}

- (void)initlizationUI
{
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _foregroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_backgroundImageView];
    [self addSubview:_foregroundImageView];
    
    _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    _foregroundImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

    self.progress = 0.0;
}

//进度条背景图片
- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    if(IOSVersion5) {
        _backgroundImageView.image = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) ];
    }
    else {
        _backgroundImageView.image = [backgroundImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:1.0];
    }
    availableWidth = self.bounds.size.width - minimumForegroundWidth;
    
    CGRect bounds = self.bounds; //根据图片自动调整高度
    bounds.size.height = backgroundImage.size.height;
    [self setBounds:bounds];
}

//进度条前景图片
- (void)setForegroundImage:(UIImage *)foregroundImage
{
    _foregroundImage = foregroundImage;
    if(IOSVersion5) {
        _foregroundImageView.image = [foregroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) ];
        UIEdgeInsets insets = foregroundImage.capInsets;
        minimumForegroundWidth = insets.left + insets.right;
    }
    else {
        _foregroundImageView.image = [foregroundImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:1.0];
        minimumForegroundWidth  = foregroundImage.leftCapWidth*2;
    }
    availableWidth = self.bounds.size.width - minimumForegroundWidth;
}

//进度条背景颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    _backgroundImageView.backgroundColor = backgroundColor;
}

//进度条前景颜色
- (void)setForegroundColor:(UIColor *)foregroundColor
{
    _foregroundColor = foregroundColor;
    _foregroundImageView.backgroundColor = foregroundColor;
}

//进度条头位置坐标
- (CGPoint)trackPoint
{
    return CGPointMake(_foregroundImageView.frame.origin.x + _foregroundImageView.frame.size.width, _foregroundImageView.frame.origin.y);
}

- (void)setProgress:(double)progress
{
    _progress = progress;
    if(IOSVersion5) {
        UIEdgeInsets insets = _backgroundImageView.image.capInsets;
        minimumForegroundWidth = insets.left + insets.right;
    }
    else {
        minimumForegroundWidth  = _backgroundImageView.image.leftCapWidth*2;
    }
    availableWidth = self.bounds.size.width - minimumForegroundWidth;
    progress==0?minimumForegroundWidth = 0:minimumForegroundWidth;
    CGRect frame = _foregroundImageView.frame;
    frame.size.width = roundf(minimumForegroundWidth + availableWidth * progress);
    [_foregroundImageView setFrame:frame];
}

@end
