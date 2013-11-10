//
//  EMBDownloadManagerTest.m
//  EmoticonBucket
//
//  Created by Jay Lyerly on 11/10/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "EMBDownloadManager.h"

@interface EMBDownloadManager ()
- (NSURL *)validateUrl:(NSURL *)url;
@end


@interface EMBDownloadManagerTest : XCTestCase
@property (strong, nonatomic) EMBDownloadManager *dlManager;
@end

@implementation EMBDownloadManagerTest

- (void)setUp
{
    [super setUp];
    self.dlManager = [[EMBDownloadManager alloc] initWithManager:nil];
}

- (void)tearDown
{
    self.dlManager = nil;
    [super tearDown];
}

- (void)testValidateURL
{
    NSString *authString = @"fakeAuth";
    id mockUserDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
    [[[[mockUserDefaults stub] classMethod] andReturn:mockUserDefaults] standardUserDefaults];
    [[[mockUserDefaults stub] andReturn:authString] stringForKey:@"auth"];
    
    NSString* testString = @"http://google.com/foo";
    NSURL *testUrl = [NSURL URLWithString:testString];
    NSURL *authUrl = [self.dlManager validateUrl:testUrl];
    NSString *resultString = [authUrl absoluteString];
    
    NSString *expectedString = [NSString stringWithFormat:@"%@?auth_token=%@", testString, authString];
    
    XCTAssertTrue([expectedString isEqualToString:resultString], @"Validated url is not expected URL");
    
    testString = @"http://google.com/foo?bar=abc";
    testUrl = [NSURL URLWithString:testString];
    authUrl = [self.dlManager validateUrl:testUrl];
    resultString = [authUrl absoluteString];
    
    expectedString = [NSString stringWithFormat:@"%@&auth_token=%@", testString, authString];
    
    XCTAssertTrue([expectedString isEqualToString:resultString], @"Validated url is not expected URL");
}

- (void)testValidateURLRainy
{
    // No auth credentials should pass the URL through with no changes
    id mockUserDefaults = [OCMockObject mockForClass:[NSUserDefaults class]];
    [[[[mockUserDefaults stub] classMethod] andReturn:mockUserDefaults] standardUserDefaults];
    [[[mockUserDefaults stub] andReturn:nil] stringForKey:@"auth"];
    
    NSString* testString = @"http://google.com/foo";
    NSURL *testUrl = [NSURL URLWithString:testString];
    NSURL *authUrl = [self.dlManager validateUrl:testUrl];
    NSString *resultString = [authUrl absoluteString];
    
    NSString *expectedString = [testUrl absoluteString];
    
    XCTAssertTrue([expectedString isEqualToString:resultString], @"Validated url is not expected URL");
}


@end
