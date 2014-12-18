//
//  UIColor+Utils.h
//  Airailways
//
//  Created by wu jianjun on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIColor (UIColor_Utils)

//16进制转颜色值, 常用于web颜色值码(除用于web页面解析, 其他地方不建议采用)
+ (UIColor *)colorWithHexString:(NSString *)color;

//随机颜色值带Alpha值
+ (UIColor *)colorRandomWithAlpha:(CGFloat)alpha;

//16进制转颜色值
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue;

//16进制转颜色值带Alpha值
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha;

//16进制转颜色值带亮度
+ (UIColor *)colorWithBrightness:(UIColor *)color brightness:(CGFloat)brightness;

//混合色 factor：混合因子
+ (UIColor *)colorWithBlendedColor:(UIColor *)color blendedColor:(UIColor *)blendedColor factor:(CGFloat)factor;

//由颜色得到RGBA数值
+ (uint32_t)RGBAValue:(UIColor *)color;

//由颜色得到RGBA描述
+ (NSString *)stringValue:(UIColor *)color;

@end