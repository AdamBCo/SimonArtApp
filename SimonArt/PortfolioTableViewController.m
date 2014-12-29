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
#import "InstagramClient.h"

#import "ShareView.h"
#import <MessageUI/MessageUI.h>
#import "IntroLoadingVIew.h"

@interface PortfolioTableViewController () <SquareTableViewCellDelegate, RESideMenuDelegate, ShareViewDelegate, MFMailComposeViewControllerDelegate, IntroViewDelegate, SquareSpaceClientDelegate>

@property NSCache *standardImageCache;
@property NSMutableArray *photosArray;
@property SquareSpaceClient *squareSpaceClient;
@property SketchBookClient *sketchBookClient;
@property InstagramClient *instagramClient;
@property BOOL profileViewIsShowing;
@property BOOL shareViewIsShowing;
@property SquarePhoto *selectedSquarePhoto;
@property UIRefreshControl *refreshControl;
@property IntroLoadingVIew *introLoadingView;
@property NSMutableArray *flippedIndexPaths;

@property BOOL drawingHasFinished;
@property BOOL imagesHaveLoadedFromPlace;


@end

@implementation PortfolioTableViewController

-(void)viewWillAppear:(BOOL)animated {
    
    if (self.squareSpaceClient.squarePhotos.count == 0) {
        self.drawingHasFinished = NO;
        self.imagesHaveLoadedFromPlace = NO;
        self.introLoadingView = [[IntroLoadingVIew alloc] initWithFrame:self.navigationController.view.frame];
        self.introLoadingView.delegate = self;
        [self.introLoadingView createIntroLoadingView];
        self.introLoadingView.backgroundColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
        [self.navigationController.view addSubview:self.introLoadingView];
        [self.introLoadingView.activityIndicator startAnimating];
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"HelveticaNeue-Thin" size:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.flippedIndexPaths = [NSMutableArray array];

    self.squareSpaceClient = [SquareSpaceClient sharedSquareSpaceClient];
    
    self.squareSpaceClient = [SquareSpaceClient sharedSquareSpaceClient];
    self.squareSpaceClient.delegate = self;
    
    if (self.squareSpaceClient.squarePhotos.count == 0) {
        [self.squareSpaceClient searchForSquarePhotosWithCompletion:^{
            [self.introLoadingView.activityIndicator stopAnimating];
            [self.introLoadingView.activityIndicator removeFromSuperview];
            
            
            for (int i = 0; i < self.squareSpaceClient.squarePhotos.count; i++) {
                [self.flippedIndexPaths addObject:[NSNumber numberWithBool:NO]];
            }
            
            UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(closeButtonPressed)];
            [self.introLoadingView addGestureRecognizer:tapRec];
            [self.tableView reloadData];
        }];
    }
    
    for (int i = 0; i < self.squareSpaceClient.squarePhotos.count; i++) {
        [self.flippedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    }
    
    self.sketchBookClient = [SketchBookClient sharedSquareSpaceClient];
    [self.sketchBookClient searchForSquarePhotosWithCompletion:^{
    }];
    
    self.instagramClient = [InstagramClient sharedInstagramClient];
    [self.instagramClient searchForInstagramPhotosWithCompletion:^{
    }];
    
    
    
    [self.tableView reloadData];
    
}

-(void)closeButtonPressed {
    [self.introLoadingView removeFromSuperview];
}

-(void)onEnterAppButtonPressed{
    
    self.flippedIndexPaths = [NSMutableArray array];
    
    for (int i = 0; i < self.squareSpaceClient.squarePhotos.count; i++) {
        [self.flippedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    }
    
    [self.tableView reloadData];
    
}


-(void)cellShareButtonTapped:(InstagramPhoto *)instagramPhoto{
    
    ShareView *shareview = [[ShareView alloc] initWithFrame:self.view.frame];
    [shareview createShareView];
    shareview.selectedInstagramPhoto = instagramPhoto;
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
    
    
    BOOL shouldBeFlipped = [[self.flippedIndexPaths objectAtIndex:indexPath.row] boolValue];
    
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
    
    
    BOOL shouldBeFlipped = [[self.flippedIndexPaths objectAtIndex:indexPath.row] boolValue];
    BOOL updatedValue = !shouldBeFlipped;
    
    self.flippedIndexPaths[indexPath.row] = [NSNumber numberWithBool:updatedValue];
    
    NSLog(cell.isFlipped ? @"Photo" : @" Text");
    
    [UIView beginAnimations:@"FlipCellAnimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
    
    if (cell.isFlipped) {
        cell.standardImageView.hidden = NO;
        cell.isFlipped = NO;
    } else {
        cell.standardImageView.hidden = YES;
        cell.isFlipped = YES;
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

-(void)imagesHaveLoaded {
    self.imagesHaveLoadedFromPlace = YES;
    if (self.drawingHasFinished == YES) {
        [UIView animateWithDuration:0.7 animations:^{
            self.introLoadingView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.introLoadingView removeFromSuperview];
        }];
    }
    
}

-(void)introDrawingHasCompleted{
    self.drawingHasFinished = YES;
    if (self.imagesHaveLoadedFromPlace == YES) {
        [UIView animateWithDuration:0.7 animations:^{
            self.introLoadingView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.introLoadingView removeFromSuperview];
        }];
    }
}


@end
