//
//  ShareView.h
//  SimonArt
//
//  Created by Adam Cooper on 12/14/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Pinterest/Pinterest.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

#import "InstagramPhoto.h"

@protocol ShareViewDelegate <NSObject>

-(void)presentMailViewController: (MFMailComposeViewController *)mailViewController;
-(void)presentTwitterViewController: (SLComposeViewController *)twitterViewController;

@end

@interface ShareView : UIView
@property InstagramPhoto *selectedInstagramPhoto;

-(void)createShareView;

@property id<ShareViewDelegate> delegate;

@end
