//
//  SDWebImage+Extension.m
//  TRSMobile
//
//  Created by TRS on 14-6-3.
//  Copyright (c) 2014年 TRS. All rights reserved.
//

#import "SDWebImage+Extension.h"

@implementation UIImageView (UIImageView_Extension)

- (void)setUIImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completionBlock
{
    [self setUIImageWithURL:url
           placeholderImage:placeholder
                   progress:nil
                  completed:completionBlock];
}

- (void)setUIImageWithURL:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                 progress:(SDWebImageDownloaderProgressBlock)progressBlock
                completed:(SDWebImageCompletionBlock)completionBlock
{

    if([url rangeOfString:@"file://"].location != NSNotFound || [url rangeOfString:@"http://"].location == NSNotFound) {
        NSRange range = [url rangeOfString:@"file://"];
        if(range.location != NSNotFound) {
            url = [url substringFromIndex:(range.location + range.length)];
        }
        self.image = [UIImage imageNamed:url];
    }
    else {
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:0 progress:nil completed:completionBlock];
    }
}

@end
