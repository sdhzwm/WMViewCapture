//
//  WKWebView+ViewCapture.h
//  WebViewDemo
//
//  Created by 王蒙 on 2017/7/26.
//  Copyright © 2017年 wm. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (ViewCapture)

- (UIImage *)coverImage;

- (void)screenShotCompletion:(void(^)(UIImage *image))completion;

@end
