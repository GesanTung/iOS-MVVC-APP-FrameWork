//
//  UIView+Extensions.h
//  TibetVoice
//
//  Created by TRS on 13-7-2.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#pragma mark - UIView
@interface UIView (UIView_Extensions)

//设置圆角
- (void)setCornerRadius:(CGFloat)radius;

//设置边框
- (void)setBorder:(UIColor *)color borderWidth:(CGFloat)borderWidth;

//设置阴影
- (void)setShadow:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowOffset:(CGSize)shadowOffset;

//设置渐变色
- (void)setGradientColor:(CGRect)rect gradientColors:(NSArray *)gradientColors;

//设置图层抖动
- (void)shakeAnimation:(BOOL)shake;

//通过xib名字初始化自定义view
+ (id)viewWithXibString:(NSString*)str;

//UIView frame 设置
-(void)addWidth:(float)value;

-(void)addHeight:(float)value;

-(void)setCenterX:(float)x;

-(void)setCenterY:(float)y;

-(void)setFrameX:(float)x;

-(void)setFrameY:(float)y;

-(void)setFrameW:(float)w;

-(void)setFrameH:(float)h;

-(void)setFrameOrigin:(CGPoint)point;

-(void)setFrameSize:(CGSize)size;

@end


