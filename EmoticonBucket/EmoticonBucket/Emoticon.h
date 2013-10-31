//
//  Emoticon.h
//  EmoticonBucket
//
//  Created by Jay Lyerly on 10/30/13.
//  Copyright (c) 2013 SonicBunny Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Emoticon : NSManagedObject

@property (nonatomic, retain) NSNumber * hcID;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * shortcut;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSData * imgData;

+ (Emoticon *)emoticonWithDictionary:(NSDictionary *)aDict;

@end
