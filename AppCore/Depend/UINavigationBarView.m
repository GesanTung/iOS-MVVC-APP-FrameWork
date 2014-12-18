//
//  UINavigationBarView.m
//  TibetVoice
//
//  Created by TRS on 13-7-2.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import "UINavigationBarView.h"
#import "Globals.h"
@implementation UINavigationBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
//    self.backgroundColor = [UIColor colorWithRGB:UIColorBlueDark alpha:1.0];
//    _labelTitle.textColor = [UIColor colorWithRGB:UIColorWhite alpha:1.0];
	[_buttonLeft addTarget:self action:@selector(didSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonRight addTarget:self action:@selector(didSelectButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didSelectButton:(UIButton *)button
{
    if(self.callback) {
        self.callback(self,button.tag);
    }
}

@end
