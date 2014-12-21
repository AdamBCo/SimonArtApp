//
//  ResumePDFViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/21/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ResumePDFViewController.h"

@interface ResumePDFViewController ()<UIWebViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ResumePDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Resume" ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:targetURL];
    [self.webView loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:targetURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
