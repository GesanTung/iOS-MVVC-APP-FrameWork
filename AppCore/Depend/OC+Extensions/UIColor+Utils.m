//
//  UIColor+Utils.m
//  Airailways
//
//  Created by wu jianjun on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (UIColor_Utils)

//16进制转颜色值, 常用于web颜色值码(除用于web页面解析, 其他地方不建议采用)
+ (UIColor *)colorWithHexString:(NSString *)color
{
	NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) {
		return [UIColor clearColor];
	}
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) 
		cString = [cString substringFromIndex:2];
	if ([cString hasPrefix:@"#"]) 
		cString = [cString substringFromIndex:1];
	if ([cString length] != 6) 
		return [UIColor clearColor];
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	
	//r
	NSString *rString = [cString substringWithRange:range];
	
	//g
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	//b
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//随机颜色值带Alpha值
+ (UIColor *)colorRandomWithAlpha:(CGFloat)alpha
{
	CGFloat red =  (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//16进制转颜色值
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue
{
	return [UIColor colorWithRGB:rgbValue alpha:1.0];
}

//16进制转颜色值带Alpha值
+ (UIColor *)colorWithRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

//16进制转颜色值带亮度
+ (UIColor *)colorWithBrightness:(UIColor *)color brightness:(CGFloat)brightness
{
    brightness = MAX(brightness, 0.0f);
    
    CGFloat rgba[4];
    [UIColor getRGBAComponents:color rgba:rgba];
    
    return [UIColor colorWithRed:rgba[0] * brightness
                           green:rgba[1] * brightness
                            blue:rgba[2] * brightness
                           alpha:rgba[3]];
}

//混合色 factor：混合因子
+ (UIColor *)colorWithBlendedColor:(UIColor *)color blendedColor:(UIColor *)blendedColor factor:(CGFloat)factor
{
    factor = MIN(MAX(factor, 0.0f), 1.0f);
    
    CGFloat fromRGBA[4], toRGBA[4];
    [UIColor getRGBAComponents:color rgba:fromRGBA];
    [UIColor getRGBAComponents:blendedColor rgba:toRGBA];
    
    return [UIColor colorWithRed:fromRGBA[0] + (toRGBA[0] - fromRGBA[0]) * factor
                           green:fromRGBA[1] + (toRGBA[1] - fromRGBA[1]) * factor
                            blue:fromRGBA[2] + (toRGBA[2] - fromRGBA[2]) * factor
                           alpha:fromRGBA[3] + (toRGBA[3] - fromRGBA[3]) * factor];
}

//由颜色得到RGBA数值
+ (void)getRGBAComponents:(UIColor *)color rgba:(CGFloat[4])rgba
{
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor));
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    switch (model)
    {
        case kCGColorSpaceModelMonochrome:
        {
            rgba[0] = components[0];
            rgba[1] = components[0];
            rgba[2] = components[0];
            rgba[3] = components[1];
            break;
        }
        case kCGColorSpaceModelRGB:
        {
            rgba[0] = components[0];
            rgba[1] = components[1];
            rgba[2] = components[2];
            rgba[3] = components[3];
            break;
        }
        case kCGColorSpaceModelCMYK:
        case kCGColorSpaceModelDeviceN:
        case kCGColorSpaceModelIndexed:
        case kCGColorSpaceModelLab:
        case kCGColorSpaceModelPattern:
        case kCGColorSpaceModelUnknown:
        {
            
#ifdef DEBUG
            //unsupported format
            NSLog(@"Unsupported color model: %i", model);
#endif
            rgba[0] = 0.0f;
            rgba[1] = 0.0f;
            rgba[2] = 0.0f;
            rgba[3] = 1.0f;
            break;
        }
    }
}

//由颜色得到RGBA数值
+ (uint32_t)RGBAValue:(UIColor *)color
{
    CGFloat rgba[4];
    [UIColor getRGBAComponents:color rgba:rgba];
    uint8_t red = rgba[0]*255;
    uint8_t green = rgba[1]*255;
    uint8_t blue = rgba[2]*255;
    uint8_t alpha = rgba[3]*255;
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

//由颜色得到RGBA描述
+ (NSString *)stringValue:(UIColor *)color
{
    //include alpha component
    return [NSString stringWithFormat:@"#%.8x", [UIColor RGBAValue:color] ];
}


@end
