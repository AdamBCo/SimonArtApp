//
//  IntroLoadingVIew.m
//  SimonArt
//
//  Created by Adam Cooper on 12/26/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "IntroLoadingVIew.h"

@implementation IntroLoadingVIew


-(void)createIntroLoadingView {
    [self drawSimonLogo];
    
    self.simonNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*.75, self.frame.size.width, self.frame.size.height*.1)];
    [self.simonNameLabel setText:@"Simon Cooper"];
    [self.simonNameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.simonNameLabel setTextColor:[UIColor whiteColor]];
    [self.simonNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:40.0]];
    [self addSubview:self.simonNameLabel];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = CGPointMake(self.frame.size.width*.5, self.frame.size.height*.95);
    self.activityIndicator.hidesWhenStopped = NO;
    [self addSubview:self.activityIndicator];
}


- (void)drawSimonLogo {
    UIView *simonLogo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*.5, self.frame.size.height*.5)];
    [self addSubview:simonLogo];
    simonLogo.center = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height*.48);
    simonLogo.layer.borderColor = [UIColor yellowColor].CGColor;
    simonLogo.layer.borderWidth = 10.0;
    
    
    CGFloat const h = simonLogo.frame.size.height;
    CGFloat const w = simonLogo.frame.size.width;
    
    CAShapeLayer *hairOne = [CAShapeLayer new];
    CGMutablePathRef hairOnePath = CGPathCreateMutable();
    CGPathMoveToPoint(hairOnePath, nil, w*.15, h);
    CGPathAddQuadCurveToPoint(hairOnePath, nil, w*.05, h*.8, w*.15, h*.7);
    CGPathMoveToPoint(hairOnePath, nil, w*.15,h*.7);
    CGPathAddQuadCurveToPoint(hairOnePath, nil, w*.25, h*.6, w*.15, h*.5);
    CGPathMoveToPoint(hairOnePath, nil, w*.15, h*.5);
    CGPathAddQuadCurveToPoint(hairOnePath, nil, w*.05, h*.4, w*.15, h*.3);
    CGPathMoveToPoint(hairOnePath, nil, w*.15,h*.3);
    CGPathAddQuadCurveToPoint(hairOnePath, nil, w*.25, h*.2, w*.15, h*.01);
    
    hairOne.path = [UIBezierPath bezierPathWithCGPath:hairOnePath].CGPath;
    hairOne.strokeColor = [UIColor yellowColor].CGColor;
    hairOne.fillColor = [UIColor clearColor].CGColor;
    hairOne.lineWidth = 5;
    
    
    CAShapeLayer *hairTwo = [CAShapeLayer new];
    CGMutablePathRef hairTwoPath = CGPathCreateMutable();
    CGPathMoveToPoint(hairTwoPath, nil, w*.25, h);
    CGPathAddQuadCurveToPoint(hairTwoPath, nil, w*.15, h*.8, w*.25, h*.7);
    CGPathMoveToPoint(hairTwoPath, nil, w*.25,h*.7);
    CGPathAddQuadCurveToPoint(hairTwoPath, nil, w*.35, h*.6, w*.25, h*.5);
    CGPathMoveToPoint(hairTwoPath, nil, w*.25, h*.5);
    CGPathAddQuadCurveToPoint(hairTwoPath, nil, w*.15, h*.4, w*.25, h*.3);
    CGPathMoveToPoint(hairTwoPath, nil, w*.25,h*.3);
    CGPathAddQuadCurveToPoint(hairTwoPath, nil, w*.35, h*.2, w*.25, h*.01);
    hairTwo.path = [UIBezierPath bezierPathWithCGPath:hairTwoPath].CGPath;
    hairTwo.strokeColor = [UIColor yellowColor].CGColor;
    hairTwo.fillColor = [UIColor clearColor].CGColor;
    hairTwo.lineWidth = 5;
    
    CAShapeLayer *hairThree = [CAShapeLayer new];
    CGMutablePathRef hairThreePath = CGPathCreateMutable();
    CGPathMoveToPoint(hairThreePath, nil, w*.35, h);
    CGPathAddQuadCurveToPoint(hairThreePath, nil, w*.25, h*.8, w*.35, h*.7);
    CGPathMoveToPoint(hairThreePath, nil, w*.35,h*.7);
    CGPathAddQuadCurveToPoint(hairThreePath, nil, w*.45, h*.6, w*.35, h*.5);
    CGPathMoveToPoint(hairThreePath, nil, w*.35, h*.5);
    CGPathAddQuadCurveToPoint(hairThreePath, nil, w*.25, h*.4, w*.35, h*.3);
    CGPathMoveToPoint(hairThreePath, nil, w*.35,h*.3);
    CGPathAddQuadCurveToPoint(hairThreePath, nil, w*.45, h*.2, w*.35, h*.01);
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
//        self.logoNameButton.alpha = 1;
//        self.clickHereButton.alpha = 1;
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

@end
