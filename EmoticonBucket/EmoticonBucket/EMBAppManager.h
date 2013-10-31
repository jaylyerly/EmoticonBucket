//
//  EMBAppManager.h
//  EmoticonBucket
//
//  Created by Jay Lyerly on 10/29/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMBAppManager : NSObject

@property (nonatomic, readonly) NSURL *dataUrl;
@property (nonatomic, readonly) NSArray *emoticons;
@property (nonatomic, readonly) IBOutlet NSCollectionView *collectionView;

//+ (id)sharedManager;
- (IBAction) updateData:(id)sender;

@end
