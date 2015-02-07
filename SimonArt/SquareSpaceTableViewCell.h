//
//  SquareSpaceTableViewCell.h
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquarePhoto.h"

@protocol SquareTableViewCellDelegate <NSObject>

-(void)cellShareButtonTapped: (SquarePhoto *)squarePhoto;

@end

@interface SquareSpaceTableViewCell : UITableViewCell
@property SquarePhoto *squarePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *standardImageView;
@property (weak, nonatomic) IBOutlet UILabel *artworkNameLabel;
@property (strong, nonatomic) NSURLSessionDataTask *standardImageDownloadTask;

@property id<SquareTableViewCellDelegate> delegate;

@end
