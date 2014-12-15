//
//  ProfileViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/14/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ProfileViewController.h"
#import <MessageUI/MessageUI.h>

@interface ProfileViewController () <MFMailComposeViewControllerDelegate>
@property UIImageView *profileImageView;

@end

@implementation ProfileViewController

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"HelveticaNeue-Thin" size:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat frameHeight = self.view.frame.size.height;
    CGFloat frameWidth = self.view.frame.size.width;
    
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth*.25, frameHeight*.15, frameWidth*.5, frameWidth*.5)];
    self.profileImageView.image = [UIImage imageNamed:@"simon_photo"];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.profileImageView];
    
    UITextView *profileTextView = [[UITextView alloc] initWithFrame:CGRectMake(frameWidth*.1, frameHeight*.45, frameWidth*.8, frameHeight*.4)];
    [profileTextView setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [profileTextView setTextAlignment:NSTextAlignmentCenter];
    [profileTextView setTextColor:[UIColor whiteColor]];
    [profileTextView setEditable:NO];
    [profileTextView setScrollEnabled:NO];
    [profileTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [profileTextView setText:@"Simon Cooper is an American artist and designer currently based in Savannah, Georgia. His interest in the arts began in Buenos Aires, Argentina where he lived and was greatly influenced by Latin-American art and culture. Cooper received his B.F.A. in Illustration, Printmaking from the Savannah College of Art and Design in 2014. Simon continues to explore painting, printmaking and gallery exhibitions."];
    [self.view addSubview:profileTextView];
    
    
    UIButton *contactButton = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.1, frameHeight*.875, frameWidth*.8, frameHeight*.075)];
    [contactButton setTitle:@"Contact" forState:UIControlStateNormal];
    [contactButton setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [contactButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    contactButton.clipsToBounds = YES;
    contactButton.layer.cornerRadius = 10.0f;
    contactButton.layer.borderColor=[UIColor whiteColor].CGColor;
    contactButton.layer.borderWidth=1.0f;
    
    [contactButton setTintColor:[UIColor blackColor]];
    [contactButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [contactButton addTarget:self action:@selector(contactMeByEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:contactButton];
}

- (void)contactMeByEmail {
    NSString *emailTitle = @"Hey Simon";
    NSString *messageBody = @"";
    NSArray *toRecipents = [NSArray arrayWithObject:@"simonco@comcast.net"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
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


@end
