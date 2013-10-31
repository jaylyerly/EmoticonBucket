//
//  EMBAppManager.m
//  EmoticonBucket
//
//  Created by Jay Lyerly on 10/29/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import "EMBAppManager.h"
#import "EMBDownloadManager.h"
#import "EMBAppDelegate.h"
#import "Emoticon.h"

static const NSString* urlTemplate = @"https://api.hipchat.com/v2/emoticon?auth_token=%@";

@interface EMBAppManager () {
    EMBDownloadManager *_dlManager;
}
@property (nonatomic, readonly) EMBDownloadManager *dlManager;

@end


@implementation EMBAppManager

/*
+ (instancetype)sharedManager {
    static EMBAppManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
*/

- (EMBDownloadManager *) dlManager {
    if (!_dlManager){
        _dlManager = [[EMBDownloadManager alloc] initWithManager:self];
    }
    return _dlManager;
}


//- (instancetype) init {
//    self = [super init];
//    if (self){
//        _dlManager = [[EMBDownloadManager alloc] init];
//    }
//    return self;
//}

- (IBAction) updateData:(id)sender {
    [self.dlManager update];
}

- (NSURL *)dataUrl {
    NSString *auth = [[NSUserDefaults standardUserDefaults] stringForKey:@"auth"];
    NSString *urlString = [NSString stringWithFormat:[urlTemplate copy], auth];
    return [NSURL URLWithString:urlString];
}

- (void)downloadFinished:(NSNotification *)notification{
    NSLog(@"Download finished!");

    for (Emoticon *eIcon in self.emoticons) {
        NSLog(@"%@", eIcon.shortcut);
    }
    [self didChangeValueForKey:@"emoticons"];
}

- (NSArray *)emoticons {
    NSManagedObjectModel   *mom = [(EMBAppDelegate*)[NSApplication sharedApplication].delegate managedObjectModel];
    NSManagedObjectContext *moc = [(EMBAppDelegate*)[NSApplication sharedApplication].delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [mom fetchRequestTemplateForName:@"AllEmoticons"];
    NSArray *eIcons = [moc executeFetchRequest:fetchRequest error:nil];
    return eIcons;
}

- (void) awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadFinished:)
                                                 name:kEMBDownloadFinished
                                               object:nil];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
