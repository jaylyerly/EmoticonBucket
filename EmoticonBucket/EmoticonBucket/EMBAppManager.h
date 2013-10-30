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

//+ (id)sharedManager;
- (IBAction) updateData:(id)sender;

@end
