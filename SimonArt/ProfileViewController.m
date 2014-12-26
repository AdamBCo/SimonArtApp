//
//  ProfileViewController.m
//  SimonArt
//
//  Created by Adam Cooper on 12/14/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ProfileViewController.h"
#import "ResumeDetailViewController.h"
#import <MessageUI/MessageUI.h>
#import "SquareSpaceClient.h"

@interface ProfileViewController () <MFMailComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property SquareSpaceClient *squareSpaceClient;
@property NSString *bio;



@property  UIImageView *profileImageView;
@property UILabel *bioLabel;
@property UILabel *educationLabel;
@property UILabel *exhibitsLabel;
@property UILabel *publicationsLabel;
@property UILabel *publicArtLabel;

@property NSArray *exhibits;
@property NSArray *exhibitsDetail;
@property NSArray *publications;
@property NSArray *publicationsDetail;
@property NSArray *publicArt;
@property NSArray *publicArtDetail;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

typedef NS_ENUM(NSUInteger, TableViewSection){
    TableViewBioSection,
    TableViewEducationSection,
    TableViewExhibitSection,
    TableViewPublicationSection,
    TableViewPublicArtSection,
    TableViewSectionCount
};


@implementation ProfileViewController
- (IBAction)onRightBarButtonItemPressed:(id)sender {
    [self performSegueWithIdentifier:@"ResumePDFSegue" sender:self];
}



-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.692 green:0.147 blue:0.129 alpha:1.000];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"HelveticaNeue-Thin" size:21],NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    
    self.title = @"Simon Cooper";
    
    self.exhibits = @[@"2014 The Meantime: Solo Exhibition",@"2014 Society of Illustrators Student Scholarship",@"2014 Love Is A Monoprint",@"2013 Student International Small Print Show",@"2013 Porteno: Solo Exhibition",@"2013 SHAKTAYA: Solo Exhibition"];
    
    self.exhibitsDetail = @[@"Savannah, GA",@"New York, NY",@"Savannah, GA",@"El Minia, Egypt",@"Savannah, GA",@"Savannah, GA"];
    
    
    self.publications = @[@"2014 Society of Illustrators Student Scholarship", @"2013 Savannah College of Art & Design Catalogue", @"Chalk it up to greatness: Sidewalk Arts Festival 2013", @"2013 Le Snoot Gallery Featured Artist"];
    
    self.publicationsDetail = @[@"New York Society of Illustrators", @"Savannah College of Art and Design", @"Port City Review", @"Port City Review"];
    
    self.publicArt = @[@"2014 Southbound Brewing Company", @"2014 Minero Restaurant"];
    
    self.publicArtDetail = @[@"Savannah, GA", @"Charleston, SC"];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.squareSpaceClient = [SquareSpaceClient sharedSquareSpaceClient];
    
    self.bio = [NSString stringWithFormat:@"     %@", self.squareSpaceClient.siteDescription];;
    
    
    
    CGFloat frameHeight = self.view.frame.size.height;
    CGFloat frameWidth = self.view.frame.size.width;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight*.325)];
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth*.25, frameHeight*.02, frameWidth*.5, frameWidth*.5)];
    self.profileImageView.image = [UIImage imageNamed:@"simon_photo"];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageView.backgroundColor = [UIColor greenColor];
    [headerView addSubview:self.profileImageView];
    self.tableview.tableHeaderView = headerView;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case TableViewBioSection: {
            return @"BIO";
        }break;
        case TableViewEducationSection: {
            return @"Education";
        }break;
        case TableViewExhibitSection: {
            return @"Exhibit";
        }break;
        case TableViewPublicationSection: {
            return @"Publication";
        }break;
        case TableViewPublicArtSection: {
            return @"Public Art";
        }break;
    }
    return @"";
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case TableViewBioSection:
            return 20;
            break;
        case TableViewEducationSection:
            return 20;
            break;
        case TableViewExhibitSection:
            return 20;
            break;
        case TableViewPublicationSection:
            return 20;
            break;
        case TableViewPublicArtSection:
            return 20;
            break;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return TableViewSectionCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case TableViewBioSection:
            return 1;
            break;
        case TableViewEducationSection:
            return 1;
            break;
        case TableViewExhibitSection:
            return self.exhibits.count;
            break;
        case TableViewPublicationSection:
            return self.publications.count;
            break;
        case TableViewPublicArtSection:
            return self.publicArt.count;
            break;
    }
    
    return 0;
}

