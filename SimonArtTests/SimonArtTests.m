//
//  SimonArtTests.m
//  SimonArtTests
//
//  Created by Adam Cooper on 12/8/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "InstagramClient.h"
#import "SquareSpaceClient.h"

@interface SimonArtTests : XCTestCase

@end

@implementation SimonArtTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}


- (void)testIfAdamIsEqualToAdam{
//    XCTestExpectation *expectation = [self expectationWithDescription:@"Waiting for Adam to equal Adam"];
    XCTAssertEqualObjects(@"Adam", @"Adam");
}

- (void)testIfInstagramClientRecievesPhotoData{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Waiting for Instagram photos to return."];
    InstagramClient *instagramclient = [InstagramClient sharedInstagramClient];
    [instagramclient searchForInstagramPhotosWithCompletion:^{
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testIfPortfolioPhotosAreDownloaded{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Waiting for Square photos to return."];
    [[SquareSpaceClient sharedSquareSpaceClient] searchForPortfolioPhotosWithCompletion:^{
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testIfSketchBookPhotosAreDownloaded{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Waiting for SketchBook photos to return."];
    [[SquareSpaceClient sharedSquareSpaceClient] searchForSketchbookPhotosWithCompletion:^{
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}




- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
