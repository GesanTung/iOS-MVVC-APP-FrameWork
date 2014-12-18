//
//  TabImageButton.m
//  TibetQS
//
//  Created by Gesantung on 14-11-27.
//  Copyright (c) 2014年 TRS. All rights reserved.
//

#import "TabImageButton.h"
#define kImageBiLi 0.7
#define itemFrame CGRectMake(0, 0, itemWH, itemWH)
#define kHeight  33
#define kWidth  33
#define distanceWithLableAndImageView 5
@implementation TabImageButton

#pragma mark - 重写了UIButton的方法
#pragma mark 控制UILabel的位置和尺寸
#pragma markcontentRect其实就是按钮的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX =(contentRect.size.width-kWidth)/2+6;
    CGFloat titleHeight = contentRect.size.height * (1 - kImageBiLi) - distanceWithLableAndImageView;
    CGFloat titleY = contentRect.size.height - titleHeight-5;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

#pragma mark 控制UIImageView的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = (contentRect.size.width-kWidth)/2;
    CGFloat imageY = 0;
    CGFloat imageWidth = kWidth;
    CGFloat imageHeight = kHeight;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

@end
