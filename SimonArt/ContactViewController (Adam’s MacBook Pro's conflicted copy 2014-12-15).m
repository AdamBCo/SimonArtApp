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
@property UIButton *contactViaTwitter;
@property CustomShareButton *contactViaFacebook;
@property UIButton *contactViaBehance;

@property UILabel *userMessageLabel;

@end

@implementation ContactViewController

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"HelveticaNeue-Thin" size:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.title = @"Contact";
    
//    CGFloat frameHeight = self.view.frame.size.height;
//    CGFloat frameWidth = self.view.frame.size.width;
//    
//    self.userMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameWidth*.05, frameHeight*.225, frameWidth*.9, frameHeight*.1)];
//    [self.userMessageLabel setText:@"Thank you"];
//    [self.userMessageLabel setTextAlignment:NSTextAlignmentCenter];
//    [self.userMessageLabel setTextColor:[UIColor whiteColor]];
//    [self.userMessageLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0]];
//    [self.view addSubview:self.userMessageLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat frameHeight = self.view.frame.size.height;
    CGFloat frameWidth = self.view.frame.size.width;
    
    
    UIImageView *borderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight*.45)];
    borderImageView.image = [UIImage imageNamed:@"cool_Border"];
    [self.view addSubview:borderImageView];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(frameWidth*.015, frameHeight*.455, frameWidth*.97, frameHeight*.55)];
    backgroundView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:backgroundView];
    
    self.contactViaEmail = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.05, frameHeight*.5, frameWidth*.9, frameHeight*.1)];
    [self.contactViaEmail setTitle:@"Email" forState:UIControlStateNormal];
    [self.contactViaEmail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contactViaEmail.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0]];
    [self.contactViaEmail setImage:[[UIImage imageNamed:@"email"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.contactViaEmail setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    self.contactViaEmail.tintColor = [UIColor whiteColor];
    self.contactViaEmail.layer.borderColor = [UIColor whiteColor].CGColor;
    self.contactViaEmail.layer.borderWidth = 0.5;
    [self.contactViaEmail addTarget:self action:@selector(emailMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.contactViaEmail];
    
    
    CustomShareButton *facebookButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(0, frameHeight*.7, frameWidth/3, frameWidth/3)];
    [facebookButton setTitle:@"Facebook" forState:UIControlStateNormal];
    [facebookButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [facebookButton setImage:[[UIImage imageNamed:@"facebook_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    facebookButton.tintColor = [UIColor colorWithRed:0.204 green:0.290 blue:0.545 alpha:1.000];
    facebookButton.backgroundColor = [UIColor greenColor];

//    [facebookButton addTarget:self action:@selector(shareToFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookButton];
    
    CustomShareButton *twitterButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(frameWidth/3, frameHeight*.7, frameWidth/3, frameWidth/3)];
    [twitterButton setTitle:@"Facebook" forState:UIControlStateNormal];
    [twitterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [twitterButton setImage:[[UIImage imageNamed:@"twitter_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    twitterButton.tintColor = [UIColor colorWithRed:0.204 green:0.290 blue:0.545 alpha:1.000];
    twitterButton.backgroundColor = [UIColor greenColor];
    //    [facebookButton addTarget:self action:@selector(shareToFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterButton];
    
    
    CustomShareButton *behanceButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(frameWidth - (frameWidth/3), frameHeight*.7, frameWidth/3, frameWidth/3)];
    behanceButton.backgroundColor = [UIColor redColor];
    [behanceButton setTitle:@"Facebook" forState:UIControlStateNormal];
    [behanceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [behanceButton setImage:[[UIImage imageNamed:@"facebook_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    behanceButton.tintColor = [UIColor colorWithRed:0.204 green:0.290 blue:0.545 alpha:1.000];
    //    [facebookButton addTarget:self action:@selector(shareToFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:behanceButton];
//
//    self.contactViaTwitter = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.05, frameHeight*.525, frameWidth*.9, frameHeight*.1)];
//    [self.contactViaTwitter setTitle:@"Twitter" forState:UIControlStateNormal];
//    [self.contactViaTwitter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.contactViaTwitter.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0]];
//    [self.contactViaTwitter setImage:[[UIImage imageNamed:@"twitter_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//    [self.contactViaTwitter setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
//    self.contactViaTwitter.tintColor = [UIColor whiteColor];
//    self.contactViaTwitter.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.contactViaTwitter.layer.borderWidth = 0.5;
//    [self.view addSubview:self.contactViaTwitter];
//    
//    self.contactViaBehance = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.05, frameHeight*.675, frameWidth*.9, frameHeight*.1)];
//    [self.contactViaBehance setTitle:@"Behance" forState:UIControlStateNormal];
//    [self.contactViaBehance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.contactViaBehance.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0]];
//    [self.contactViaEmail setImage:[[UIImage imageNamed:@"email"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//    [self.contactViaEmail setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
//    self.contactViaEmail.tintColor = [UIColor whiteColor];
//    self.contactViaBehance.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.contactViaBehance.layer.borderWidth = 0.5;
//    [self.view addSubview:self.contactViaBehance];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
