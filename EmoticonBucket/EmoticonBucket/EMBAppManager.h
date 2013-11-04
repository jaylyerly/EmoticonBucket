//
//  EMBAppManager.h
//  EmoticonBucket
//
//  Created by Jay Lyerly on 10/29/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMBAppManager : NSObject <NSCollectionViewDelegate>

@property (nonatomic, readonly) NSURL *dataUrl;
@property (nonatomic, readonly) NSArray *emoticons;
@property (nonatomic, strong) IBOutlet NSCollectionView *collectionView;
@property (nonatomic, strong) IBOutlet NSArrayController *emoticonController;

//+ (id)sharedManager;
- (void) setup;
- (IBAction) updateData:(id)sender;

@end
