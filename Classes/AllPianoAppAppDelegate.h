//
//  AllPianoAppAppDelegate.h
//  AllPianoApp
//
//  Created by Aceallways on 03/03/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@interface AllPianoAppAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    //UINavigationController *navigationController;
	UIViewController *navigationController;
	NSDictionary *data;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *navigationController;

@property (nonatomic, retain) NSDictionary *data;
@end

