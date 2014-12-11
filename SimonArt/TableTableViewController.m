//
//  TableTableViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/8/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "TableTableViewController.h"
#import "InstagramTableViewCell.h"
#import "InstagramClient.h"
#import "InstagramPhoto.h"
#import "LiveFrost.h"
#import "CustomShareButton.h"

#import <Pinterest/Pinterest.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface TableTableViewController () <InstagramTableViewCellDelegate, MFMailComposeViewControllerDelegate>

@property NSCache *standardImageCache;
@property NSMutableArray *photosArray;
@property InstagramClient *instagramClient;
@property BOOL profileViewIsShowing;
@property BOOL shareViewIsShowing;

@property UIView *shareView;

@property UIView *profileView;
@property LFGlassView *blurView;
@property UIImageView *profileImageView;

@property InstagramPhoto *selectedInstagramPhoto;


@property NSMutableArray *flippedIndexPaths;

@end

@implementation TableTableViewController{
    Pinterest*  _pinterest;
}

-(void)cellShareButtonTapped:(InstagramPhoto *)instagramPhoto{
    self.selectedInstagramPhoto = instagramPhoto;
    self.shareView = [[UIView alloc] initWithFrame:self.view.frame];
    
    [self.navigationController.view addSubview:self.shareView];
    self.shareView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    [self createShareView];
    self.shareView.hidden = YES;
    self.shareView.alpha = 0;
    self.shareViewIsShowing = NO;
    
    if (!self.shareViewIsShowing) {
        [UIView animateWithDuration:0.6
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.shareView.hidden = NO;
                             self.shareView.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             self.shareViewIsShowing = YES;
                         }];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Share Feature
    _pinterest = [[Pinterest alloc] initWithClientId:@"1441873"];

    self.instagramClient = [InstagramClient sharedInstagramClient];
    self.flippedIndexPaths = [NSMutableArray array];
    
    self.profileView = [[UIView alloc] initWithFrame:self.tableView.frame];
    [self.tableView addSubview:self.profileView];
    
    
    self.profileView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    [self createProfileView];
    self.profileView.hidden = YES;
    self.profileView.alpha = 0;
    self.profileViewIsShowing = NO;
    

    for (int i = 0; i < self.instagramClient.instagramPhotos.count; i++) {
        [self.flippedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    }
    [self.tableView reloadData];
}


-(void)createProfileView{
    CGFloat frameHeight = self.view.frame.size.height;
    CGFloat frameWidth = self.view.frame.size.width;
    
    self.blurView = [[LFGlassView alloc] initWithFrame:self.view.bounds];
    self.blurView.alpha = 0.5;
    [self.profileView addSubview:self.blurView];
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth*.25, frameHeight*.15, frameWidth*.5, frameWidth*.5)];
    self.profileImageView.alpha = 0;
    self.profileImageView.image = [UIImage imageNamed:@"simon_photo"];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageView.backgroundColor = [UIColor greenColor];
    [self.profileView addSubview:self.profileImageView];
    
    UITextView *profileTextView = [[UITextView alloc] initWithFrame:CGRectMake(frameWidth*.1, frameHeight*.45, frameWidth*.8, frameHeight*.4)];
    [profileTextView setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [profileTextView setTextAlignment:NSTextAlignmentCenter];
    [profileTextView setTextColor:[UIColor whiteColor]];
    [profileTextView setEditable:NO];
    [profileTextView setScrollEnabled:NO];
    [profileTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [profileTextView setText:@"Simon Cooper is an American artist and designer currently based in Savannah, Georgia. His interest in the arts began in Buenos Aires, Argentina where he lived and was greatly influenced by Latin-American art and culture. Cooper received his B.F.A. in Illustration, Printmaking from the Savannah College of Art and Design in 2014. Simon continues to explore painting, printmaking and gallery exhibitions."];
    [self.profileView addSubview:profileTextView];
    
    
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
    [self.profileView addSubview:contactButton];
    
}

-(void)createShareView{
    
    CGFloat frameHeight = self.view.frame.size.height;
    CGFloat frameWidth = self.view.frame.size.width;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissShareView)];
    
    [self.shareView addGestureRecognizer:tap];
    
