# WMViewCapture
--

#### WMViewCapture目前支持UIWebView和WKWebView，能够截取网页的所有内容。


### 用法

```swift
	UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:self.webView.frame];
    coverImageView.image = [self.webView coverImage];
    
    [self.view addSubview:coverImageView];
    //截图
    [self.webView screenShotCompletion:^(UIImage *image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [coverImageView removeFromSuperview];
        });
     }];    

```



