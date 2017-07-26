//
//  WebViewController.m
//  WebViewDemo
//
//  Created by WM on 2017/5/26.
//  Copyright © 2017年 wm. All rights reserved.
//

#import "WebViewController.h"
#import "UIWebView+ViewCapture.h"
#import "ImageViewController.h"
@interface WebViewController ()<UIScrollViewDelegate,UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截屏" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItems = @[rightBarButtonItem,leftBarButtonItem];
    
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    self.webView.frame = CGRectMake(0, 64, w, h-64);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}
- (void)leftButtonClick {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.webView loadRequest:request];
}

- (void)rightButtonClick
{
    //图片遮盖住，保证用户看不到跳动
    UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:self.webView.frame];
    coverImageView.image = [self.webView coverImage];
    
    [self.view addSubview:coverImageView];
    //截图
    [self.webView screenShotCompletion:^(UIImage *image) {
//        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [coverImageView removeFromSuperview];
//        });
        [self.webView screenShotCompletion:^(UIImage *image) {
            
            [coverImageView removeFromSuperview];
            ImageViewController *imageVC = [[ImageViewController alloc] initWith:image];
            
            [self.navigationController pushViewController:imageVC animated:YES];
        }];

    }];
}

#pragma mark - completionSelector
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存失败");
    } else {
        NSLog(@"保存成功");
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}



@end
