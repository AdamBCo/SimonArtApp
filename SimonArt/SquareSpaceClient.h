//
//  SquareSpaceClient.h
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol SquareSpaceClientDelegate <NSObject>

@optional
-(void)portfolioImagesHaveLoaded;
-(void)sketchBookImagesHaveLoaded;

@end

@interface SquareSpaceClient : NSObject

+ (instancetype)sharedSquareSpaceClient;

@property NSString *siteDescription;

//Portfolio Photos
@property NSCache *portfolioImageCache;
@property NSMutableArray *portfolioPhotos;
@property NSMutableArray *flippedPortfolioIndexPaths;
@property BOOL portfolioPhotosAreDownloading;

-(void)searchForPortfolioPhotosWithCompletion:(void (^)(void))completion;

//SketchBook Photos
@property NSCache *sketchBookImageCache;
@property NSMutableArray *sketchBookPhotos;
@property NSMutableArray *flippedSketchBookIndexPaths;
@property BOOL sketchBookPhotosAreDownloading;

-(void)searchForSketchbookPhotosWithCompletion:(void (^)(void))completion;
//-(void)requestPortfolioImageWithURL: (NSString *)url withCompletion:(void (^)(UIImage *image))completion;

@property id<SquareSpaceClientDelegate> delegate;

@end
