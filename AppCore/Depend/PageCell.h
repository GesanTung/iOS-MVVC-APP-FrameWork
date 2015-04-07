//
//  PageCell.h
//  AppCore
//
//  Created by Gesantung on 15-4-7.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PageCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
