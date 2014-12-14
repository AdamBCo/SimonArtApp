//
//  ViewController.h
//  SimonArt
//
//  Created by Adam Cooper on 12/8/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroViewDelegate <NSObject>

-(void)onEnterAppButtonPressed;

@end

@interface IntroViewController : UIViewController

@property id<IntroViewDelegate> delegate;


@end

