//
//  PortfolioTableViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "PortfolioTableViewController.h"
#import "SquareSpaceClient.h"
#import "SquarePhoto.h"
#import "RESideMenu.h"
#import "SquareSpaceTableViewCell.h"
#import "SquareShareView.h"
#import <MessageUI/MessageUI.h>

@interface PortfolioTableViewController () <SquareTableViewCellDelegate, RESideMenuDelegate, SquareShareViewDelegate, MFMailComposeViewControllerDelegate, SquareSpaceClientDelegate>

@property SquareSpaceClient *squareSpaceClient;
@property SquarePhoto *selectedPortfolioPhoto;

@property BOOL shareViewIsShowing;

@property BOOL portfolioImagesHaveDownloadedFromSquareSpaceClient;


@end

@implementation PortfolioTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Portfolio";

    self.squareSpaceClient = [SquareSpaceClient sharedSquareSpaceClient];
    self.squareSpaceClient.delegate = self;
    
    if (self.squareSpaceClient.portfolioPhotos.count == 0) {
        [self.squareSpaceClient searchForPortfolioPhotosWithCompletion:^{
            [self.tableView reloadData];
        }];
    } else {
        [self.tableView reloadData];
    }
    
}

-(void)portfolioImagesHaveLoaded{
    self.portfolioImagesHaveDownloadedFromSquareSpaceClient = YES;
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
    return self.squareSpaceClient.portfolioPhotos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SquareSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!self.squareSpaceClient.portfolioImageCache){
        self.squareSpaceClient.portfolioImageCache = [NSCache new];
    }
    
    
    BOOL shouldBeFlipped = [[self.squareSpaceClient.flippedPortfolioIndexPaths objectAtIndex:indexPath.row] boolValue];
    
    if (shouldBeFlipped){
        cell.standardImageView.hidden = YES;
        NSLog(@"Cell Yes");
    } else {
        cell.standardImageView.hidden = NO;
    }
    
    SquarePhoto *result = [self.squareSpaceClient.portfolioPhotos objectAtIndex:indexPath.row];
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

@end
