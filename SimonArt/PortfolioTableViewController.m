//
//  PortfolioTableViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "PortfolioTableViewController.h"
#import "TableViewController.h"
#import "InstagramTableViewCell.h"
#import "SquareSpaceClient.h"
#import "SquarePhoto.h"
#import "LiveFrost.h"
#import "CustomShareButton.h"
#import "RESideMenu.h"
#import "LeftMenuViewController.h"
#import "IntroViewController.h"
#import "SquareSpaceTableViewCell.h"

#include "ShareView.h"
#import <MessageUI/MessageUI.h>

@interface PortfolioTableViewController () <SquareTableViewCellDelegate, RESideMenuDelegate, IntroViewDelegate, ShareViewDelegate, MFMailComposeViewControllerDelegate>

@property NSCache *standardImageCache;
@property NSMutableArray *photosArray;
@property SquareSpaceClient *squareSpaceClient;
@property BOOL profileViewIsShowing;
@property BOOL shareViewIsShowing;
@property SquarePhoto *selectedSquarePhoto;
@property UIRefreshControl *refreshControl;

@property NSMutableArray *flippedIndexPaths;

@end

@implementation PortfolioTableViewController

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"HelveticaNeue-Thin" size:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.flippedIndexPaths = [NSMutableArray array];
    
    self.squareSpaceClient = [SquareSpaceClient sharedSquareSpaceClient];
    if (self.squareSpaceClient.squarePhotos.count == 0) {
        [self performSegueWithIdentifier:@"IntroSegue" sender:self];
    }
    
    for (int i = 0; i < self.squareSpaceClient.squarePhotos.count; i++) {
        [self.flippedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    }
    
    [self.tableView reloadData];
    
}

-(void)onEnterAppButtonPressed{
    
    self.flippedIndexPaths = [NSMutableArray array];
    
    for (int i = 0; i < self.squareSpaceClient.squarePhotos.count; i++) {
        [self.flippedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    }
    
    [self.tableView reloadData];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    IntroViewController *introViewController = segue.destinationViewController;
    introViewController.delegate = self;
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
        NSLog(@"New");
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


@end
