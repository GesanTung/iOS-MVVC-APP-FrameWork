//
//  UIView+Extensions.m
//  TibetVoice
//
//  Created by TRS on 13-7-2.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import "UIView+Extensions.h"

#pragma mark - UIView
@implementation UIView (UIView_Extensions)

- (void)setCornerRadius:(CGFloat)radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = radius;
}

- (void)setBorder:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)setShadow:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowOffset:(CGSize)shadowOffset
{
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowOffset  = shadowOffset;
}

- (void)setGradientColor:(CGRect)rect gradientColors:(NSArray *)gradientColors
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = rect;
    gradient.colors = gradientColors;
    [self.layer insertSublayer:gradient atIndex:0];
}

- (void)shakeAnimation:(BOOL)shake
{
    if(shake) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:-0.3];
        animation.toValue = [NSNumber numberWithFloat:+0.3];
        animation.duration = 0.1;
        animation.autoreverses = YES; //是否重复
        animation.repeatCount = MAXFLOAT;
        [self.layer addAnimation:animation forKey:@"shake"];
    }
    else {
        [self.layer removeAnimationForKey:@"shake"];
    }
}
+ (id)viewWithXibString:(NSString*)str
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:str owner:self options:nil];
    return [array lastObject];
}

- (void)addHeight:(float)value
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+value);
}

- (void)addWidth:(float)value
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+value, self.frame.size.height);
}

- (void)setCenterX:(float)x
{
    self.center=CGPointMake(x, self.center.y);
}

- (void)setCenterY:(float)y
{
    self.center=CGPointMake(self.center.x,y);
}

- (void)setFrameX:(float)x{
    self.frame=CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)setFrameY:(float)y
{
    self.frame=CGRectMake(self.frame.origin.x,y, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameW:(float)w
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, w, self.frame.size.height);
}
- (void)setFrameH:(float)h
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
}

- (void)setFrameSize:(CGSize)size
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (void)setFrameOrigin:(CGPoint)point
{
    self.frame=CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}
@end

