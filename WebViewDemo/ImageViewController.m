//
//  ImageViewController.m
//  WebViewDemo
//
//  Created by WM on 2017/5/26.
//  Copyright © 2017年 wm. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIImage *capureImage;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ImageViewController
- (instancetype)initWith:(UIImage *)capureImage {
    self = [super init];
    if (self) {
        self.capureImage = capureImage;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat height = 0;
    CGFloat width = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    if(self.capureImage.size.height > self.view.frame.size.height) {
        CGFloat ratio = self.capureImage.size.width/self.capureImage.size.height;
        height = self.view.frame.size.height;
        width =  height * ratio;
    } else {
        height = self.capureImage.size.height;
        width = self.capureImage.size.width;
    }
    if(width > self.view.frame.size.width) {
        CGFloat ratio = width/height;
        width =  self.view.frame.size.width;
        height = width * ratio;
    }
    x = (self.view.frame.size.width - width)/2;
    y = (self.view.frame.size.height - height)/2;
    
    self.imageView = [[UIImageView alloc] initWithImage:self.capureImage];
    
    
    self.imageView.frame = CGRectMake(x, y, width, height);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    self.scrollView.contentSize = CGSizeMake(width, height);
    self.scrollView.delegate = self;
    [self.scrollView setMaximumZoomScale:5];
    
    [self.scrollView addSubview:self.imageView];
    
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
