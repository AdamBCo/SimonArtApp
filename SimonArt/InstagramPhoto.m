//
//  InstagramPhoto.m
//  Pixifly
//
//  Created by Adam Cooper on 10/16/14.
//  Copyright (c) 2014 Pixifly. All rights reserved.
//

#import "InstagramPhoto.h"

@implementation InstagramPhoto
{
    NSDictionary *json;
}

-(instancetype)initWithCreateInstagramPhoto:(NSDictionary *)instagramJSONData{
    self = [super init];
    if (self) {
        json = instagramJSONData;
    }
    return self;
}

-(NSString *) fullName{
    NSString *string = [NSString new];
    if(json [@"user"][@"full_name"] != [NSNull null]){
    return json [@"user"][@"full_name"];
    }
    return string;
}

-(NSString *) userName{
    
    NSString *string = [NSString new];
    if(json [@"user"][@"username"] != [NSNull null]){
        return json [@"user"][@"username"];
    }
    return string;
}

-(NSNumber *)idNumber{
    NSNumber *number = [NSNumber new];
    if(json [@"user"][@"id"] != [NSNull null]){
     return json [@"user"][@"id"];
}
return number;

}
-(NSString *)photoIDNumber{
    NSString *number = [NSString new];
    if(json [@"id"] != [NSNull null]){
    return json [@"id"];
    }
    return number;
}

-(NSString *)photoText{
    NSString *string = [NSString new];
    if(json [@"caption"] != [NSNull null]){
    return json [@"caption"][@"text"];
    }
     return string;
}
-(NSString *)timeCreated{
    NSString *string = [NSString new];
    if(json [@"created_time"] != [NSNull null]){
        NSString *creationDateString = json [@"created_time"];
        NSTimeInterval creationTime = [creationDateString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:creationTime];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
        NSString *creationDate = [dateFormat stringFromDate:date];
    return creationDate;
    }
    return string;
}

-(NSString *)timeCreatedUNIX{
    NSString *string = [NSString new];
    if(json [@"created_time"] != [NSNull null]){
        NSString *creationDateString = json [@"created_time"];
        return creationDateString;
    }
    return string;
}

-(NSURL *)standardResolutionPhotoURL{

    NSURL *imageUrl = [NSURL new];

    if(json [@"images"][@"standard_resolution"][@"url"] != [NSNull null]){
        NSString *urlString = json [@"images"][@"standard_resolution"][@"url"];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    
    return imageUrl;
}

-(NSURL *)profileImageURL{

    NSURL *imageUrl = [NSURL new];
    if(json [@"user"][@"profile_picture"] != [NSNull null]){
         NSString *urlString = json [@"user"][@"profile_picture"];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    return imageUrl;
}

-(NSURL *)thumbnailImageURL{

    NSURL *imageUrl = [NSURL new];
    if(json [@"images"][@"thumbnail"][@"url"] != [NSNull null]){
        NSString *urlString = json [@"images"][@"thumbnail"][@"url"];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
    return imageUrl;
}


-(NSNumber *)numberOfLikes{
    NSNumber *number = [NSNumber new];
    if(json [@"likes"][@"count"] != [NSNull null]){
    return json [@"likes"][@"count"];
    }
    return number;
    
}
-(NSNumber *)numberOfComments{
    NSNumber *number = [NSNumber new];
    if(json [@"comments"][@"count"] != [NSNull null]){
        return json [@"comments"][@"count"];
    }
    return number;
}

-(CLLocationCoordinate2D)photoLocation{
    CLLocationCoordinate2D location;
    
    if(json [@"location"] != [NSNull null]){
    NSString *latitudeString = json [@"location"][@"latitude"];
    NSString *longitudeString = json [@"location"][@"longitude"];
        CLLocationDegrees latitude = latitudeString.floatValue;
        CLLocationDegrees longitude = longitudeString.floatValue;
         location = CLLocationCoordinate2DMake(latitude, longitude);
        return location;
    }
    return location;
}

-(NSURL *)urlForInstagramPhoto{
    NSURL *url = [NSURL new];
    NSLog(@"The link: %@", json [@"link"]);
    if(json [@"link"] != [NSNull null]){
                NSLog(@"%@",url);
    return json [@"link"];
    }
    return url;
    
}





@end
