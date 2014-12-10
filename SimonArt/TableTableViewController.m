//
//  TableTableViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/8/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "TableTableViewController.h"
#import "InstagramTableViewCell.h"
#import "InstagramClient.h"
#import "InstagramPhoto.h"
#import "LiveFrost.h"

@interface TableTableViewController ()

@property NSCache *standardImageCache;
@property NSMutableArray *photosArray;
@property InstagramClient *instagramClient;
@property BOOL profileViewIsShowing;
@property UIView *profileView;
@property LFGlassView* blurView;


@property NSMutableArray *flippedIndexPaths;

@end

@implementation TableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.instagramClient = [InstagramClient sharedInstagramClient];
    self.flippedIndexPaths = [NSMutableArray array];
    
    self.profileView = [[UIView alloc] initWithFrame:self.tableView.frame];
    [self.tableView addSubview:self.profileView];
    
    
    self.profileView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];
    [self createProfileView];
    self.profileView.hidden = YES;
    self.profileViewIsShowing = NO;

    for (int i = 0; i < self.instagramClient.instagramPhotos.count; i++) {
        [self.flippedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    }
    [self.tableView reloadData];
}


-(void)createProfileView{
    CGFloat frameHeight = self.view.frame.size.height;
    CGFloat frameWidth = self.view.frame.size.width;
    
    self.blurView = [[LFGlassView alloc] initWithFrame:self.view.bounds];
    self.blurView.alpha = 0.5;
    [self.profileView addSubview:self.blurView];
    

    
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth*.25, frameHeight*.15, frameWidth*.5, frameWidth*.5)];
    profileImageView.image = [UIImage imageNamed:@"simon_photo"];
    profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2;
    profileImageView.clipsToBounds = YES;
    profileImageView.layer.borderWidth = 3.0f;
    profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    profileImageView.backgroundColor = [UIColor greenColor];
    [self.profileView addSubview:profileImageView];
    
    UITextView *profileTextView = [[UITextView alloc] initWithFrame:CGRectMake(frameWidth*.1, frameHeight*.45, frameWidth*.8, frameHeight*.4)];
    [profileTextView setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [profileTextView setTextAlignment:NSTextAlignmentCenter];
    [profileTextView setTextColor:[UIColor whiteColor]];
    [profileTextView setEditable:NO];
    [profileTextView setScrollEnabled:NO];
    [profileTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    [profileTextView setText:@"Simon Cooper is an American artist and designer currently based in Savannah, Georgia. His interest in the arts began in Buenos Aires, Argentina where he lived and was greatly influenced by Latin-American art and culture. Cooper received his B.F.A. in Illustration, Printmaking from the Savannah College of Art and Design in 2014. Simon continues to explore painting, printmaking and gallery exhibitions."];
    [self.profileView addSubview:profileTextView];
    
    
    UIButton *contactButton = [[UIButton alloc] initWithFrame:CGRectMake(frameWidth*.1, frameHeight*.875, frameWidth*.8, frameHeight*.075)];
    [contactButton setTitle:@"Contact" forState:UIControlStateNormal];
    [contactButton setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [contactButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
    contactButton.clipsToBounds = YES;
    contactButton.layer.cornerRadius = 10.0f;
    contactButton.layer.borderColor=[UIColor whiteColor].CGColor;
    contactButton.layer.borderWidth=1.0f;
    
    [contactButton setTintColor:[UIColor blackColor]];
    [contactButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.profileView addSubview:contactButton];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.profileView.center = CGPointMake(self.view.center.x, self.view.center.y + scrollView.contentOffset.y);
    [scrollView bringSubviewToFront:self.profileView];
}



- (IBAction)onProfileButtonPressed:(id)sender {
    
        if (!self.profileViewIsShowing) {
            [UIView animateWithDuration:0.25 animations:^{
                self.profileView.hidden = NO;
            }];
            self.profileViewIsShowing = YES;
            self.tableView.scrollEnabled = NO;
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                self.profileView.hidden = YES;
            }];
            self.profileViewIsShowing = NO;
            self.tableView.scrollEnabled = YES;
        }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.instagramClient.instagramPhotos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    InstagramTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!self.standardImageCache){
        self.standardImageCache = [NSCache new];
        NSLog(@"New");
    }
    
    BOOL shouldBeFlipped = [[self.flippedIndexPaths objectAtIndex:indexPath.row] boolValue];
    
    if (shouldBeFlipped){
        cell.standardImageView.hidden = YES;
    } else {
        cell.standardImageView.hidden = NO;
    }
    
    InstagramPhoto *result = [self.instagramClient.instagramPhotos objectAtIndex:indexPath.row];
    cell.artworkNameLabel.text = result.photoText;
    cell.standardImageView.image = result.standardResolutionImage;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstagramTableViewCell *cell = (InstagramTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [UIView beginAnimations:@"FlipCellAnimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
    
    BOOL currentValue = [[self.flippedIndexPaths objectAtIndex:indexPath.row] boolValue];
    BOOL updatedValue = !currentValue;
    
    self.flippedIndexPaths[indexPath.row] = [NSNumber numberWithBool:updatedValue];
    
    if (!cell.isFlipped) {
        cell.standardImageView.hidden = YES;
        cell.isFlipped = YES;
    } else {
        cell.standardImageView.hidden = NO;
        cell.isFlipped = NO;
    }
    
    
    [UIView commitAnimations];
}



@end
