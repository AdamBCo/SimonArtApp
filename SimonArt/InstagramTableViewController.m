//
//  TableTableViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/8/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "InstagramTableViewController.h"
#import "RESideMenu.h"
#import "InstagramTableViewCell.h"
#import "InstagramClient.h"
#import "SquareSpaceClient.h"
#import "InstagramPhoto.h"
#import "IntroLoadingVIew.h"
#include "ShareView.h"
#import <MessageUI/MessageUI.h>

@interface InstagramTableViewController () <InstagramTableViewCellDelegate, RESideMenuDelegate, ShareViewDelegate, MFMailComposeViewControllerDelegate, IntroViewDelegate, InstagramClientDelegate>

@property InstagramClient *instagramClient;
@property InstagramPhoto *selectedInstagramPhoto;
@property IntroLoadingVIew *introLoadingView;

@property BOOL shareViewIsShowing;
@property BOOL drawingHasFinished;
@property BOOL imagesHaveLoadedFromPlace;


@property SquareSpaceClient *squareSpaceClient;

@end

@implementation InstagramTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.instagramClient.instagramPhotos.count == 0) {
        
        self.drawingHasFinished = NO;
        self.imagesHaveLoadedFromPlace = NO;

        self.introLoadingView = [[IntroLoadingVIew alloc] initWithFrame:self.navigationController.view.frame];
        self.introLoadingView.delegate = self;
        [self.introLoadingView createIntroLoadingView];
        self.introLoadingView.backgroundColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
        [self.navigationController.view addSubview:self.introLoadingView];
        [self.introLoadingView.activityIndicator startAnimating];
        
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.instagramClient = [InstagramClient sharedInstagramClient];
    self.instagramClient.delegate = self;
    
    if (self.instagramClient.instagramPhotos.count == 0) {
        
        [self.instagramClient searchForInstagramPhotosWithCompletion:^{
            
            UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(closeButtonPressed)];
            [self.introLoadingView addGestureRecognizer:tapRec];
        }];
    } else {
        
        [self.tableView reloadData];

    }
}

#pragma mark - TableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.instagramClient.instagramPhotos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    InstagramTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!self.instagramClient.instagramImageCache){
        self.instagramClient.instagramImageCache = [NSCache new];
    }
    
    NSLog(@"IndexPath: %ld",(long)indexPath.row);
    BOOL shouldBeFlipped = [[self.instagramClient.flippedInstagramIndexPaths objectAtIndex:indexPath.row] boolValue];
    
    NSLog(shouldBeFlipped ? @"YES" : @" NO");
    
    if (shouldBeFlipped){
        cell.standardImageView.hidden = YES;
    } else {
        cell.standardImageView.hidden = NO;
    }
    
    InstagramPhoto *result = [self.instagramClient.instagramPhotos objectAtIndex:indexPath.row];
    cell.instagramPhoto = result;
    cell.artworkNameLabel.text = result.photoText;
    cell.standardImageView.image = result.standardResolutionImage;
    
    NSLog(@"Image: %@",result.standardResolutionImage);
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstagramTableViewCell *cell = (InstagramTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.delegate = self;
    
    
    BOOL shouldBeFlipped = [[self.instagramClient.flippedInstagramIndexPaths objectAtIndex:indexPath.row] boolValue];
    BOOL updatedValue = !shouldBeFlipped;
    
    self.instagramClient.flippedInstagramIndexPaths[indexPath.row] = [NSNumber numberWithBool:updatedValue];

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


#pragma mark - InstagramClient Delegate Methods

-(void)imagesHaveLoaded{
    self.imagesHaveLoadedFromPlace = YES;
    [self.introLoadingView.activityIndicator stopAnimating];
    [self.introLoadingView.activityIndicator removeFromSuperview];
    
    if (self.introLoadingView) {
        [UIView animateWithDuration:0.7 animations:^{
            self.introLoadingView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.introLoadingView removeFromSuperview];
        }];
    }
    
    [[SquareSpaceClient sharedSquareSpaceClient] searchForPortfolioPhotosWithCompletion:^{
        NSLog(@"Portfolio photos have loaded successfully!");
    }];
    
    [[SquareSpaceClient sharedSquareSpaceClient] searchForSketchbookPhotosWithCompletion:^{
        NSLog(@"SketchBook photos have loaded successfully!");
    }];
    
    [self.tableView reloadData];
    
}


#pragma mark - InstagramCell Delegate Methods

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

#pragma mark - IntroView Delegate Methods

-(void)closeButtonPressed {
    [self.introLoadingView removeFromSuperview];
}

-(void)introDrawingHasCompleted{
    self.drawingHasFinished = YES;
    if (self.introLoadingView && self.imagesHaveLoadedFromPlace == YES) {
        [UIView animateWithDuration:0.7 animations:^{
            self.introLoadingView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.introLoadingView removeFromSuperview];
        }];
    }
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


@end
