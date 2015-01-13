//
//  SquareShareView.h
//  SimonArt
//
//  Created by Adam Cooper on 1/12/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Pinterest/Pinterest.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

#import "SquarePhoto.h"

@protocol SquareShareViewDelegate <NSObject>

-(void)presentMailViewController: (MFMailComposeViewController *)mailViewController;
-(void)presentTwitterViewController: (SLComposeViewController *)twitterViewController;

@end

@interface SquareShareView : UIView
@property SquarePhoto *selectedSquarePhoto;

-(void)createShareView;

@property id<SquareShareViewDelegate> delegate;

@end