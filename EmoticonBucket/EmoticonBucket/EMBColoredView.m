//
//  EMBColoredView.m
//  EmoticonBucket
//
//  Created by Jay Lyerly on 11/4/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import "EMBColoredView.h"

@implementation EMBColoredView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _color = [NSColor whiteColor];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];

    NSRect selectedFrame = NSInsetRect(self.bounds, 2, 2);
    
    [self.color set];
    [NSBezierPath strokeRect:selectedFrame];
    
}

@end
