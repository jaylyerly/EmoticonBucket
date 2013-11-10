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
#import "EMBAppDelegate.h"

NSString * const kEMBDownloadFinished = @"EMB-DownloadFinished";
NSString * const kEMBImageUpdateFinished = @"EMB-ImageUpdateFinished";

@interface EMBDownloadManager ()
@property (nonatomic, strong) EMBAppManager *appManager;
@property (nonatomic, strong) NSOperationQueue *opQueue;
@end


@implementation EMBDownloadManager

- (instancetype) initWithManager:(EMBAppManager *)appManager {
    self = [super init];
    if (self){
        _appManager = appManager;
        _opQueue = [[NSOperationQueue alloc] init];
        _opQueue.maxConcurrentOperationCount = 5;
    }
    return self;
}

- (NSURL *)validateUrl:(NSURL *)url {
    NSString *auth = [[NSUserDefaults standardUserDefaults] stringForKey:@"auth"];
    if (auth){
        auth = [NSString stringWithFormat:@"auth_token=%@", auth];
        
        NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@%@", [url absoluteString],
                               [url query] ? @"&" : @"?", auth];
        return [NSURL URLWithString:urlString];
    }else{
        return url;
    }
}


- (void) update:(NSURL *)baseUrl {
    __block NSError *mocErr = nil;
    EMBAppDelegate *delegate = (EMBAppDelegate *)[NSApplication sharedApplication].delegate;
    NSManagedObjectContext *moc = delegate.managedObjectContext;
    
    NSURL *reqUrl = [self validateUrl:baseUrl];
    NSURLRequest *req = [NSURLRequest requestWithURL:reqUrl];
    NSImage *check = [NSImage imageNamed:@"check"];
    NSData *checkData = [self PNGRepresentationOfImage:check];
    
    [NSURLConnection
     sendAsynchronousRequest:req
     queue:self.opQueue
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
             NSString *nextUrlString = parsedDict[@"links"][@"next"];
             // get more emticons!
             if (nextUrlString) {
                 NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
                     [self update:[NSURL URLWithString:nextUrlString]];
                 }];
                 [self.opQueue addOperation:op];
             }
             
             NSLog(@"all items:%@", parsedDict);
             NSArray *items = parsedDict[@"items"];
             NSLog(@"parsed data = %@", items);
             for (NSDictionary *aDict in items){
                 Emoticon *eIcon = [Emoticon emoticonWithDictionary:aDict];
                 eIcon.imgData = checkData;
                 //[self downloadImageForEmoticon:eIcon];
             }
             [moc save:&mocErr];
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

- (void) downloadImageForEmoticon:(Emoticon *)eIcon {
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:eIcon.url]];
    
    [NSURLConnection
     sendAsynchronousRequest:req
     queue:self.opQueue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error)
     {
         
         if ([data length] >0 && error == nil)
         {
             eIcon.imgData = data;
             NSImage *img = [[NSImage alloc] initWithData:data];
             [[NSNotificationCenter defaultCenter] postNotificationName:kEMBImageUpdateFinished object:self userInfo:@{@"emoticon":eIcon}];
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

- (NSData *) PNGRepresentationOfImage:(NSImage *) image {
    // Create a bitmap representation from the current image
    
    [image lockFocus];
    NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0, 0, image.size.width, image.size.height)];
    [image unlockFocus];
    
    return [bitmapRep representationUsingType:NSPNGFileType properties:Nil];
}

@end
