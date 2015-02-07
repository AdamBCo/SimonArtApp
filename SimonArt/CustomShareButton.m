//
//  CustomShareButton.m
//  SimonArt
//
//  Created by Adam Cooper on 12/10/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "CustomShareButton.h"

@implementation CustomShareButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.imageView.frame;
    
    frame = CGRectMake(truncf((self.bounds.size.width - frame.size.width) / 2), self.bounds.size.height*.3, frame.size.width, frame.size.height);
    self.imageView.frame = frame;
    
    frame = self.titleLabel.frame;
    frame = CGRectMake(truncf((self.bounds.size.width - frame.size.width) / 2), self.bounds.size.height*.55, frame.size.width, frame.size.height);
    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    self.titleLabel.frame = frame;
}

@end
