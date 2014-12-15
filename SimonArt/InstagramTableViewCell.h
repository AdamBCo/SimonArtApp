//
//  InstagramTableViewCell.h
//  Pixifly
//
//  Created by Adam Cooper on 11/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramPhoto.h"

@protocol InstagramTableViewCellDelegate <NSObject>

-(void)cellShareButtonTapped: (InstagramPhoto *)instagramPhoto;

@end

@interface InstagramTableViewCell : UITableViewCell
@property InstagramPhoto *instagramPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *standardImageView;
@property (weak, nonatomic) IBOutlet UILabel *artworkNameLabel;
@property BOOL isFlipped;
@property (nonatomic, strong) NSURLSessionDataTask *standardImageDownloadTask;
@property (nonatomic, strong) NSURLSessionDataTask *profileImageDownloadTask;

@property id<InstagramTableViewCellDelegate> delegate;


@end
