//
//  SketchBookTableViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "SketchBookTableViewController.h"
#import "SquareSpaceClient.h"

#import "SquarePhoto.h"
#import "CustomShareButton.h"
#import "RESideMenu.h"
#import "LeftMenuViewController.h"
#import "SquareSpaceTableViewCell.h"
#include "SquareShareView.h"
#import <MessageUI/MessageUI.h>

@interface SketchBookTableViewController () <SquareTableViewCellDelegate, RESideMenuDelegate, SquareShareViewDelegate , MFMailComposeViewControllerDelegate, SquareSpaceClientDelegate>

@property SquareSpaceClient *squareSpaceClient;
@property SquarePhoto *selectedSketchBookPhoto;

@property BOOL profileViewIsShowing;
@property BOOL shareViewIsShowing;

@property BOOL sketchBookImagesHaveDownloadedFromSquareSpaceClient;

@end

@implementation SketchBookTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Sketchbook";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"HelveticaNeue-Thin" size:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.squareSpaceClient = [SquareSpaceClient sharedSquareSpaceClient];
    [self.tableView reloadData];
    
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
    return self.squareSpaceClient.sketchBookPhotos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SquareSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!self.squareSpaceClient.sketchBookImageCache){
        self.squareSpaceClient.sketchBookImageCache = [NSCache new];
    }
    
    
    BOOL shouldBeFlipped = [[self.squareSpaceClient.flippedSketchBookIndexPaths objectAtIndex:indexPath.row] boolValue];
    
    if (shouldBeFlipped){
        cell.standardImageView.hidden = YES;
        NSLog(@"Cell Yes");
    } else {
        cell.standardImageView.hidden = NO;
    }
    
    SquarePhoto *result = [self.squareSpaceClient.sketchBookPhotos objectAtIndex:indexPath.row];
    cell.squarePhoto = result;
    cell.artworkNameLabel.text = result.title;
    cell.standardImageView.image = result.squareSpaceImage;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SquareSpaceTableViewCell *cell = (SquareSpaceTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.delegate = self;
    
    
    BOOL shouldBeFlipped = [[self.squareSpaceClient.flippedSketchBookIndexPaths objectAtIndex:indexPath.row] boolValue];
    BOOL updatedValue = !shouldBeFlipped;
    
    self.squareSpaceClient.flippedSketchBookIndexPaths[indexPath.row] = [NSNumber numberWithBool:updatedValue];
    
    
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

#pragma mark - SquareSpace Delegate Methods

-(void)sketchBookImagesHaveLoaded{
    
    self.sketchBookImagesHaveDownloadedFromSquareSpaceClient = YES;
    
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
