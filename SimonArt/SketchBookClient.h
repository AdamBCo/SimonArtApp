//
//  SketchBookClient.h
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SketchBookClient : NSObject

//Image Caches
@property NSCache *standardImageCache;
@property NSMutableArray *squarePhotos;
@property BOOL isLoading;

+ (instancetype)sharedSquareSpaceClient;
-(void)searchForSquarePhotosWithCompletion:(void (^)(void))completion;
-(void)requestImageWithURL: (NSString *)url withCompletion:(void (^)(UIImage *image))completion;

@end
