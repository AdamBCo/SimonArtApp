//
//  InstagramPhoto.h
//  Pixifly
//
//  Created by Adam Cooper on 10/16/14.
//  Copyright (c) 2014 Pixifly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface InstagramPhoto : NSObject

@property (readonly) NSString *fullName;
@property (readonly) NSString *userName;
@property (readonly) NSNumber *idNumber;
@property (readonly) NSString *timeCreatedUNIX;

//Image Photos
@property UIImage * profileImage;
@property (readonly) NSURL *profileImageURL;
@property UIImage * thumbnailImage;
@property (readonly) NSURL *thumbnailImageURL;
@property UIImage * standardResolutionImage;
@property (readonly) NSURL *standardResolutionPhotoURL;

@property (readonly) NSString *photoIDNumber;
@property (readonly) NSString *photoText;
@property (readonly) NSString *timeCreated;
@property (readonly) NSNumber *numberOfLikes;
@property (readonly) NSArray *numberOfComments;
@property (readonly) CLLocationCoordinate2D photoLocation;
@property (readonly) NSURL *urlForInstagramPhoto;

-(instancetype)initWithCreateInstagramPhoto:(NSDictionary *)instagramJSONData;

@end
