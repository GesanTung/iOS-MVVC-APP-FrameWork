//
//  ProductView.m
//  AppCore
//
//  Created by Gesantung on 15-4-15.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import "ProductView.h"

@implementation ProductView

- (IBAction)btnClick:(id)sender {
    if (self.delegate) {
        [self.delegate select:0 item:self.dict];
    }
}

@end
