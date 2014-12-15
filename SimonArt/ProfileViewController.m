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
@property  UIImageView *profileImageView;
@property UILabel *bioLabel;
@property UILabel *educationLabel;
@property UILabel *exhibitsLabel;
@property UILabel *publicationsLabel;
@property UILabel *publicArtLabel;

@end

@implementation ProfileViewController

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"HelveticaNeue-Thin" size:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.75);
    [self.view addSubview:scrollview];
    
    CGFloat frameHeight = scrollview.frame.size.height;
    CGFloat frameWidth = scrollview.frame.size.width;
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth*.25, frameHeight*.02, frameWidth*.5, frameWidth*.5)];
    self.profileImageView.image = [UIImage imageNamed:@"simon_photo"];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageView.backgroundColor = [UIColor greenColor];
    [scrollview addSubview:self.profileImageView];
    
    self.bioLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*.30, frameWidth, frameHeight*.05)];
    self.bioLabel.text = @"Bio";
    [self.bioLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:22.0]];
    [self.bioLabel setTextColor:[UIColor whiteColor]];
    [scrollview addSubview:self.bioLabel];
    
    UITextView *bioTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, frameHeight*.35, frameWidth, frameHeight*.35)];
    [bioTextView setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [bioTextView setTextAlignment:NSTextAlignmentCenter];
    [bioTextView setTextColor:[UIColor whiteColor]];
    [bioTextView setEditable:NO];
    [bioTextView setScrollEnabled:NO];
    [bioTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [bioTextView setText:@"Simon Cooper is an American artist and designer currently based in Savannah, Georgia. His interest in the arts began in Buenos Aires, Argentina where he lived and was greatly influenced by Latin-American art and culture. Cooper received his B.F.A. in Illustration, Printmaking from the Savannah College of Art and Design in 2014. Simon continues to explore painting, printmaking and gallery exhibitions."];
    [scrollview addSubview:bioTextView];
    
    
    self.educationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*.7, frameWidth, frameHeight*.05)];
    self.educationLabel.text = @"Education";
    [self.educationLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:22.0]];
    [self.educationLabel setTextColor:[UIColor whiteColor]];
    [scrollview addSubview:self.educationLabel];
    
    UITextView *educationTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, frameHeight*.75, frameWidth, frameHeight*.15)];
    [educationTextView setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [educationTextView setTextAlignment:NSTextAlignmentCenter];
    [educationTextView setTextColor:[UIColor whiteColor]];
    [educationTextView setEditable:NO];
    [educationTextView setScrollEnabled:NO];
    [educationTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [educationTextView setText:@"Savannah College of Art and Design\n(2010-2014)\nB.F.A. Illustration, Printmaking"];
    [scrollview addSubview:educationTextView];
    
    self.exhibitsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*.9, frameWidth, frameHeight*.05)];
    self.exhibitsLabel.text = @"Exhibits";
    [self.exhibitsLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:22.0]];
    [self.exhibitsLabel setTextColor:[UIColor whiteColor]];
    [scrollview addSubview:self.exhibitsLabel];
    
    UILabel *showOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*.95, frameWidth, frameHeight*.05)];
    showOneLabel.text = @"2014 The Meantime: Solo Exhibition";
    [showOneLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [showOneLabel setTextColor:[UIColor whiteColor]];
    [showOneLabel setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:showOneLabel];
    
    UILabel *showTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight, frameWidth, frameHeight*.05)];
    showTwoLabel.text = @"2014 Society of Illustrators Student Scholarship";
    [showTwoLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [showTwoLabel setTextColor:[UIColor whiteColor]];
    [showTwoLabel setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:showTwoLabel];
    
    UILabel *showThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.05, frameWidth, frameHeight*.05)];
    showThreeLabel.text = @"2014 Love Is A Monoprint";
    [showThreeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [showThreeLabel setTextColor:[UIColor whiteColor]];
    [showThreeLabel setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:showThreeLabel];
    
    UILabel *showFourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.10, frameWidth, frameHeight*.05)];
    showFourLabel.text = @"2013 Student International Small Print Show";
    [showFourLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [showFourLabel setTextColor:[UIColor whiteColor]];
    [showFourLabel setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:showFourLabel];
    
    UILabel *showFiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.15, frameWidth, frameHeight*.05)];
    showFiveLabel.text = @"2013 Porteno: Solo Exhibition";
    [showFiveLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [showFiveLabel setTextColor:[UIColor whiteColor]];
    [showFiveLabel setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:showFiveLabel];
    
    UILabel *showSixLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.20, frameWidth, frameHeight*.05)];
    showSixLabel.text = @"2013 SHAKTAYA: Solo Exhibition";
    [showSixLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [showSixLabel setTextColor:[UIColor whiteColor]];
    [showSixLabel setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:showSixLabel];
    
    
    
    
    self.publicationsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.25, frameWidth, frameHeight*.05)];
    self.publicationsLabel.text = @"Publications";
    [self.publicationsLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:22.0]];
    [self.publicationsLabel setTextColor:[UIColor whiteColor]];
    [scrollview addSubview:self.publicationsLabel];
    
    
    
    UILabel *publicationOne = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.3, frameWidth*.85, frameHeight*.05)];
    publicationOne.text = @"2014 Society of Illustrators";
    [publicationOne setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [publicationOne setTextColor:[UIColor whiteColor]];
    [publicationOne setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:publicationOne];
    
    UIButton *publicationButtonOne = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.85, frameHeight*1.3, frameWidth*.15, frameHeight*.05)];
    publicationButtonOne.backgroundColor = [UIColor greenColor];
    [scrollview addSubview:publicationButtonOne];
    
    
    
    UILabel *publicationTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.35, frameWidth*.85, frameHeight*.05)];
    publicationTwo.text = @"2013 S.C.A.D Catalogue";
    [publicationTwo setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [publicationTwo setTextColor:[UIColor whiteColor]];
    [publicationTwo setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:publicationTwo];
    
    UIButton *publicationButtonTwo = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.85, frameHeight*1.35, frameWidth*.15, frameHeight*.05)];
    publicationButtonTwo.backgroundColor = [UIColor greenColor];
    [scrollview addSubview:publicationButtonTwo];
    
    
    
    UILabel *publicationThree = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.4, frameWidth*.85, frameHeight*.05)];
    publicationThree.text = @"2013 Port City Review";
    [publicationThree setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [publicationThree setTextColor:[UIColor whiteColor]];
    [publicationThree setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:publicationThree];
    
    UIButton *publicationButtonThree = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.85, frameHeight*1.4, frameWidth*.15, frameHeight*.05)];
    publicationButtonThree.backgroundColor = [UIColor greenColor];
    [scrollview addSubview:publicationButtonThree];
    
    UILabel *publicationFour = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.45, frameWidth*.85, frameHeight*.05)];
    publicationFour.text = @"2013 Le Snoot Gallery: Featured Artist";
    [publicationFour setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [publicationFour setTextColor:[UIColor whiteColor]];
    [publicationFour setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:publicationFour];
    
    UIButton *publicationButtonFour = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.85, frameHeight*1.45, frameWidth*.15, frameHeight*.05)];
    publicationButtonFour.backgroundColor = [UIColor greenColor];
    [scrollview addSubview:publicationButtonFour];
    
    
    self.publicArtLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.5, frameWidth, frameHeight*.05)];
    self.publicArtLabel.text = @"Public Art";
    [self.publicArtLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:22.0]];
    [self.publicArtLabel setTextColor:[UIColor whiteColor]];
    [scrollview addSubview:self.publicArtLabel];
    
    UILabel *publicArtOne = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.55, frameWidth*.85, frameHeight*.05)];
    publicArtOne.text = @"2013 Le Snoot Gallery: Featured Artist";
    [publicArtOne setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [publicArtOne setTextColor:[UIColor whiteColor]];
    [publicArtOne setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:publicArtOne];
    
    UIButton *publicArtOneButton = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.85, frameHeight*1.55, frameWidth*.15, frameHeight*.05)];
    publicArtOneButton.backgroundColor = [UIColor greenColor];
    [scrollview addSubview:publicArtOneButton];
    
    UILabel *publicArtTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, frameHeight*1.6, frameWidth*.85, frameHeight*.05)];
    publicArtTwo.text = @"2013 Le Snoot Gallery: Featured Artist";
    [publicArtTwo setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [publicArtTwo setTextColor:[UIColor whiteColor]];
    [publicArtTwo setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.250]];
    [scrollview addSubview:publicArtTwo];
    
    UIButton *publicArtTwoButton = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.85, frameHeight*1.6, frameWidth*.15, frameHeight*.05)];
    publicArtTwoButton.backgroundColor = [UIColor greenColor];
    [scrollview addSubview:publicArtTwoButton];

}

//- (void)contactMeByEmail {
//    NSString *emailTitle = @"Hey Simon";
//    NSString *messageBody = @"";
//    NSArray *toRecipents = [NSArray arrayWithObject:@"simonco@comcast.net"];
//    
//    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
//    mc.mailComposeDelegate = self;
//    [mc setSubject:emailTitle];
//    [mc setMessageBody:messageBody isHTML:NO];
//    [mc setToRecipients:toRecipents];
//    
//    // Present mail view controller on screen
//    [self presentViewController:mc animated:YES completion:NULL];
//    
//}


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
