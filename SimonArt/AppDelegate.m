//
//  AppDelegate.m
//  SimonArt
//
//  Created by Adam Cooper on 12/8/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "AppDelegate.h"
#import "InstagramClient.h"
#import "IntroViewController.h"
#import "LeftMenuViewController.h"
#import "TableViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate ()
@property InstagramClient *instagramClient;
@property UIView *splashScreen;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.instagramClient = [InstagramClient sharedInstagramClient];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)drawSimonLogo {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window bringSubviewToFront:self.splashScreen];
    self.splashScreen = [[UIView alloc] initWithFrame:self.window.frame];
    self.splashScreen.backgroundColor = [UIColor blueColor];
    [self.window addSubview:self.splashScreen];
    UIView *simonLogo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width*.5, self.window.frame.size.height*.5)];
    
    [self.splashScreen addSubview:simonLogo];
    simonLogo.center = self.window.center;
    simonLogo.layer.borderColor = [UIColor yellowColor].CGColor;
    simonLogo.layer.borderWidth = 10.0;
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.window.frame.size.height*.7, self.window.frame.size.width, self.window.frame.size.height*.3)];
    [nameLabel setText:@"Simon Cooper"];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:50.0]];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.alpha = 0;
    [self.splashScreen addSubview:nameLabel];
    
    CGFloat const h = simonLogo.frame.size.height;
    CGFloat const w = simonLogo.frame.size.width;
    
    
    CAShapeLayer *hairOne = [CAShapeLayer new];
    CGMutablePathRef hairOnePath = CGPathCreateMutable();
    CGPathMoveToPoint(hairOnePath, nil, w*.15, h*.99);
    CGPathAddCurveToPoint(hairOnePath, nil, 0, h*.8, w*.4, h*.7, w*.15, h*.5);
    CGPathAddCurveToPoint(hairOnePath, nil, 0, h*.2, w*.4, h*.3, w*.15, h*.01);
    hairOne.path = [UIBezierPath bezierPathWithCGPath:hairOnePath].CGPath;
    hairOne.strokeColor = [UIColor yellowColor].CGColor;
    hairOne.fillColor = [UIColor clearColor].CGColor;
    hairOne.lineWidth = 5;
    
    
    CAShapeLayer *hairTwo = [CAShapeLayer new];
    CGMutablePathRef hairPathTwo = CGPathCreateMutable();
    CGPathMoveToPoint(hairPathTwo, nil, w*.25, h*.99);
    CGPathAddCurveToPoint(hairPathTwo, nil, w*.1, h*.8, w*.5, h*.7, w*.25, h*.5);
    CGPathAddCurveToPoint(hairPathTwo, nil, w*.1, h*.2, w*.5, h*.3, w*.25, h*.01);
    hairTwo.path = [UIBezierPath bezierPathWithCGPath:hairPathTwo].CGPath;
    hairTwo.strokeColor = [UIColor yellowColor].CGColor;
    hairTwo.fillColor = [UIColor clearColor].CGColor;
    hairTwo.lineWidth = 5;
    
    CAShapeLayer *hairThree = [CAShapeLayer new];
    CGMutablePathRef hairThreePath = CGPathCreateMutable();
    CGPathMoveToPoint(hairThreePath, nil, w*.35, h*.99);
    CGPathAddCurveToPoint(hairThreePath, nil, w*.2, h*.8, w*.6, h*.7, w*.35, h*.5);
    CGPathAddCurveToPoint(hairThreePath, nil, w*.2, h*.2, w*.6, h*.3, w*.35, h*.01);
    hairThree.path = [UIBezierPath bezierPathWithCGPath:hairThreePath].CGPath;
    hairThree.strokeColor = [UIColor yellowColor].CGColor;
    hairThree.fillColor = [UIColor clearColor].CGColor;
    hairThree.lineWidth = 5;
    
    CAShapeLayer *face = [CAShapeLayer new];
    CGMutablePathRef facePath = CGPathCreateMutable();
    CGPathMoveToPoint(facePath, nil, w*.7, h*.01);
    CGPathAddLineToPoint(facePath, nil, w*.9, h*.5);
    CGPathAddLineToPoint(facePath, nil, w*.7, h*.55);
    CGPathAddLineToPoint(facePath, nil, w*.75, h);
    face.path = [UIBezierPath bezierPathWithCGPath:facePath].CGPath;
    face.strokeColor = [UIColor yellowColor].CGColor;
    face.fillColor = [UIColor clearColor].CGColor;
    face.lineWidth = 5;
    
    //Draw Eye
    int radius = w*.05;
    CAShapeLayer *eye = [CAShapeLayer new];
    eye.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(w*.6, h*.32, 2.0*radius, 2.0*radius)
                                          cornerRadius:radius].CGPath;
    eye.fillColor = [UIColor clearColor].CGColor;
    eye.strokeColor = [UIColor yellowColor].CGColor;
    eye.lineWidth = 10;
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 2.0;
    drawAnimation.repeatCount         = 1.0;
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //Animate Text Alpha
    [UIView animateWithDuration:2.0 delay:1.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        nameLabel.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
    [hairOne addAnimation:drawAnimation forKey:@"drawHairOneAnimation"];
    [hairTwo addAnimation:drawAnimation forKey:@"drawHairTwoAnimation"];
    [hairThree addAnimation:drawAnimation forKey:@"drawHairThreeAnimation"];
    [face addAnimation:drawAnimation forKey:@"drawFaceAnimation"];
    [eye addAnimation:drawAnimation forKey:@"drawEyeAnimation"];
    [simonLogo.layer addAnimation:drawAnimation forKey:@"drawFrameAnimation"];
    [simonLogo.layer addSublayer:hairOne];
    [simonLogo.layer addSublayer:hairTwo];
    [simonLogo.layer addSublayer:hairThree];
    [simonLogo.layer addSublayer:face];
    [simonLogo.layer addSublayer:eye];
}


#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

@end
