//
//  MDDocument.h
//  no320_mdt
//
//  Created by sang on 4/18/13.
//  Copyright (c) 2013 alfred sang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpPage : NSObject
{
    NSString* fileName;
    NSString* contents;
}

@property (nonatomic,retain) NSString* fileName;
@property (nonatomic,readonly) NSString* pageName;
@property (nonatomic,retain) NSString* contents;

@end
