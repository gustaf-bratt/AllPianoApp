//
//  AllPianoAppAppDelegate.m
//  AllPianoApp
//
//  Created by Aceallways on 03/03/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AllPianoAppAppDelegate.h"
//#import "RootViewController.h"
#import "menuVC.h"


@implementation AllPianoAppAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize data;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    NSString *Path=[[NSBundle mainBundle] bundlePath];
	NSString *DataPath=[Path stringByAppendingPathComponent:@"Data.plist"];
	NSDictionary *tempDict=[[NSDictionary alloc] initWithContentsOfFile:DataPath];
	self.data=tempDict;
	[tempDict release];
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

