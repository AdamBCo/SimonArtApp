//
//  InstagramClient.h
//  Pixifly
//
//  Created by Adam Cooper on 11/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface InstagramClient : NSObject

//Image Caches
@property NSCache *standardImageCache;
@property NSMutableArray *instagramPhotos;
@property BOOL isLoading;

+ (instancetype)sharedInstagramClient;
-(void)searchForInstagramPhotosWithCompletion:(void (^)(void))completion;

@end
