//
//  RootViewController.h
//  AllPianoApp
//
//  Created by Aceallways on 03/03/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import <AVFoundation/AVAudioPlayer.h>
@interface RootViewController : UITableViewController <AVAudioPlayerDelegate, UIPickerViewDelegate> {
	NSArray *tableDataSource;
	NSString *CurrentTitle;
	NSInteger CurrentLevel;
	IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
	UIImageView *dotView;
	UIButton *button;
	UIButton *button2;
	UIButton *button3;
	UIButton *button4;
	UIButton *button5;
	UIButton *button6;
	UIPickerView *pickerView;
	UIButton *buttPrev;
	UIButton *buttClos;
	UIButton *buttDown;
	UIButton *buttUp;
	UILabel *diffLabel;
	NSMutableArray *buttons;
	UISlider *slider;
	UILabel *sliderLabel;
	UIButton *buttonTech;
}
-(void) searchTableView;
-(void) doneSearching_Clicked:(id)sender;
@property (nonatomic, retain) NSArray *tableDataSource;
@property (nonatomic, retain) NSString *CurrentTitle;
@property (nonatomic, readwrite) NSInteger CurrentLevel;

@end
