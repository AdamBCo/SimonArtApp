//
//  SquarePhoto.h
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SquarePhoto : NSObject

@property (readonly) NSString *title;
@property (readonly) NSString *urlStringForSquarePhoto;

@property UIImage *squareSpaceImage;

-(instancetype)initWithCreateSquarePhoto:(NSDictionary *)squareJSONData;

@end
