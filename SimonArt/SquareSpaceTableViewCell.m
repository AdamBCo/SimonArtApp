//
//  SquareSpaceTableViewCell.m
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "SquareSpaceTableViewCell.h"

@implementation SquareSpaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.artworkNameLabel.numberOfLines = 0;
    self.artworkNameLabel.adjustsFontSizeToFitWidth = YES;
    self.artworkNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.artworkNameLabel adjustsFontSizeToFitWidth];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)onShareButtonPressed:(id)sender {
    [self.delegate cellShareButtonTapped:self.squarePhoto];
}

@end
