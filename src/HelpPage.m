//
//  MDDocument.h
//  no320_mdt
//
//  Created by sang on 4/18/13.
//  Copyright (c) 2013 alfred sang. All rights reserved.
//

#import "HelpPage.h"

@implementation HelpPage

@synthesize fileName;
@synthesize contents;

- (NSString*) pageName
{
    return [fileName stringByDeletingPathExtension];
}

- (void) dealloc
{
    self.fileName = NULL;
    self.contents = NULL;
    [super dealloc];
}

@end
