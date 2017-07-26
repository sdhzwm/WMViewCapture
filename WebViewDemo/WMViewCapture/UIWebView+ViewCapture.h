//
//  UIWebView+ViewCapture.h
//  WebViewDemo
//
//  Created by WM on 2017/7/26.
//  Copyright © 2017年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (ViewCapture)

- (UIImage *)coverImage;

- (void)screenShotCompletion:(void(^)(UIImage *image))completion;
@end
