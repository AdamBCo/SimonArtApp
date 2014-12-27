//
//  ContentViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/26/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ContentViewController.h"
#include "SquareSpaceClient.h"


@interface ContentViewController ()

@property NSCache *standardImageCache;
@property NSMutableArray *photosArray;
@property BOOL profileViewIsShowing;
@property BOOL shareViewIsShowing;
@property UIView *coverView;
@property SquareSpaceClient *squareSpaceClient;

@property NSMutableArray *flippedIndexPaths;

@end

@implementation ContentViewController

-(void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}



@end
