//
//  InstagramTableViewCell.h
//  Pixifly
//
//  Created by Adam Cooper on 11/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstagramTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *standardImageView;
@property (weak, nonatomic) IBOutlet UILabel *artworkNameLabel;
@property BOOL isFlipped;

@property (nonatomic, strong) NSURLSessionDataTask *standardImageDownloadTask;
@property (nonatomic, strong) NSURLSessionDataTask *profileImageDownloadTask;


@end
