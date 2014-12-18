//
//  UIImage+Extensions.h
//  TibetVoice
//
//  Created by TRS on 13-7-23.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_Extensions)

//由颜色值获取图片
+ (UIImage *) imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

//由颜色值半径大小获取圆形图片
+ (UIImage *) circularImageWithColor:(UIColor *)color size:(CGSize)size;

//从左上角截取图片
- (UIImage *) clipImageWithSize:(CGSize)size;

//无缓存方式加载图片
+ (UIImage*) imageNamedNC:(NSString *)str;

// Resize an image
- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height;

@end
