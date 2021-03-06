//
//  EMBDownloadManager.h
//  EmoticonBucket
//
//  Created by Jay Lyerly on 10/29/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EMBAppManager;

extern NSString * const kEMBDownloadFinished;
extern NSString * const kEMBImageUpdateFinished;

@interface EMBDownloadManager : NSObject

- (instancetype) initWithManager:(EMBAppManager *)appManager;
- (void) update:(NSURL *)baseUrl;

@end
