//
//  InstagramClient.h
//  Pixifly
//
//  Created by Adam Cooper on 11/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol InstagramClientDelegate <NSObject>

-(void)imagesHaveLoaded;

@end

@interface InstagramClient : NSObject

@property NSCache *instagramImageCache;
@property NSMutableArray *instagramPhotos;
@property BOOL isLoading;
@property NSMutableArray *flippedInstagramIndexPaths;

+ (instancetype)sharedInstagramClient;
-(void)searchForInstagramPhotosWithCompletion:(void (^)(void))completion;
-(void)requestImageWithURL: (NSURL *)url withCompletion:(void (^)(UIImage *image))completion;

@property id<InstagramClientDelegate> delegate;

@end
