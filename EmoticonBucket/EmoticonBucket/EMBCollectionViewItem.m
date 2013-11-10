//
//  EMBCollectionViewItem.m
//  EmoticonBucket
//
//  Created by Jay Lyerly on 11/4/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import "EMBCollectionViewItem.h"
#import "EMBColoredView.h"

NSString * const kEMBSelectionChanged = @"EMB-SelectionChange";

@interface EMBCollectionViewItem ()

@end

@implementation EMBCollectionViewItem

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    EMBColoredView *cv = (EMBColoredView *)self.view;
    cv.color = selected ? [NSColor grayColor] : [NSColor whiteColor];
    [cv setNeedsDisplay:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kEMBSelectionChanged object:nil];
}

@end
