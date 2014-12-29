//
//  IntroLoadingVIew.h
//  SimonArt
//
//  Created by Adam Cooper on 12/26/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroViewDelegate <NSObject>

-(void)introDrawingHasCompleted;

@end

@interface IntroLoadingVIew : UIView

@property UILabel *simonNameLabel;
@property UIButton *closeViewButton;
@property UIActivityIndicatorView *activityIndicator;
@property id<IntroViewDelegate> delegate;

-(void)createIntroLoadingView;

@end
