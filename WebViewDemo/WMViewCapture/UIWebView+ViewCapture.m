//
//  UIWebView+ViewCapture.m
//  WebViewDemo
//
//  Created by WM on 2017/7/26.
//  Copyright © 2017年 wm. All rights reserved.
//

#import "UIWebView+ViewCapture.h"

@implementation UIWebView (ViewCapture)

- (UIImage *)coverImage {
    UIImage *coverImage = [self screenShot];
    return coverImage;
}

- (void)screenShotCompletion:(void(^)(UIImage *image))completion {

    CGRect oldFrame = self.frame;
    CGPoint oldOffset = self.scrollView.contentOffset;
    CGRect newFrame = oldFrame;
    newFrame.size.height = self.scrollView.contentSize.height;
    
    [self.scrollView setContentOffset:CGPointZero];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.frame = newFrame;
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIImage *image = [self screenShot];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.scrollView setContentOffset:oldOffset];
            self.frame = oldFrame;
            completion(image);
        });
    });
}

- (UIImage *)screenShot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return shotImage;
}

@end
