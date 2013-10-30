//
//  EMBAppDelegate.h
//  EmoticonBucket
//
//  Created by Jay Lyerly on 10/29/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class EMBAppManager;

@interface EMBAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow      *window;
@property (assign) IBOutlet EMBAppManager *appManager;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
