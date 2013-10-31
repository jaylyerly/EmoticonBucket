//
//  EMBDownloadManager.m
//  EmoticonBucket
//
//  Created by Jay Lyerly on 10/29/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import "EMBDownloadManager.h"
#import "EMBAppManager.h"
#import "Emoticon.h"

NSString * const kEMBDownloadFinished = @"EMB-DownloadFinished";

@interface EMBDownloadManager ()
@property (nonatomic, strong) EMBAppManager *appManager;
@end


@implementation EMBDownloadManager

- (instancetype) initWithManager:(EMBAppManager *)appManager {
    self = [super init];
    if (self){
        _appManager = appManager;
    }
    return self;
}

- (void) update {
    NSURLRequest *req = [NSURLRequest requestWithURL:self.appManager.dataUrl];
    
    [NSURLConnection
     sendAsynchronousRequest:req
     queue:[[NSOperationQueue alloc] init]
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error)
     {
         
         if ([data length] >0 && error == nil)
         {
             NSError *jsonParsingError = nil;
             NSDictionary* parsedDict = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:0
                                                                    error:&jsonParsingError];
             NSArray *items = parsedDict[@"items"];
             NSLog(@"parsed data = %@", items);
             for (NSDictionary *aDict in items){
                 [Emoticon emoticonWithDictionary:aDict];
             }
             [[NSNotificationCenter defaultCenter] postNotificationName:kEMBDownloadFinished object:self];
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             NSLog(@"Error = %@", error);
         }
         
     }];
    
}

@end
