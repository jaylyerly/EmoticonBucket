//
//  EMBCollectionViewItem.h
//  EmoticonBucket
//
//  Created by Jay Lyerly on 11/4/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class EMBColoredView;

extern NSString * const kEMBSelectionChanged;

@interface EMBCollectionViewItem : NSCollectionViewItem
@property (nonatomic, strong) IBOutlet EMBColoredView *coloredView;

@end
