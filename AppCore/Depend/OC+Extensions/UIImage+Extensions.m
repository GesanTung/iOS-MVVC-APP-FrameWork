//
//  UIImage+Extensions.m
//  TibetVoice
//
//  Created by TRS on 13-7-23.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import "UIImage+Extensions.h"

@implementation UIImage (UIImage_Extensions)

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}

//由颜色值获取图片
+ (UIImage *) imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius
{
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

//由颜色值半径大小获取圆形图片
+ (UIImage *) circularImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [color setStroke];
    [circle addClip];
    [circle fill];
    [circle stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -
//从左上角截取图片
- (UIImage *) clipImageWithSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
	
    float w = 0.0f;
    float h = 0.0f;
    float or = width * 1.0 / height;
    float nr = size.width * 1.0 / size.height;
    if(or < nr) {
        w = size.width;
        h = w * height / width;
    } else {
        h = size.height;
        w = h * width / height;
    }
	
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
	
    // 绘制改变大小的图片，左上角截取
    [self drawInRect:CGRectMake(0, 0, w, h)];
    
	// 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
	// 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
	// 返回新的改变大小后的图片
    return scaledImage;
}
+ (UIImage*) imageNamedNC:(NSString *)str
{
    NSString *imageName=[NSString stringWithFormat:@"%@",str];
    NSString *imagePath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName];
    return [[[self class] alloc] initWithContentsOfFile:imagePath];
}
// --------------------------------------------------
// Resize an image
// --------------------------------------------------
- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height {
    
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}

@end
