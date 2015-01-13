//
//  SquareShareView.m
//  SimonArt
//
//  Created by Adam Cooper on 1/12/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import "SquareShareView.h"
#import "CustomShareButton.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface SquareShareView () <MFMailComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate>
@property Pinterest *pinterest;
@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation SquareShareView

-(void)createShareView{
    
    self.pinterest = [[Pinterest alloc] initWithClientId:@"1441873"];
    
    CGFloat frameHeight = self.frame.size.height;
    CGFloat frameWidth = self.frame.size.width;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissShareView)];
    
    [self addGestureRecognizer:tap];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(frameWidth*.1, frameHeight*.30, frameWidth*.8, frameHeight*.40)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    
    CustomShareButton *facebookButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(0, 0, whiteView.frame.size.width/2, whiteView.frame.size.height/2)];
    [facebookButton setTitle:@"Facebook" forState:UIControlStateNormal];
    [facebookButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [facebookButton setImage:[[UIImage imageNamed:@"facebook_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    facebookButton.tintColor = [UIColor colorWithRed:0.204 green:0.290 blue:0.545 alpha:1.000];
    [facebookButton addTarget:self action:@selector(shareToFacebook:) forControlEvents:UIControlEventTouchUpInside];
    facebookButton.layer.borderColor = [UIColor grayColor].CGColor;
    facebookButton.layer.borderWidth = .25;
    [whiteView addSubview:facebookButton];
    
    CustomShareButton *twitterButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(whiteView.frame.size.width*.5, 0, whiteView.frame.size.width/2, whiteView.frame.size.height/2)];
    [twitterButton setTitle:@"Twitter" forState:UIControlStateNormal];
    [twitterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [twitterButton setImage:[[UIImage imageNamed:@"twitter_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    twitterButton.tintColor = [UIColor colorWithRed:0.275 green:0.604 blue:0.914 alpha:1.000];
    [twitterButton addTarget:self action:@selector(shareToTwitter:) forControlEvents:UIControlEventTouchUpInside];
    twitterButton.layer.borderColor = [UIColor grayColor].CGColor;
    twitterButton.layer.borderWidth = .25;
    [whiteView addSubview:twitterButton];
    
    CustomShareButton *savePhotoButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(0, (whiteView.frame.size.height*.5), whiteView.frame.size.width/2, whiteView.frame.size.height/2)];
    [savePhotoButton setTitle:@"Save Image" forState:UIControlStateNormal];
    [savePhotoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savePhotoButton setImage:[[UIImage imageNamed:@"link"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    savePhotoButton.tintColor = [UIColor grayColor];
    [savePhotoButton addTarget:self action:@selector(savePhotoToCameraRoll) forControlEvents:UIControlEventTouchUpInside];
    savePhotoButton.layer.borderColor = [UIColor grayColor].CGColor;
    savePhotoButton.layer.borderWidth = .25;
    [whiteView addSubview:savePhotoButton];
    
    CustomShareButton *emailButton = [[CustomShareButton alloc] initWithFrame:CGRectMake(whiteView.frame.size.width*.5, whiteView.frame.size.height*.5, whiteView.frame.size.width/2, whiteView.frame.size.height/2)];
    [emailButton setTitle:@"Email" forState:UIControlStateNormal];
    [emailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [emailButton setImage:[[UIImage imageNamed:@"email"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    emailButton.tintColor = [UIColor grayColor];
    [emailButton addTarget:self action:@selector(showEmail) forControlEvents:UIControlEventTouchUpInside];
    emailButton.layer.borderColor = [UIColor grayColor].CGColor;
    emailButton.layer.borderWidth = .25;
    [whiteView addSubview:emailButton];
}


-(void)dismissShareView {
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - Instagram

-(void)shareImageOnInstagram {
    
}


#pragma mark - Email Photo

- (void)showEmail{
    NSString *emailTitle = @"Awesome Painting by Simon Cooper";
    NSString *messageBody = @"Hey, check this painting by Simon Cooper!";
    //    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    
    // Get the resource path and read the file using NSData
    UIImage *image = self.selectedSquarePhoto.squareSpaceImage;
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [mc addAttachmentData:imageData mimeType:@"image/jpeg" fileName:@"SimonArt"];
    
    // Present mail view controller on screen
    [self.delegate presentMailViewController:mc];
}

#pragma mark - Copy Link

-(void)savePhotoToCameraRoll{
    UIImage *image = self.selectedSquarePhoto.squareSpaceImage;
    UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
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
    }
    
    [alert show];
}

#pragma mark - Twitter

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
        [controller setInitialText:@"Awesome artwork by Simon Coooper"];
        
        //Adding the URL to the facebook post value from iOS
        
        [controller addURL:[NSURL URLWithString:@"http://www.simoncooperart.com"]];
        
        //Adding the Image to the facebook post value from iOS
        [controller addImage:self.selectedSquarePhoto.squareSpaceImage];
        
        [self.delegate presentTwitterViewController:controller];
        
    }
    else{
        NSLog(@"Twitter is unavailable");
    }
}

#pragma mark - Pinterest

- (void)pinIt:(id)sender
{
#warning Need to fix
//    [_pinterest createPinWithImageURL:self.selectedInstagramPhoto.standardResolutionPhotoURL
//                            sourceURL:[NSURL URLWithString:@"http://www.simoncooperart.com"]
//                          description:@"Awesome artwork by Simon Coooper"];
}

#pragma mark - Facebook

- (void)shareToFacebook:(id)sender{
    
    // If the Facebook app is installed and we can present the share dialog
    if([FBDialogs canPresentShareDialogWithPhotos]) {
        NSLog(@"canPresent");
        
        FBPhotoParams *params = [[FBPhotoParams alloc] init];
        params.photos = @[self.selectedSquarePhoto.squareSpaceImage];
        
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

@end
