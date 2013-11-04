//
//  Emoticon.m
//  EmoticonBucket
//
//  Created by Jay Lyerly on 10/30/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import "Emoticon.h"
#import "EMBAppDelegate.h"

@implementation Emoticon

@dynamic hcID;
@dynamic link;
@dynamic shortcut;
@dynamic url;
@dynamic imgData;

+ (Emoticon *)emoticonWithDictionary:(NSDictionary *)aDict
{
    EMBAppDelegate *delegate = (EMBAppDelegate *)[NSApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    Emoticon* eIcon = (Emoticon*)[NSEntityDescription insertNewObjectForEntityForName:@"Emoticon" inManagedObjectContext:context];

    eIcon.hcID = aDict[@"id"];
    eIcon.link = aDict[@"links"][@"self"];
    eIcon.shortcut = aDict[@"shortcut"];
    eIcon.url = aDict[@"url"];
    
    // get eIcon.imgData;
    
    
    return eIcon;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Emoticon(%@)", self.shortcut];
}

@end
