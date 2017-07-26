//
//  WKWebView+ViewCapture.m
//  WebViewDemo
//
//  Created by 王蒙 on 2017/7/26.
//  Copyright © 2017年 wm. All rights reserved.
//

#import "WKWebView+ViewCapture.h"
#define WKMaxHeight 3000
@implementation WKWebView (ViewCapture)
- (UIImage *)coverImage {
    UIImage *coverImage = [self screenShot];
    return coverImage;
}

- (void)screenShotCompletion:(void(^)(UIImage *image))completion {
    
    UIView *oldSuperView = nil;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        oldSuperView = self.superview;
        [self.superview.superview addSubview:self];
    }
    
    CGRect oldFrame = self.frame;
    CGPoint oldOffset = self.scrollView.contentOffset;
    self.scrollView.contentOffset = CGPointZero;
    
    CGRect newFrame = oldFrame;
    
    newFrame.size.height = self.scrollView.contentSize.height;
    if (newFrame.size.height > WKMaxHeight) {
        newFrame.size.height = WKMaxHeight;
    }
    self.frame = newFrame;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIGraphicsBeginImageContextWithOptions(self.scrollView.contentSize, NO, [UIScreen mainScreen].scale);
        
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        CGRect rect = self.bounds;
        [self drawInView:self totalHeight:self.scrollView.contentSize.height rect:rect context:contextRef completion:^{
            
            UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (oldSuperView) {
                    [oldSuperView addSubview:self];
                }
                self.scrollView.contentOffset = oldOffset;
                self.frame = oldFrame;
                completion(shotImage);
            });
            
        }];
        
    });
}

- (void)drawInView:(WKWebView *)webView totalHeight:(CGFloat)totalHeight rect:(CGRect)rect context:(CGContextRef)contextRef completion:(void(^)())completion
{

    [webView drawViewHierarchyInRect:CGRectMake(0, rect.origin.y, webView.bounds.size.width, webView.bounds.size.height) afterScreenUpdates:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGFloat tailingHeight = totalHeight - rect.origin.y - rect.size.height;
        if (tailingHeight > 0) {
            CGFloat offsetY = totalHeight - tailingHeight;
            CGFloat offsetYY = totalHeight - webView.bounds.size.height;
            offsetY = MIN(offsetY, offsetYY);
            
            webView.scrollView.contentOffset = CGPointMake(0, offsetY);
            
            CGRect tailingRect = webView.bounds;
            CGFloat h = MIN(webView.bounds.size.height, tailingHeight);
            tailingRect.origin.y = totalHeight-tailingHeight;
            tailingRect.size.height = h;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self drawInView:webView totalHeight:totalHeight rect:tailingRect context:contextRef completion:completion];
            });
        }
        else {
            completion();
        }
    });
}

- (UIImage *)screenShot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return shotImage;
}

@end
