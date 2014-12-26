//
//  SquareSpaceClient.m
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "SquareSpaceClient.h"
#import "SquarePhoto.h"

@interface SquareSpaceClient()

@end

@implementation SquareSpaceClient

//Create a shared Instagram Client
+(instancetype)sharedSquareSpaceClient{
    static SquareSpaceClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        _sharedClient = [[SquareSpaceClient alloc] init];
    });
    
    return _sharedClient;
}

-(instancetype)init{
    if (self = [super init]) {
        self.squarePhotos = [NSMutableArray array];
    }
    return self;
};


-(void)searchForSquarePhotosWithCompletion:(void (^)(void))completion{
    
    [self requestImageInformationWithCompletion:^{
        for (SquarePhoto *squarePhoto in self.squarePhotos) {
            
            [self requestImageWithURL:squarePhoto.urlStringForSquarePhoto withCompletion:^(UIImage *image) {
                squarePhoto.squareSpaceImage = image;
            }];
        }
        completion();
    }];
    
    
}




-(void)requestImageInformationWithCompletion:(void (^)(void))completion{
    
    if (!self.isLoading) {
        self.isLoading = YES;
        
        NSString *urlString = [NSString stringWithFormat:@"http://www.simoncooperart.com/?format=json-pretty"];
        
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSLog(@"The Square Space Request URL: %@",request.URL);
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *jSONresult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSArray *results = [jSONresult valueForKey:@"items"];
            NSMutableArray *squareArray = [NSMutableArray array];
            
            NSLog(@"Results: %@", results);
            for (NSDictionary *result in results) {
                
                SquarePhoto *new = [[SquarePhoto alloc] initWithCreateSquarePhoto:result];
                [squareArray addObject:new];
                NSLog(@"NEw: %@",new.urlStringForSquarePhoto);
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
                [self.squarePhotos addObjectsFromArray:squareArray];
                self.isLoading = NO;
                completion();
            }
        }];
        
        [task resume];
    }
    
}



-(void)requestImageWithURL: (NSString *)url withCompletion:(void (^)(UIImage *image))completion{
    
    NSLog(@"Image Request: %@", url);
    
    NSURL *photoURL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:photoURL];
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

