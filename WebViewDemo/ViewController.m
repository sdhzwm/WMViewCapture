//
//  ViewController.m
//  WebViewDemo
//
//  Created by WM on 2017/5/26.
//  Copyright © 2017年 wm. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "WKWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)webViewAction:(UIButton *)sender {
    if(sender.tag == 1) {
        WebViewController *webViewVC = [WebViewController new];
        [self.navigationController pushViewController:webViewVC animated:YES];
    } else {
        WKWebViewController *wkWebViewVC = [WKWebViewController new];
        [self.navigationController pushViewController:wkWebViewVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
