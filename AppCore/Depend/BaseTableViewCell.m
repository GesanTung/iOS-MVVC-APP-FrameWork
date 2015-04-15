//
//  BaseTableViewCell.m
//  AppCore
//
//  Created by Gesantung on 15-3-2.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
@synthesize dict;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)initCellView{

}

+ (CGFloat)height
{
    return 0.0;
}
@end
