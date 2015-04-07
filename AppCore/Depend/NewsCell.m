//
//  NewsCell.m
//  AppCore
//
//  Created by Gesantung on 15-3-6.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (void)initCellView{
    self.name.text = [self.dict objectForKey:@"subject"];
}

@end
