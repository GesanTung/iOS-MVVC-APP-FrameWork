//
//  PageCell.m
//  AppCore
//
//  Created by Gesantung on 15-4-7.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import "PageCell.h"
#import "Globals.h"

@implementation PageCell

- (void)initCellView{
     self.title.text = [self.dict objectForKey:@"subject"];
    [self.imageIcon setUIImageWithURL:dict[@"coverpath"]
                placeholderImage:[UIImage imageNamed:@"icon_d_默认小图.png"]
                       completed:nil];
}

+ (CGFloat)height{
    return 100;
}

@end