-(CGFloat)heightForText:(NSString *)text
{
    NSInteger MAX_HEIGHT = 2000;
    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, MAX_HEIGHT)];
    textView.text = text;
    textView.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0];
    [textView sizeToFit];
    return textView.frame.size.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case TableViewBioSection:
            // or however you are getting the text
            return [self heightForText:self.bio];
            break;
        case TableViewEducationSection:
            return 80;
            break;
        case TableViewExhibitSection:
            return 50;
            break;
        case TableViewPublicationSection:
            return 50;
            break;
        case TableViewPublicArtSection:
            return 50;
            break;
        }
    
    return 0;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    ResumeDetailViewController *resumeDetailViewController = segue.destinationViewController;
//    resumeDetailViewController.selectedUrlString = @"http://www.simoncooperart.com";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case TableViewBioSection: {
        }break;
        case TableViewEducationSection: {
//            UITextView *educationTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.frame.size.width, 80)];
//            [educationTextView setTextAlignment:NSTextAlignmentCenter];
//            [educationTextView setEditable:NO];
//            [educationTextView setScrollEnabled:NO];
//            [educationTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
//            [educationTextView setText:@"Savannah College of Art and Design\n(2010-2014)\nB.F.A. Illustration, Printmaking"];
//            [cell.contentView addSubview:educationTextView];
        }break;
        case TableViewExhibitSection: {
        }break;
        case TableViewPublicationSection: {
//            [self performSegueWithIdentifier:@"ResumeDetailSegue" sender:self];
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
//            cell.textLabel.text = [self.publications objectAtIndex:indexPath.row];
//            [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
//            [cell.textLabel sizeToFit];
//            cell.detailTextLabel.text = [self.publicationsDetail objectAtIndex:indexPath.row];
//            [cell.detailTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:12.0]];
        }break;
        case TableViewPublicArtSection: {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
//            cell.textLabel.text = [self.publicArt objectAtIndex:indexPath.row];
//            [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
//            cell.detailTextLabel.text = [self.publicArtDetail objectAtIndex:indexPath.row];
//            [cell.detailTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:12.0]];
        }break;
            
        default:
            break;
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    switch (indexPath.section) {
        case TableViewBioSection: {
            UITextView *bioTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.frame.size.width, 180)];
            [bioTextView setText:self.bio];
            [bioTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
            [bioTextView sizeToFit];
            bioTextView.editable = NO;
            bioTextView.scrollEnabled = NO;
            cell.userInteractionEnabled = NO;
            [cell.contentView addSubview:bioTextView];
        }break;
        case TableViewEducationSection: {
            UITextView *educationTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.frame.size.width, 80)];
            [educationTextView setTextAlignment:NSTextAlignmentCenter];
            [educationTextView setEditable:NO];
            [educationTextView setScrollEnabled:NO];
            [educationTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
            [educationTextView setText:@"Savannah College of Art and Design\n(2010-2014)\nB.F.A. Illustration, Printmaking"];
            cell.userInteractionEnabled = NO;
            [cell.contentView addSubview:educationTextView];
        }break;
        case TableViewExhibitSection: {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
            cell.textLabel.text = [self.exhibits objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [self.exhibitsDetail objectAtIndex:indexPath.row];
            [cell.detailTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:12.0]];
            cell.userInteractionEnabled = NO;
        }break;
        case TableViewPublicationSection: {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            cell.textLabel.text = [self.publications objectAtIndex:indexPath.row];
            [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
            [cell.textLabel sizeToFit];
            cell.detailTextLabel.text = [self.publicationsDetail objectAtIndex:indexPath.row];
            [cell.detailTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:12.0]];
            cell.userInteractionEnabled = NO;
        }break;
        case TableViewPublicArtSection: {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            cell.textLabel.text = [self.publicArt objectAtIndex:indexPath.row];
            [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
            cell.detailTextLabel.text = [self.publicArtDetail objectAtIndex:indexPath.row];
            [cell.detailTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:12.0]];
            cell.userInteractionEnabled = NO;
        }break;
            
        default:
            break;
    }
    return cell;
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
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
