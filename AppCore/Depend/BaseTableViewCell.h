//
//  BaseTableViewCell.h
//  AppCore
//
//  Created by Gesantung on 15-3-2.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
{
    NSDictionary *dict;
}
@property (nonatomic, retain) NSDictionary *dict;

- (void)initCellView;

+ (CGFloat)height;

@end
