//
//  ContactViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/15/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ContactViewController.h"
#import <MessageUI/MessageUI.h>
#import "CustomShareButton.h"

@interface ContactViewController () <MFMailComposeViewControllerDelegate>
@property UIButton *contactViaEmail;
@property UIButton *goToPersonalWebsite;
@property CustomShareButton *contactViaFacebook;

@property UILabel *userMessageLabel;

@end

@implementation ContactViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"HelveticaNeue-Thin" size:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.title = @"Contact";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat frameHeight = self.view.frame.size.height;
    CGFloat frameWidth = self.view.frame.size.width;
    
    
    UIImageView *borderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, frameWidth, frameHeight*.5)];
    borderImageView.image = [UIImage imageNamed:@"cool_Border"];
    [self.view addSubview:borderImageView];
    
    UITextView *forAllMessagesLabel = [[UITextView alloc] initWithFrame:CGRectMake(frameWidth*.05, frameHeight*.55, frameWidth*.9, frameHeight*.15)];
    [forAllMessagesLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
    forAllMessagesLabel.scrollEnabled = NO;
    forAllMessagesLabel.editable = NO;
    [forAllMessagesLabel setTextAlignment:NSTextAlignmentCenter];
    forAllMessagesLabel.text = @"For all questions related to my work please use the links provided below:";
    [self.view addSubview:forAllMessagesLabel];
    
    self.contactViaEmail = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.05, frameHeight*.65, frameWidth*.9, frameHeight*.075)];
    [self.contactViaEmail setTitle:@"Email" forState:UIControlStateNormal];
    [self.contactViaEmail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contactViaEmail.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:24.0]];
    [self.contactViaEmail setImage:[[UIImage imageNamed:@"email"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.contactViaEmail setImageEdgeInsets:UIEdgeInsetsMake(self.contactViaEmail.frame.size.height*.15, -30, self.contactViaEmail.frame.size.height*.15, -12)];
    self.contactViaEmail.tintColor = [UIColor blackColor];
    self.contactViaEmail.layer.borderColor = [UIColor blackColor].CGColor;
    self.contactViaEmail.layer.borderWidth = 0.5;
    [self.contactViaEmail addTarget:self action:@selector(emailMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.contactViaEmail];
    
    self.goToPersonalWebsite = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.05, frameHeight*.75, frameWidth*.9, frameHeight*.075)];
    [self.goToPersonalWebsite setTitle:@"WWW.SIMONCOOPERART.COM" forState:UIControlStateNormal];
    [self.goToPersonalWebsite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.goToPersonalWebsite.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [self.goToPersonalWebsite setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    self.goToPersonalWebsite.tintColor = [UIColor blackColor];
    self.goToPersonalWebsite.layer.borderColor = [UIColor blackColor].CGColor;
    self.goToPersonalWebsite.layer.borderWidth = 0.5;
    [self.goToPersonalWebsite addTarget:self action:@selector(goToPersonalHomePage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.goToPersonalWebsite];
    
    
    CustomShareButton *facebookButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(0, frameHeight*.825, frameWidth/3, frameWidth/3)];
    [facebookButton setTitle:@"Facebook" forState:UIControlStateNormal];
    [facebookButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [facebookButton setImage:[[UIImage imageNamed:@"facebook_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    facebookButton.tintColor = [UIColor colorWithRed:0.204 green:0.290 blue:0.545 alpha:1.000];
    facebookButton.layer.borderColor = [UIColor clearColor].CGColor;
    [facebookButton addTarget:self action:@selector(goToFacebookPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookButton];
    
    CustomShareButton *instagramButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(frameWidth/3, frameHeight*.825, frameWidth/3, frameWidth/3)];
    [instagramButton setTitle:@"Instagram" forState:UIControlStateNormal];
    [instagramButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [instagramButton setImage:[[UIImage imageNamed:@"instagram_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    instagramButton.tintColor = [UIColor colorWithRed:0.255 green:0.420 blue:0.576 alpha:1.000];
    instagramButton.layer.borderColor = [UIColor clearColor].CGColor;
    [instagramButton addTarget:self action:@selector(goToInstagramPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:instagramButton];
    
    
    CustomShareButton *linkedInButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(frameWidth - (frameWidth/3), frameHeight*.825, frameWidth/3, frameWidth/3)];
    [linkedInButton setTitle:@"LinkedIn" forState:UIControlStateNormal];
    [linkedInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [linkedInButton setImage:[[UIImage imageNamed:@"linkedIn_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    linkedInButton.tintColor = [UIColor colorWithRed:0.090 green:0.439 blue:0.678 alpha:1.000];
    linkedInButton.layer.borderColor = [UIColor clearColor].CGColor;
    [linkedInButton addTarget:self action:@selector(goToLinkedInPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:linkedInButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)emailMe {
    NSString *emailTitle = @"Hey Simon";
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)goToFacebookPage {
    NSURL *facebookURL = [NSURL URLWithString:@"fb://profile/149561191827138"];
    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
        [[UIApplication sharedApplication] openURL:facebookURL];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com"]];
    }
}

-(void)goToInstagramPage {
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://user?username=shaktaya"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
    
}

-(void)goToLinkedInPage {
    NSURL *url = [NSURL URLWithString:@"https://www.linkedin.com/pub/simon-b-cooper/40/b24/500"];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
}

-(void)goToPersonalHomePage {
    NSURL *url = [NSURL URLWithString:@"http://www.simoncooperart.com"];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
    
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
