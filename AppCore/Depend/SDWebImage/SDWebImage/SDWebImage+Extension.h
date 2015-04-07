//
//  SDWebImage+Extension.h
//  TRSMobile
//
//  Created by TRS on 14-6-3.
//  Copyright (c) 2014年 TRS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (UIImageView_Extension)

/**
 *  异步图片加载
 *
 *  @param url             图片请求地址http://开头或本地文件file://开头
 *  @param placeholder     默认图片
 *  @param completionBlock 加载完成回调函数
 */
- (void)setUIImageWithURL:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                completed:(SDWebImageCompletionBlock)completionBlock;

/**
 *  异步图片加载
 *
 *  @param url             图片请求地址http://开头或本地文件file://开头
 *  @param placeholder     默认图片
 *  @param progressBlock   加载进度回调函数
 *  @param completionBlock 加载完成回调函数
 */
- (void)setUIImageWithURL:(NSString *)url
         placeholderImage:(UIImage *)placeholder
                 progress:(SDWebImageDownloaderProgressBlock)progressBlock
                completed:(SDWebImageCompletionBlock)completionBlock;

@end
