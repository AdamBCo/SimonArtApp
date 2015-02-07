//
//  InstagramClient.m
//  Pixifly
//
//  Created by Adam Cooper on 11/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//
#import "InstagramClient.h"
#import "AppDelegate.h"
#import "InstagramPhoto.h"

@interface InstagramClient()

@property int imageCounter;

@end

@implementation InstagramClient

//Create a shared Instagram Client
+(instancetype)sharedInstagramClient{
    static InstagramClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        _sharedClient = [[InstagramClient alloc] init];
    });

    return _sharedClient;
}

-(instancetype)init{
    if (self = [super init]) {
        self.instagramPhotos = [NSMutableArray array];
        self.flippedInstagramIndexPaths = [NSMutableArray array];
    }
    return self;
};


-(void)searchForInstagramPhotosWithCompletion:(void (^)(void))completion{
    
    self.imageCounter = 0;
    
    [self requestImageInformationWithCompletion:^{
        
        for (InstagramPhoto *instagramPhoto in self.instagramPhotos) {
            
            [self requestImageWithURL:instagramPhoto.standardResolutionPhotoURL withCompletion:^(UIImage *image) {
                instagramPhoto.standardResolutionImage = image;
                
                self.imageCounter++;
                
                NSLog(@"\nCounter: %d\nInstagramPhotoCount: %lu",self.imageCounter,(unsigned long)self.instagramPhotos.count);
                
                if (self.imageCounter == self.instagramPhotos.count) {
                    [self.delegate imagesHaveLoaded];
                    completion();
                }
            }];
            
        [self.flippedInstagramIndexPaths addObject:[NSNumber numberWithBool:NO]];
        }
    }];


}




-(void)requestImageInformationWithCompletion:(void (^)(void))completion{
    
    if (!self.isLoading) {
        self.isLoading = YES;
        
        NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/193252904/media/recent/?client_id=6946df7e278148f28fb71800bbdff97b"];
        
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSLog(@"The Instagram Request URL: %@",request.URL);
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *jSONresult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSArray *results = [jSONresult valueForKey:@"data"];
            NSMutableArray *instagramArray = [NSMutableArray array];
            
            for (NSDictionary *result in results) {
                
                NSLog(@"The help: %@",result [@"link"]);
                InstagramPhoto *new = [[InstagramPhoto alloc] initWithCreateInstagramPhoto:result];
                [instagramArray addObject:new];
            }
            
            if (error){
                if (!error){
                    NSDictionary *userInfo = @{@"error":jSONresult[@"status"]};
                    NSError *newError = [NSError errorWithDomain:@"API Error" code:666 userInfo:userInfo];
                    NSLog(@"Error: %@",newError);
                    return;
                }
                NSLog(@"Error: %@",error);
                return;
            }else{
                [self.instagramPhotos addObjectsFromArray:instagramArray];
                self.isLoading = NO;
                completion();
            }
        }];
        
        [task resume];
    }
    
}



-(void)requestImageWithURL: (NSURL *)url withCompletion:(void (^)(UIImage *image))completion{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"ERROR: %@", error);
        } else {
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
             if (httpResponse.statusCode == 200) {
                 UIImage *image = [UIImage imageWithData:data];
                 completion(image);
             } else {
                 NSLog(@"Couldn't load image at URL: %@", url);
                 NSLog(@"HTTP %ld", (long)httpResponse.statusCode);
             }
        }
        
     }];
    [task resume];
}


@end
