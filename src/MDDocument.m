//
//  MDDocument.m
//  no320_mdt
//
//  Created by sang on 4/18/13.
//  Copyright (c) 2013 alfred sang. All rights reserved.
//

#import "MDDocument.h"
#import "HelpPage.h"
#import "MMMarkdown.h"

@implementation MDDocument
@synthesize mdFiles;

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        if (!self) return NULL;
        
        NSString* docDirPath = [[NSBundle mainBundle] pathForResource:@"Documentation" ofType:@""];
        NSArray* files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docDirPath error:NULL];
        
        mdFiles = [[NSMutableArray alloc] init];
        for (NSString* file in files)
        {
            if ([file hasSuffix:@".md"])
            {
                HelpPage* hp = [[[HelpPage alloc] init] autorelease];
                hp.fileName = file;
                [mdFiles addObject:hp];
            }
        }

    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MDDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    
    [webView setPolicyDelegate:self];
    [self loadHelpFile:[mdFiles objectAtIndex:0]];
    
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    }
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    }
    return YES;
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (void) loadHelpFile:(HelpPage*)hp
{
    // Load MD File and convert to HTML
    NSString* docPath = [[NSBundle mainBundle] pathForResource:hp.fileName ofType:@"" inDirectory:@"Documentation"];
    NSString* md = [NSString stringWithContentsOfFile:docPath encoding:NSUTF8StringEncoding error:NULL];
    NSString* innerHtml = [MMMarkdown HTMLStringWithMarkdown:md error:NULL];
    
    // Load template
    NSString* templatePath = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html" inDirectory:@"Documentation"];
    NSString* template = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:NULL];
    
    // Insert md in template
    NSString* page = [template stringByReplacingOccurrencesOfString:@"<#CONTENT#>" withString:innerHtml];
    
    // Load file into the web view
    NSURL* baseURL = [NSURL fileURLWithPath:[docPath stringByDeletingLastPathComponent]];
    [webView.mainFrame loadHTMLString:page baseURL:baseURL];
}

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
    HelpPage* page = [mdFiles objectAtIndex:[tableView selectedRow]];
    
    [self loadHelpFile:page];
}


- (void)webView:(WebView *)sender decidePolicyForNavigationAction:(NSDictionary *)actionInformation
        request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id)listener
{
    if ([[[request URL]scheme] isEqualToString:@"file"])
    {
        [listener use];
    }
    else
    {
        [listener ignore];
        // Open in Safari instead
        [[NSWorkspace sharedWorkspace] openURL:[request URL]];
    }
}


@end
