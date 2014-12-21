//
//  ResumeDetailViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/18/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ResumeDetailViewController.h"

@interface ResumeDetailViewController () <UIWebViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property UIActivityIndicatorView *activityView;

@end

@implementation ResumeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scrollView.delegate = self;
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.frame = self.view.frame;
    [self.view addSubview:self.activityView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [self loadPage:self.selectedUrlString];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadPage: (NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    self.activityView.backgroundColor = [UIColor purpleColor];
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
