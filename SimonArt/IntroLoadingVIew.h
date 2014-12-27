//
//  IntroLoadingVIew.h
//  SimonArt
//
//  Created by Adam Cooper on 12/26/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroLoadingVIew : UIView

@property UILabel *simonNameLabel;
@property UIButton *closeViewButton;
@property UIActivityIndicatorView *activityIndicator;

-(void)createIntroLoadingView;

@end