//    self.blurView = [[LFGlassView alloc] initWithFrame:self.view.bounds];
//    self.blurView.alpha = 0.5;
//    [self.shareView addSubview:self.blurView];

    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(frameWidth*.1, frameHeight*.20, frameWidth*.8, frameHeight*.60)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.shareView addSubview:whiteView];
    
    CustomShareButton *pinterestButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(0, 0, whiteView.frame.size.width/2, whiteView.frame.size.height/3)];
    [pinterestButton setTitle:@"Pinterest" forState:UIControlStateNormal];
    [pinterestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pinterestButton setImage:[[UIImage imageNamed:@"pinterest_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    pinterestButton.tintColor = [UIColor colorWithRed:0.753 green:0.000 blue:0.094 alpha:1.000];
    [pinterestButton addTarget:self action:@selector(pinIt:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:pinterestButton];
    
    CustomShareButton *instagramButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(whiteView.frame.size.width*.5, 0, whiteView.frame.size.width/2, whiteView.frame.size.height/3)];
    [instagramButton setTitle:@"Tumblr" forState:UIControlStateNormal];
    [instagramButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [instagramButton setImage:[[UIImage imageNamed:@"instagram_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    instagramButton.tintColor = [UIColor colorWithRed:0.255 green:0.420 blue:0.576 alpha:1.000];
    [instagramButton addTarget:self action:@selector(shareImageOnInstagram) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:instagramButton];
    
    CustomShareButton *facebookButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(0, whiteView.frame.size.height/3, whiteView.frame.size.width/2, whiteView.frame.size.height/3)];
    [facebookButton setTitle:@"Facebook" forState:UIControlStateNormal];
    [facebookButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [facebookButton setImage:[[UIImage imageNamed:@"facebook_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    facebookButton.tintColor = [UIColor colorWithRed:0.204 green:0.290 blue:0.545 alpha:1.000];
    [facebookButton addTarget:self action:@selector(shareToFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:facebookButton];
    
    CustomShareButton *twitterButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(whiteView.frame.size.width*.5, whiteView.frame.size.height/3, whiteView.frame.size.width/2, whiteView.frame.size.height/3)];
    [twitterButton setTitle:@"Twitter" forState:UIControlStateNormal];
    [twitterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [twitterButton setImage:[[UIImage imageNamed:@"twitter_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    twitterButton.tintColor = [UIColor colorWithRed:0.275 green:0.604 blue:0.914 alpha:1.000];
    [twitterButton addTarget:self action:@selector(shareToTwitter:) forControlEvents:UIControlEventTouchUpInside];

    [whiteView addSubview:twitterButton];
    
    CustomShareButton *copyLinkButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(0, (whiteView.frame.size.height - whiteView.frame.size.height/3), whiteView.frame.size.width/2, whiteView.frame.size.height/3)];
    [copyLinkButton setTitle:@"Copy Link" forState:UIControlStateNormal];
    [copyLinkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [copyLinkButton setImage:[[UIImage imageNamed:@"link"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    copyLinkButton.tintColor = [UIColor grayColor];
    [copyLinkButton addTarget:self action:@selector(copyLinkToClipboard:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:copyLinkButton];
    
    CustomShareButton *emailButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(whiteView.frame.size.width*.5, (whiteView.frame.size.height - whiteView.frame.size.height/3), whiteView.frame.size.width/2, whiteView.frame.size.height/3)];
    [emailButton setTitle:@"Email" forState:UIControlStateNormal];
    [emailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [emailButton setImage:[[UIImage imageNamed:@"email"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    emailButton.tintColor = [UIColor grayColor];
    [emailButton addTarget:self action:@selector(showEmail) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:emailButton];
    

    
}

-(void)dismissShareView {
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.shareView.alpha = 0;
                     } completion:^(BOOL finished) {
                         self.shareView.hidden = YES;
                         self.shareViewIsShowing = NO;
                         [self.shareView removeFromSuperview];
                     }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.profileView.center = CGPointMake(self.view.center.x, self.view.center.y + scrollView.contentOffset.y);
//    self.shareView.center = CGPointMake(self.view.center.x, self.view.center.y + scrollView.contentOffset.y);
    [scrollView bringSubviewToFront:self.profileView];
}



- (IBAction)onProfileButtonPressed:(id)sender {
    
        if (!self.profileViewIsShowing) {
            [UIView animateWithDuration:0.6
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 self.profileImageView.alpha = 1.0;
                                 self.profileView.hidden = NO;
                                 self.profileView.alpha = 1.0;
                             } completion:^(BOOL finished) {
                                 self.profileViewIsShowing = YES;
                                 self.tableView.scrollEnabled = NO;
                             }];
        } else {
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 self.profileView.alpha = 0;
                             } completion:^(BOOL finished) {
                                 self.profileView.hidden = YES;
                                 self.profileImageView.alpha = 0;
                                 self.profileViewIsShowing = NO;
                                 self.tableView.scrollEnabled = YES;
                             }];
        }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.instagramClient.instagramPhotos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    InstagramTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!self.standardImageCache){
        self.standardImageCache = [NSCache new];
        NSLog(@"New");
    }
    
    BOOL shouldBeFlipped = [[self.flippedIndexPaths objectAtIndex:indexPath.row] boolValue];
    
    if (shouldBeFlipped){
        cell.standardImageView.hidden = YES;
        NSLog(@"Cell Yes");
    } else {
        cell.standardImageView.hidden = NO;
        NSLog(@"Cell No");
    }
    
    InstagramPhoto *result = [self.instagramClient.instagramPhotos objectAtIndex:indexPath.row];
    cell.instagramPhoto = result;
    cell.artworkNameLabel.text = result.photoText;
    cell.standardImageView.image = result.standardResolutionImage;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstagramTableViewCell *cell = (InstagramTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.delegate = self;
    
    NSLog(cell.isFlipped ? @"Photo" : @" Text");
    
    [UIView beginAnimations:@"FlipCellAnimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
    
    BOOL currentValue = [[self.flippedIndexPaths objectAtIndex:indexPath.row] boolValue];
    BOOL updatedValue = !currentValue;
    
    self.flippedIndexPaths[indexPath.row] = [NSNumber numberWithBool:updatedValue];
    
    if (!cell.isFlipped) {
        cell.standardImageView.hidden = YES;
        cell.isFlipped = YES;
    } else {
        cell.standardImageView.hidden = NO;
        cell.isFlipped = NO;
    }
    
    
    [UIView commitAnimations];
}

- (void)pinIt:(id)sender
{
    [_pinterest createPinWithImageURL:self.selectedInstagramPhoto.standardResolutionPhotoURL
                            sourceURL:[NSURL URLWithString:@"http://www.simoncooperart.com"]
                          description:@"Pinning from Pin It Demo"];
}

- (void)shareToFacebook:(id)sender{
    
    // If the Facebook app is installed and we can present the share dialog
    if([FBDialogs canPresentShareDialogWithPhotos]) {
        NSLog(@"canPresent");
        
        FBPhotoParams *params = [[FBPhotoParams alloc] init];
        params.photos = @[self.selectedInstagramPhoto.standardResolutionImage];
        
        [FBDialogs presentShareDialogWithPhotoParams:params
                                         clientState:nil
                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                 if (error) {
                                                     NSLog(@"Error: %@", error.description);
                                                 } else {
                                                     NSLog(@"Success!");
                                                 }
                                             }];
            
        } else {
        //The user doesn't have the Facebook for iOS app installed, so we can't present the Share Dialog
        /*Fallback: You have two options
         1. Share the photo as a Custom Story using a "share a photo" Open Graph action, and publish it using API calls.
         See our Custom Stories tutorial: https://developers.facebook.com/docs/ios/open-graph
         2. Upload the photo making a requestForUploadPhoto
         See the reference: https://developers.facebook.com/docs/reference/ios/current/class/FBRequest/#requestForUploadPhoto:
         */
    }
    
    
}

- (void)shareToTwitter:(id)sender{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"Cancelled");
                
            } else
                
            {
                NSLog(@"Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"Awesome photo by Simon Coooper"];
        
        //Adding the URL to the facebook post value from iOS
        
        [controller addURL:[NSURL URLWithString:@"http://www.simoncooperart.com"]];
        
        //Adding the Image to the facebook post value from iOS
        [controller addImage:self.selectedInstagramPhoto.standardResolutionImage];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
        
    }
    else{
        NSLog(@"Twitter is unavailable");
    }
}


- (void)showEmail{
    NSString *emailTitle = @"Awesome Painting by Simon Cooper";
    NSString *messageBody = @"Hey, check this painting by Simon Cooper!";
//    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    
    // Get the resource path and read the file using NSData
    UIImage *image = self.selectedInstagramPhoto.standardResolutionImage;
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [mc addAttachmentData:imageData mimeType:@"image/jpeg" fileName:@"SimonArt"];
    
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

-(void)copyLinkToClipboard:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.selectedInstagramPhoto.standardResolutionImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    NSData *imageData = UIImagePNGRepresentation(self.selectedInstagramPhoto.standardResolutionImage);
//    [pasteboard setData:imageData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
    if (error) {
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Unable to save image to Photo Album."
                                          delegate:self
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    }else {
        alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                           message:@"The image was saved."
                                          delegate:self
                                 cancelButtonTitle:@"Cancel"
                                 otherButtonTitles:nil];
        [alert show];
    }
}


-(void)shareImageOnInstagram {
        NSString *urlString = [NSString stringWithFormat:@"instagram://media?id=%@",self.selectedInstagramPhoto.photoIDNumber];
    NSLog(@"%@",urlString);
    NSURL *instagramURL = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
}



@end
