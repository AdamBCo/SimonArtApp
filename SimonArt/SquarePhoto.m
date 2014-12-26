//
//  SquarePhoto.m
//  SimonArt
//
//  Created by Adam Cooper on 12/25/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "SquarePhoto.h"

@implementation SquarePhoto
{
    NSDictionary *json;
}

-(instancetype)initWithCreateSquarePhoto:(NSDictionary *)squareJSONData{
    self = [super init];
    if (self) {
        json = squareJSONData;
    }
    return self;
}

-(NSString *) title{
    NSString *string = [NSString new];
    if(json [@"title"] != [NSNull null]){
        return json [@"title"];
    }
    return string;
}


-(NSString *)urlStringForSquarePhoto{
    NSString *urlString = [NSString new];
    if(json [@"assetUrl"] != [NSNull null]){
        return json [@"assetUrl"];
    }
    return urlString;
    
}

@end



