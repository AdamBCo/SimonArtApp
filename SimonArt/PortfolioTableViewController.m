//
//  PortfolioTableViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "PortfolioTableViewController.h"
#import "SquareSpaceClient.h"
#import "SketchBookClient.h"
#import "SquarePhoto.h"
#import "CustomShareButton.h"
#import "RESideMenu.h"
#import "LeftMenuViewController.h"
#import "SquareSpaceTableViewCell.h"
#import "SketchBookClient.h"

#import "SquareShareView.h"
#import <MessageUI/MessageUI.h>

@interface PortfolioTableViewController () <SquareTableViewCellDelegate, RESideMenuDelegate, SquareShareViewDelegate, MFMailComposeViewControllerDelegate, SquareSpaceClientDelegate>

@property NSCache *standardImageCache;
@property NSMutableArray *photosArray;
@property SquareSpaceClient *squareSpaceClient;
@property SketchBookClient *sketchBookClient;
@property BOOL profileViewIsShowing;
@property BOOL shareViewIsShowing;
@property SquarePhoto *selectedSquarePhoto;
@property UIRefreshControl *refreshControl;

@property BOOL drawingHasFinished;
@property BOOL imagesHaveLoadedFromPlace;


@end

@implementation PortfolioTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"HelveticaNeue-Thin" size:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.squareSpaceClient = [SquareSpaceClient sharedSquareSpaceClient];
    self.squareSpaceClient.delegate = self;
    
    if (self.squareSpaceClient.squarePhotos.count == 0) {
        [self.squareSpaceClient searchForSquarePhotosWithCompletion:^{
            
            for (int i = 0; i < self.squareSpaceClient.squarePhotos.count; i++) {
                [self.squareSpaceClient.flippedPortfolioIndexPaths addObject:[NSNumber numberWithBool:NO]];
            }
            [self.tableView reloadData];
        }];
    } else {
        
        [self.tableView reloadData];
    }
    
}

-(void)imagesHaveLoaded{
    self.imagesHaveLoadedFromPlace = YES;
}

-(void)cellShareButtonTapped:(SquarePhoto *)squarePhoto{
    
    SquareShareView *shareview = [[SquareShareView alloc] initWithFrame:self.view.frame];
    [shareview createShareView];
    shareview.selectedSquarePhoto = squarePhoto;
    shareview.delegate = self;
    shareview.alpha = 0;
    [self.navigationController.view addSubview:shareview];
    shareview.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    
    self.shareViewIsShowing = NO;
    
    if (!self.shareViewIsShowing) {
        [UIView animateWithDuration:0.6
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             shareview.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             self.shareViewIsShowing = YES;
                         }];
    }
    
}

#pragma mark - TableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.squareSpaceClient.squarePhotos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SquareSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!self.standardImageCache){
        self.standardImageCache = [NSCache new];
    }
    
    
    BOOL shouldBeFlipped = [[self.squareSpaceClient.flippedPortfolioIndexPaths objectAtIndex:indexPath.row] boolValue];
    
    if (shouldBeFlipped){
        cell.standardImageView.hidden = YES;
        NSLog(@"Cell Yes");
    } else {
        cell.standardImageView.hidden = NO;
    }
    
    SquarePhoto *result = [self.squareSpaceClient.squarePhotos objectAtIndex:indexPath.row];
    cell.squarePhoto = result;
    cell.artworkNameLabel.text = result.title;
    cell.standardImageView.image = result.squareSpaceImage;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SquareSpaceTableViewCell *cell = (SquareSpaceTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.delegate = self;
    
    
    BOOL shouldBeFlipped = [[self.squareSpaceClient.flippedPortfolioIndexPaths objectAtIndex:indexPath.row] boolValue];
    BOOL updatedValue = !shouldBeFlipped;
    
    self.squareSpaceClient.flippedPortfolioIndexPaths[indexPath.row] = [NSNumber numberWithBool:updatedValue];
    
    [UIView beginAnimations:@"FlipCellAnimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
    
    if (shouldBeFlipped) {
        cell.standardImageView.hidden = NO;
    } else {
        cell.standardImageView.hidden = YES;
    }
    
    [UIView commitAnimations];
}



#pragma mark - ShareView Delegate Methods

-(void)presentMailViewController:(MFMailComposeViewController *)mailViewController{
    mailViewController.mailComposeDelegate = self;
    [self presentViewController:mailViewController animated:YES completion:nil];
}

-(void)presentTwitterViewController:(SLComposeViewController *)twitterViewController{
    [self presentViewController:twitterViewController animated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//
//-(void)introDrawingHasCompleted{
//    self.drawingHasFinished = YES;
//    if (self.imagesHaveLoadedFromPlace == YES) {
//        [UIView animateWithDuration:0.7 animations:^{
//            self.introLoadingView.alpha = 0;
//        } completion:^(BOOL finished) {
//            [self.introLoadingView removeFromSuperview];
//        }];
//    }
//}


@end
