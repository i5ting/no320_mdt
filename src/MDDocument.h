//
//  MDDocument.h
//  no320_mdt
//
//  Created by sang on 4/18/13.
//  Copyright (c) 2013 alfred sang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface MDDocument : NSDocument <NSTableViewDelegate>
{
    IBOutlet NSTableView* tableView;
    IBOutlet WebView* webView;
    NSMutableArray* mdFiles;
}


@property (nonatomic,readonly) NSMutableArray* mdFiles;

@end
