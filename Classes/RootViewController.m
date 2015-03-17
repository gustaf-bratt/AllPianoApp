//
//  RootViewController.m
//  AllPianoApp
//
//  Created by Aceallways on 03/03/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "AllPianoAppAppDelegate.h"
#import "SimpleAudioEngine.h"
#import "flipView.h"

@implementation RootViewController
@synthesize CurrentLevel;
@synthesize CurrentTitle;
@synthesize tableDataSource;

BOOL clear=FALSE;
NSMutableArray *copyListOfItems;
NSMutableArray *listOfItems;
NSMutableArray *origListOfItems;
int indexes[300];
int indexes2[300];
float frequenciesPiano[89];
BOOL first=TRUE;
AVAudioPlayer* theAudio;
int note1=1;
int note2=1;
int selCol1=1;
int selCol2=1;
int selPar1=1;
int selPar2=1;
int theGoodPar1=1;
int theGoodPar2=1;
UIButton *infoButt;
float curNoteClose=1;
NSTimer *timer;
-(void) downloadSave:(NSString *)fileIs
{
	//DOWNLOAD AND SAVE CODE
	NSError *err = [[[NSError alloc] init] autorelease];
	NSString *url = [[NSString stringWithFormat:@"http://meerkata.com/uploads/%@.txt", fileIs] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *myTxtFile = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:&err];
	if(err.code != 0) {
		//HANDLE ERROR HERE
	}	
	//Save a file
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *pathComp=[NSString stringWithFormat:@"%@.txt", fileIs];
	NSString *filePath = [documentsDirectoryPath  stringByAppendingPathComponent:pathComp];
	//NSString *fileText = [NSString stringWithContentsOfFile:filePath];
	NSString *fileText=myTxtFile;
	NSString *settings =fileText; //[fileText stringByAppendingString:@"\ntest"];
	NSData* settingsData;
	settingsData = [settings dataUsingEncoding: NSASCIIStringEncoding];
	
	if ([settingsData writeToFile:filePath atomically:YES])
		NSLog(@"writeok");		
}
-(void)buttonPressed
{//download all files as needed
	//check if needs updating
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path;// = [[NSBundle mainBundle] pathForResource:CurrentTitle ofType:@"txt"];  
	path=[documentsDirectoryPath  stringByAppendingPathComponent:@"version.txt"];
	NSString *fileText = [NSString stringWithContentsOfFile:path];
	if(fileText==nil)
	{
	//DOWNLOAD AND SAVE CODE
	NSString *fileIs=@"version";
	NSError *err = [[[NSError alloc] init] autorelease];
	NSString *url = [[NSString stringWithFormat:@"http://meerkata.com/uploads/%@.txt", fileIs] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *myTxtFile = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:&err];
	if(err.code != 0) {
		//HANDLE ERROR HERE
	}	
	if([fileText isEqualToString:myTxtFile])
	{
		//dont update
		NSLog(@"test1");
	}
	else
	{
		NSLog(@"test");
		//say you are going to update
		//progress thing
		//done updating
		//save version.txt
		NSString *pathComp=[NSString stringWithFormat:@"%@.txt", fileIs];
		NSString *filePath = [documentsDirectoryPath  stringByAppendingPathComponent:pathComp];
		NSData *settingsData = [myTxtFile dataUsingEncoding: NSASCIIStringEncoding];
		if ([settingsData writeToFile:filePath atomically:YES])
			NSLog(filePath);
		//
			fileIs=@"manList";
	url = [[NSString stringWithFormat:@"http://meerkata.com/uploads/%@.txt", fileIs] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	myTxtFile = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:&err];
	if(err.code != 0) {
		//HANDLE ERROR HERE
	}
	NSString *path;// = [[NSBundle mainBundle] pathForResource:CurrentTitle ofType:@"txt"];  
	path=[documentsDirectoryPath  stringByAppendingPathComponent:@"manList.txt"];
	NSString *fileText = [NSString stringWithContentsOfFile:path];
	//if([fileText isEqualToString:myTxtFile])
	//{	//no new piano companies, should this really be here? have to add a company every update then lol
	//}
	//else
	//{
		pathComp=[NSString stringWithFormat:@"%@.txt", fileIs];
		filePath = [documentsDirectoryPath  stringByAppendingPathComponent:pathComp];
		//NSString *fileText = [NSString stringWithContentsOfFile:filePath];
		fileText=myTxtFile;
		NSString *settings =fileText; //[fileText stringByAppendingString:@"\ntest"];
		//NSData* settingsData;
		settingsData = [settings dataUsingEncoding: NSASCIIStringEncoding];
		if ([settingsData writeToFile:filePath atomically:YES])
			NSLog(filePath);	
		NSMutableArray *listOfItemsT;
		listOfItemsT = [[NSMutableArray alloc]
					   initWithArray:[fileText componentsSeparatedByString:@"\n"]
					   copyItems:YES];
		for(int i=0;i<[listOfItemsT count];i++)
		{
			//DOWNLOAD AND SAVE CODE
			NSString *fileWas=[listOfItemsT objectAtIndex:i];
			fileIs = [fileWas stringByReplacingOccurrencesOfString:@"\"" withString:@"_"];
			err = [[[NSError alloc] init] autorelease];
			url = [[NSString stringWithFormat:@"http://meerkata.com/uploads/%@.txt", fileIs] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			myTxtFile = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:&err];
			if(err.code != 0) {
				//HANDLE ERROR HERE
			}	  
			NSString *pathComp=[NSString stringWithFormat:@"%@.txt", fileWas];
			NSString *filePath=[documentsDirectoryPath  stringByAppendingPathComponent:pathComp];
			fileText = [NSString stringWithContentsOfFile:filePath];
			if([fileText isEqualToString:myTxtFile])
			{
			}
			else
			{
				fileText=myTxtFile;
				NSString *settings =fileText; //[fileText stringByAppendingString:@"\ntest"];
				NSData *settingsData = [settings dataUsingEncoding: NSASCIIStringEncoding];
				if ([settingsData writeToFile:filePath atomically:YES])
					NSLog(filePath);	
			}
		}
	}
	}
}
-(void)hideMainMen
{
	infoButt.hidden=YES;
	buttonTech.hidden=YES;
	dotView.hidden=YES;
	//button.hidden=YES;
	button2.hidden=YES;
	button3.hidden=YES;
	button4.hidden=YES;
	button6.hidden=YES;
}
-(void)buttonPressed2
{
	self.tableView.tableHeaderView=searchBar;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self hideMainMen];
	self.navigationController.navigationBarHidden=NO;
	self.tableView.scrollEnabled=YES;
	CurrentLevel=0;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path;// = [[NSBundle mainBundle] pathForResource:CurrentTitle ofType:@"txt"];  
	path=[documentsDirectoryPath  stringByAppendingPathComponent:@"manList.txt"];
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"manList" ofType:@"txt"];  
	NSString *fileText = [NSString stringWithContentsOfFile:path];
	listOfItems = [[NSMutableArray alloc]
				   initWithArray:[fileText componentsSeparatedByString:@"\n"]
				   copyItems:YES];
	copyListOfItems = [[NSMutableArray alloc]
					   initWithArray:[fileText componentsSeparatedByString:@"\n"]
					   copyItems:YES];
	origListOfItems = [[NSMutableArray alloc]
					   initWithArray:[fileText componentsSeparatedByString:@"\n"]
					   copyItems:YES];
	for(int i=0;i<[listOfItems count];i++)
	{
		indexes2[i]=i;
	}
	self.navigationItem.title=@"Manufacturer";	
	[self.tableView reloadData];
}
int id2=0;
-(void)buttonPressed3
{//cover everything with the image, then w/e is needed
	slider = [[UISlider alloc] initWithFrame:CGRectMake(160-135, 385, 276, 25)];
	[slider setMinimumValue:420];
	[slider setMaximumValue:460];
	[slider setValue:440];
	[slider addTarget:self action:@selector(sliderChanged2:) 
	 forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:slider];
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"cover2" ofType:@".png"];
	self.navigationController.navigationBarHidden=NO;
	self.navigationItem.title=@"Electronic Fork";
	//dotView.image=[UIImage imageNamed:@"cover2.png"];
	[self hideMainMen];
	dotView.hidden=NO;
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"440hzShort.caf"];
	//[theAudio play];
	button5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	//set the position of the button
	button5.frame = CGRectMake(40, 320, 240, 40);
	//set the button's title
	[button5 setTitle:@"Play" forState:UIControlStateNormal];
	//listen for clicks
	[button5 addTarget:self action:@selector(buttonPressed5)
	  forControlEvents:UIControlEventTouchUpInside];
	//add the button to the view
	[self.view addSubview:button5];
}
int id1=0;
BOOL statePrev=FALSE;
- (void) handleTimer: (NSTimer *) timer
{
	[[SimpleAudioEngine sharedEngine] stopEffect:id1];
	id1=[[SimpleAudioEngine sharedEngine] playEffect:@"440hzShort.caf" pitch:1.0 pan:1.0 gain:1.0 loop:NO];
} // handleTimer
-(void)previewDiff
{
	if(!statePrev)
	{
		statePrev=TRUE;
		//play the difference
		//get diff from text
		NSString *theDiff=diffLabel.text;
		NSMutableArray *diffArr=[[NSMutableArray alloc]
								 initWithArray:[theDiff componentsSeparatedByString:@" "]
								 copyItems:YES];
		float cDiff=[[diffArr objectAtIndex:1]floatValue];
		[buttPrev setTitle:@"Stop" forState:UIControlStateNormal];
		timer = [NSTimer scheduledTimerWithTimeInterval: (1/cDiff)
												 target: self
											   selector: @selector(handleTimer:)
											   userInfo: nil
												repeats: YES];
		/*
		 //[theAudio play];
		 */
	}
	else {
		statePrev=FALSE;
		[[SimpleAudioEngine sharedEngine] stopEffect:id1];
		[buttPrev setTitle:@"Preview" forState:UIControlStateNormal];
		[timer invalidate];
		timer=nil;
		//[timer release];
	}

}
-(void)findUp
{
	//like find close but heading down
	//find left note (note1)
	/*
	int closest=0;
	float tCurnoteclose=0;
	float cDiff=10000;
	float freq1=(pow(1.05946309, note1-49))*440;//this is the frequency to test from
	//calculate closest note
	 for(int i=1;i<=88;i++)
	 {
		float freq2=(pow(1.05946309, i-49))*440;
		float diff=freq1-freq2;
		if(freq2>curNoteClose)
		{
			if(diff<0)
			{
				diff*=-1;
			}
			if(diff<cDiff&&diff>0)
			{
				tCurnoteclose=freq2;
				cDiff=diff;
				closest=i;
			}
		}
	}
	curNoteClose=tCurnoteclose;
	//NSLog([NSString stringWithFormat:@"%f", curNoteClose]);
	//move picker view to that note
	note2=closest;
	if(closest!=0)
	{
		int component=((closest)/12);
		int row=((closest)%12);
		if(row==0)
		{
			row=12;
		}
		if(row==12)
		{
			component--;
		}
		[pickerView selectRow:row-1 inComponent:3 animated:YES];
		if(component>7)
		{
			component=7;
		}
		selCol2=(row);
		[pickerView selectRow:component inComponent:2 animated:YES];
		[pickerView reloadAllComponents];
		[pickerView selectRow:component inComponent:2 animated:YES];	
		NSString *diffT=[NSString stringWithFormat:@"Difference: %.3f Hz", cDiff];
		[diffLabel setText:diffT];
	}
	else {
		buttUp.enabled=FALSE;
	}
*/
	int closest=0;
	float cDiff=10000;
	float freq1=frequenciesPiano[note1];//this is the frequency to test from
	//freq1=round(time*1000.0)/1000.0;
	//calculate closest note
	int bottom=note1-8;
	if((note1-8)<1)
	{
		bottom=1;
	}
	int top=note1+8;
	if((note1+8)>88)
	{
		top=88;
	}
	for(int i=note2+1;i<=top;i++)
	{
		float freq2=frequenciesPiano[i];
		for (int y=1;y<7;y++)
		{
			freq1*=y;
			for(int x=1;x<7;x++)
			{
				freq2*=x;
				//if(freq2>(curNoteClose) )//moving down frequencies
				{
					float diff=freq1-freq2;
					if(diff<0)
					{
						diff*=-1;
					}
					if(diff<cDiff&&diff>0.01)
					{
						//NSLog([NSString stringWithFormat:@"1: %f, 2: %f, 3: %f, %f",freq1,freq2, (freq2/x), diff]);
						cDiff=diff;
						curNoteClose=freq2;
						closest=i;
						theGoodPar1=y;
						theGoodPar2=x;
					}
					freq2/=x;
				}
				freq1/=y;
			}
		}
	}
	if(closest!=0)
	{
		note2=closest;
		//move picker view to that note
		//curNoteClose=cDiff;
		int component=((closest)/12);
		int row=((closest)%12);
		if(row==0)
		{
			row=12;
		}
		if(row==12)
		{
			component--;
		}
		[pickerView selectRow:row-1 inComponent:3 animated:YES];
		if(component>7)
		{
			component=7;
		}
		selCol2=(row);
		[pickerView selectRow:component inComponent:2 animated:YES];
		[pickerView reloadAllComponents];
		[pickerView selectRow:component inComponent:2 animated:YES];
		buttDown.enabled=TRUE;
		buttUp.enabled=TRUE;
	}
}
-(void)findDown
{
	//find left note (note1)
	int closest=0;
	float cDiff=10000;
	float freq1=frequenciesPiano[note1];//this is the frequency to test from
	//freq1=round(time*1000.0)/1000.0;
	//calculate closest note
	int bottom=note1-8;
	if((note1-8)<1)
	{
		bottom=1;
	}
	int top=note1+8;
	if((note1+8)>88)
	{
		top=88;
	}
	for(int i=note2-1;i>=bottom;i--)
	{
		float freq2=frequenciesPiano[i];
		for (int y=1;y<7;y++)
		{
			freq1*=y;
			for(int x=1;x<7;x++)
			{
				freq2*=x;
				if(freq2<(curNoteClose) )//moving down frequencies
				{
					float diff=freq1-freq2;
					if(diff<0)
					{
						diff*=-1;
					}
					if(diff<cDiff&&diff>0.01)
					{
						//NSLog([NSString stringWithFormat:@"1: %f, 2: %f, 3: %f, %f",freq1,freq2, (freq2/x), diff]);
						cDiff=diff;
						curNoteClose=freq2;
						closest=i;
						theGoodPar1=y;
						theGoodPar2=x;
					}
					freq2/=x;
				}
				freq1/=y;
			}
		}
	}
	if(closest!=0)
	{
		note2=closest;
		//move picker view to that note
		//curNoteClose=cDiff;
		int component=((closest)/12);
		int row=((closest)%12);
		if(row==0)
		{
			row=12;
		}
		if(row==12)
		{
			component--;
		}
		[pickerView selectRow:row-1 inComponent:3 animated:YES];
		if(component>7)
		{
			component=7;
		}
		selCol2=(row);
		[pickerView selectRow:component inComponent:2 animated:YES];
		[pickerView reloadAllComponents];
		[pickerView selectRow:component inComponent:2 animated:YES];
		buttDown.enabled=TRUE;
		buttUp.enabled=TRUE;	
	}
	/*
	//like find close but heading down
	//find left note (note1)
	int closest=0;
	float tCurnoteclose;
	float cDiff=10000;
	float freq1=(pow(1.05946309, note1-49))*440;//this is the frequency to test from
	//calculate closest note
	for(int i=1;i<=88;i++)
	{
		float freq2=(pow(1.05946309, i-49))*440;
		if(freq2<curNoteClose)
		{
		float diff=freq1-freq2;
		if(diff<0)
		{
			diff*=-1;
		}
		if(diff<cDiff&&diff>0)
		{
			cDiff=diff;
			closest=i;
			tCurnoteclose=freq2;
		}
		}
	}
	curNoteClose=tCurnoteclose;
	//move picker view to that note
	note2=closest;
	if(closest!=0)
	{
		int component=((closest)/12);
		int row=((closest)%12);
		if(row==0)
		{
			row=12;
		}
		if(row==12)
		{
			component--;
		}
		[pickerView selectRow:row-1 inComponent:3 animated:YES];
		if(component>7)
		{
			component=7;
		}
		selCol2=(row);
		[pickerView selectRow:component inComponent:2 animated:YES];
		[pickerView reloadAllComponents];
		[pickerView selectRow:component inComponent:2 animated:YES];
	}
	else {
		buttDown.enabled=FALSE;
	}
*/
}
-(void)findClose
{
	//find left note (note1)
	int closest=0;
	float cDiff=10000;
	float freq1=frequenciesPiano[note1];//this is the frequency to test from
	//freq1=round(time*1000.0)/1000.0;
	//calculate closest note
	int bottom=note1-8;
	if((note1-8)<1)
	{
		bottom=1;
	}
	int top=note1+8;
	if((note1+8)>88)
	{
		top=88;
	}
	//for(int i=bottom;i<=top;i++)
	{
		//float freq2=frequenciesPiano[i];
		float freq2=frequenciesPiano[note2];
		closest=note2;
		for (int y=1;y<7;y++)
		{
			freq1*=y;
			for(int x=1;x<7;x++)
			{
				freq2*=x;
				float diff=freq1-freq2;
				if(diff<0)
				{
					diff*=-1;
				}
				if(diff<cDiff&&diff>0.01)
				{
					//NSLog([NSString stringWithFormat:@"1: %f, 2: %f, 3: %f, %f",freq1,freq2, (freq2/x), diff]);
					cDiff=diff;
					curNoteClose=freq2;
					//closest=i;
					theGoodPar1=y;
					theGoodPar2=x;
				}
				freq2/=x;
			}
			freq1/=y;
		}
	}
	note2=closest;
	//move picker view to that note
	//curNoteClose=cDiff;
	int component=((closest)/12);
	int row=((closest)%12);
	if(row==0)
	{
		row=12;
	}
	if(row==12)
	{
		component--;
	}
	[pickerView selectRow:row-1 inComponent:3 animated:YES];
	if(component>7)
	{
		component=7;
	}
	selCol2=(row);
	[pickerView selectRow:component inComponent:2 animated:YES];
	[pickerView reloadAllComponents];
	[pickerView selectRow:component inComponent:2 animated:YES];
	buttDown.enabled=TRUE;
	buttUp.enabled=TRUE;
	/*
	 if(selCol1>3)
	 {
	 note = selCol1+((row-1)*12);
	 }
	 else {
	 note = selCol1+(row*12);
	 }
	 */
}
-(void)updateButts
{
	//set text of all the buttons (match within 15)
	/*
	 color main = blue
	 2 = yellow
	 3 = green
	 4 = purple
	 5 = 
	 nothing = red
	 */
	float firestFr=0;
	float secondFr=0;
	for(int i=0;i<6;i++)
	{
		float freqU=frequenciesPiano[note1];
		freqU*=(i+1);
		if(i+1==theGoodPar1)
		{
			[[buttons objectAtIndex:i] setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
			firestFr=freqU;
		}
		else {
			[[buttons objectAtIndex:i] setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
		}
		[[buttons objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d: %.3f", i+1, freqU]forState:UIControlStateNormal];
	}
	for(int i=0;i<6;i++)
	{
		float freqU=frequenciesPiano[note2];
		freqU*=(i+1);
		if(i+1==theGoodPar2)
		{
			[[buttons objectAtIndex:i+6] setTitleColor:[UIColor blueColor]forState:UIControlStateNormal ];
			secondFr=freqU;
		}
		else {
			[[buttons objectAtIndex:i+6] setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
		}
		[[buttons objectAtIndex:i+6] setTitle:[NSString stringWithFormat:@"%d: %.3f", i+1, freqU]forState:UIControlStateNormal];
	}
	float cDiff=firestFr-secondFr;
	if(cDiff<0)
	{
		cDiff*=-1;
	}
	NSString *diffT=[NSString stringWithFormat:@"Diff: %.3f", cDiff];
	[diffLabel setText:diffT];	
}
-(void)buttT:(id)sender
{
	int maxHz =(int)(slider.value);
	float firestFr=0;
	float secondFr=0;
	//NSLog([NSString stringWithFormat:@"%d", [sender tag]]);
	if([sender tag]>5)
	{
		theGoodPar2=[sender tag]-5;
		[self updateButts];
		[[buttons objectAtIndex:[sender tag]] setTitleColor:[UIColor greenColor]forState:UIControlStateNormal];
		//set text of all the buttons (match within 15)
		/*
		 color main = blue
		 2 = yellow
		 3 = green
		 4 = purple
		 5 = 
		 nothing = red
		 */
		float freqU=frequenciesPiano[note2];
		freqU*=([sender tag]-5);
		firestFr=freqU;
		for(int i=0;i<6;i++)
		{
			float freqU2=frequenciesPiano[note1];
			freqU2*=(i+1);
			float diff=(freqU-freqU2);
			if(diff<0)
			{
				diff*=-1;
			}
			/*if(i+1==theGoodPar1)
			{
				//[[buttons objectAtIndex:i] setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
			}
			else*/ if(diff<maxHz) {
				[[buttons objectAtIndex:i] setTitleColor:[UIColor greenColor]forState:UIControlStateNormal];
				secondFr=freqU2;
			}
			else {
				[[buttons objectAtIndex:i] setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
			}
			//freqU*=(i+1);
			//[[buttons objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d: %.3f", i+1, freqU]forState:UIControlStateNormal];
		}	
	}
	else {
		theGoodPar1=[sender tag]+1;
		[self updateButts];
		[[buttons objectAtIndex:[sender tag]] setTitleColor:[UIColor greenColor]forState:UIControlStateNormal];
		//set text of all the buttons (match within 15)
		/*
		 color main = blue
		 2 = yellow
		 3 = green
		 4 = purple
		 5 = 
		 nothing = red
		 */
		float freqU=frequenciesPiano[note1];
		freqU*=([sender tag]+1);
		firestFr=freqU;
		for(int i=0;i<6;i++)
		{
			float freqU2=frequenciesPiano[note2];
			freqU2*=(i+1);
			float diff=(freqU-freqU2);
			if(diff<0)
			{
				diff*=-1;
			}
			if(diff<maxHz) {
				 [[buttons objectAtIndex:i+6] setTitleColor:[UIColor greenColor]forState:UIControlStateNormal];
				secondFr=freqU2;
			}
			 else {
				 [[buttons objectAtIndex:i+6] setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
			 }
			//freqU*=(i+1);
			//[[buttons objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d: %.3f", i+1, freqU]forState:UIControlStateNormal];
		}	
	}
	float cDiff=firestFr-secondFr;
	if(cDiff<0)
	{
		cDiff*=-1;
	}
	NSString *diffT=[NSString stringWithFormat:@"Diff: %.3f", cDiff];
	[diffLabel setText:diffT];	
}
-(IBAction) sliderChanged:(id) sender{
	UISlider *slider1 = (UISlider *) sender;
	int progressAsInt =(int)(slider1.value);
	NSString *newText =[[NSString alloc]
						 initWithFormat:@"%d",progressAsInt];
	sliderLabel.text = newText;
	[newText release];
}
-(IBAction) sliderChanged2:(id) sender{
	UISlider *slider1 = (UISlider *) sender;
	//int progressAsInt =(int)(slider1.value);
	//change pitch
	[[SimpleAudioEngine sharedEngine] stopEffect:id2];
	id2=[[SimpleAudioEngine sharedEngine] playEffect:@"440hzShort.caf" pitch:slider1.value/440 pan:1.0 gain:1.0 loop:YES];
}
-(void)techPress
{//into the technical stuff
}
-(void)buttonPressed4
{
	//set all the frequencies
	for(int i=0;i<89;i++)
	{
		frequenciesPiano[i]=(pow(1.05946309, i-49))*440;//this is the frequency to test from
	}
	clear=TRUE;
	[self.tableView reloadData];
	[self hideMainMen];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"440hzShort.caf"];
	//[[SimpleAudioEngine sharedEngine] preloadEffect:@"Bleep.caf"];
	pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 120.0)];
	//pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;	
	[pickerView setDelegate:self];
	//pickerView.frame = CGRectMake(0.0, 0.0, 320.0, 320.0);
	[pickerView setShowsSelectionIndicator:TRUE];
	// 2 - add the picker view as a subview of the actual scene
	[self.view addSubview:pickerView];
	self.navigationController.navigationBarHidden=NO;
	self.navigationItem.title=@"Aural Aide";	
	//add some buttons
	buttPrev = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttPrev.frame = CGRectMake(160-50, 250, 100, 30);//1 third = 106 - 20 borders = 93 - 30 diff = 83.3
	[buttPrev setTitle:@"Preview" forState:UIControlStateNormal];
	[buttPrev addTarget:self action:@selector(previewDiff)
	 forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttPrev];
	buttClos = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttClos.frame = CGRectMake(160-50, 285, 100, 30);
	[buttClos setTitle:@"Closest" forState:UIControlStateNormal];
	[buttClos addTarget:self action:@selector(findClose)
	   forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttClos];
	buttDown = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttDown.frame = CGRectMake(160-50, 320, 100, 30);
	[buttDown setTitle:@"Next Down" forState:UIControlStateNormal];
	[buttDown addTarget:self action:@selector(findDown)
	   forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttDown];
	buttUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	buttUp.frame = CGRectMake(160-50, 355, 100, 30);
	[buttUp setTitle:@"Next Up" forState:UIControlStateNormal];
	[buttUp addTarget:self action:@selector(findUp)
	   forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttUp];
	slider = [[UISlider alloc] initWithFrame:CGRectMake(160-25, 385, 76, 25)];
	[slider setMinimumValue:5];
	[slider setMaximumValue:25];
	[slider setValue:15];
	[slider addTarget:self action:@selector(sliderChanged:) 
	 forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:slider];
	sliderLabel=[[UILabel alloc] initWithFrame:CGRectMake(111, 385, 25, 25)];
	[sliderLabel setText:@"15"];
	[self.view addSubview:sliderLabel];
	buttUp.enabled=FALSE;
	buttDown.enabled=FALSE;
	diffLabel=[[UILabel alloc] init];
	diffLabel.frame=CGRectMake(160-55, 220, 110, 30);
	[diffLabel setTextAlignment:UITextAlignmentCenter];
	[diffLabel setText:@"Diff: "];
	[self.view addSubview:diffLabel];
	for(int i=0;i<12;i++)
	{
		UIButton *buttT = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		//set the position of the button
		buttT.frame = CGRectMake(10+(205*(i/6)), (225+(31*i))-(186*(i/6)), 95, 28);
		//set the button's title
		[buttT setTitle:[NSString stringWithFormat:@"%d: ", i+1] forState:UIControlStateNormal];
		//listen for clicks
		[buttT addTarget:self action:@selector(buttT:)
		 		forControlEvents:UIControlEventTouchUpInside];
		[buttT setTag:i];
		//add the button to the view
		[buttons addObject:buttT]; 
		[self.view addSubview:[buttons objectAtIndex:i]];
		//[[buttons objectAtIndex:i] setTag:i];
	}
}
- (int) numberOfColumnsInPickerView:(UIPickerView*)picker
{
	float freq1=frequenciesPiano[note1];//this is the frequency to test from
	float freq2=frequenciesPiano[note2];
	float cDiff=freq1-freq2;
	if(cDiff<0)
	{
		cDiff*=-1;
	}
	[self updateButts];
	return 4;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component { // This method also needs to be used. This asks how many rows the UIPickerView will have.
	if(component==0||component==3)
	{
		return 12; // We will need the amount of rows that we used in the pickerViewArray, so we will return the count of the array.
	}
	else{
		if(component==1)
		{
			if(selCol1>4)
			{
				return 7;
			}
			else {
				return 8;
			}
		}
		else
		{
			if(selCol2>4)
			{
				return 7;
			}
			else {
				return 8;
			}
		}
	}
}

-(CGFloat) pickerView:(UIPickerView *) pickerView widthForComponent:(NSInteger) component {
	
	CGFloat componentWidth;
	if (component == 0||component==3) {
		componentWidth = 40.0; // First column size for Width Names
	} else {
		componentWidth = 100.0; // Second column size for Depth Names
	}
	return componentWidth;
	
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { // This method asks for what the title or label of each row will be.
	if(component==0)
	{
		if(row==0)
		{
			return @"A";
		}
		else if(row==1)
		{
			return @"A#";
		}
		else if(row==2)
		{
			return @"B";
		}
		else if(row==3)
		{
			return @"C";
		}
		else if(row==4)
		{
			return @"C#";
		}
		else if(row==5)
		{
			return @"D";
		}
		else if(row==6)
		{
			return @"D#";
		}
		else if(row==7)
		{
			return @"E";
		}
		else if(row==8)
		{
			return @"F";
		}
		else if(row==9)
		{
			return @"F#";
		}
		else if(row==10)
		{
			return @"G";
		}
		else if(row==11)
		{
			return @"G#";
		}
		else {
			return @"error";
		}

	}
	else if(component==1)
	{
		//where row is the note
		int note;
		if(selCol1>3)
		{
			row++;
			note = selCol1+((row-1)*12);
		}
		else {
			note = selCol1+(row*12);
		}
		float freq=frequenciesPiano[note];
		return [NSString stringWithFormat:@"%d: %.1f",row, freq];
	}
	else if(component==2)
	{
		//where row is the note
		int note;
		if(selCol2>3)
		{
			row++;
			note = selCol2+((row-1)*12);
		}
		else {
			note = selCol2+(row*12);
		}
		note2=note;
		float freq=frequenciesPiano[note];
		return [NSString stringWithFormat:@"%d: %.1f",row, freq];
	}
	else
	{
		if(row==0)
		{
			return @"A";
		}
		else if(row==1)
		{
			return @"A#";
		}
		else if(row==2)
		{
			return @"B";
		}
		else if(row==3)
		{
			return @"C";
		}
		else if(row==4)
		{
			return @"C#";
		}
		else if(row==5)
		{
			return @"D";
		}
		else if(row==6)
		{
			return @"D#";
		}
		else if(row==7)
		{
			return @"E";
		}
		else if(row==8)
		{
			return @"F";
		}
		else if(row==9)
		{
			return @"F#";
		}
		else if(row==10)
		{
			return @"G";
		}
		else if(row==11)
		{
			return @"G#";
		}
		else {
			return @"error";
		}
	}
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component { // And now the final part of the UIPickerView, what happens when a row is selected.
	if(component==0)
	{
		selCol1=row+1;
		[pickerView reloadAllComponents];
		int note;
		if(selCol1>3)
		{
			note= selCol1+((selPar1-1)*12);
		}
		else {
			note= selCol1+((selPar1-1)*12);
		}
		note1=note;
		//NSLog([NSString stringWithFormat:@"SelPar1: %d, Note:%d", selPar1, note1]);
	}
	else if(component==3)
	{
		selCol2=row+1;
		[pickerView reloadAllComponents];
		int note;
		if(selCol2>3)
		{
			note= selCol2+((selPar2-1)*12);
		}
		else {
			note= selCol2+((selPar2-1)*12);
		}
		note2=note;
	}
	else if(component==1)
	{
		selPar1=row+1;
		//where row is the note
		int note;
		if(selCol1>3)
		{
			note = selCol1+((row)*12);
		}
		else {
			note = selCol1+(row*12);
		}
		note1=note;
	}
	else if(component==2)
	{
		selPar2=row+1;
		int note;
		if(selCol2>3)
		{
			note = selCol2+((row)*12);
		}
		else {
			note = selCol2+(row*12);
		}
		note2=note;
	}
	float freq1=frequenciesPiano[note1];//this is the frequency to test from
	float freq2=frequenciesPiano[note2];
	float cDiff=freq1-freq2;
	if(cDiff<0)
	{
		cDiff*=-1;
	}
	[self updateButts];
	theGoodPar1=1;
	theGoodPar2=1;
}

-(void)buttonPressed5
{
	if(id2==0)
	{//not playing
		//[[SimpleAudioEngine sharedEngine] stopEffect:id2];
		id2=[[SimpleAudioEngine sharedEngine] playEffect:@"440hzShort.caf" pitch:1.0 pan:1.0 gain:1.0 loop:YES];
		//-(ALuint) playEffect:(NSString*) filePath pitch:(Float32) pitch pan:(Float32) pan gain:(Float32) gain loop:(BOOL) loop
		[button5 setTitle:@"Stop" forState:UIControlStateNormal];
	}
	else {//playing
		[[SimpleAudioEngine sharedEngine] stopEffect:id2];
		[button5 setTitle:@"Play" forState:UIControlStateNormal];
		id2=0;
	}
/*
	if([theAudio isPlaying])
	{
		[theAudio stop];
		[button5 setTitle:@"Play" forState:UIControlStateNormal];
	}
	else {
		[theAudio play];
		[button5 setTitle:@"Stop" forState:UIControlStateNormal];
	}
 */
}
-(void)buttonPressed6
{//load schematics
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self hideMainMen];
	self.navigationController.navigationBarHidden=NO;
	self.tableView.scrollEnabled=YES;
	CurrentLevel=0;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"schematics" ofType:@"txt"];   
	NSString *fileText = [NSString stringWithContentsOfFile:path];
	listOfItems = [[NSMutableArray alloc]
				   initWithArray:[fileText componentsSeparatedByString:@"\n"]
				   copyItems:YES];
	copyListOfItems = [[NSMutableArray alloc]
					   initWithArray:[fileText componentsSeparatedByString:@"\n"]
					   copyItems:YES];
	origListOfItems = [[NSMutableArray alloc]
					   initWithArray:[fileText componentsSeparatedByString:@"\n"]
					   copyItems:YES];
	for(int i=0;i<[listOfItems count];i++)
	{
		indexes2[i]=i;
	}
	self.navigationItem.title=@"Schematics";	
	[self.tableView reloadData];
}
-(void)infoFlip
{
	flipView *vc = [[flipView alloc]
								initWithNibName:@"flipView" bundle:nil];
	//vc.delegate = self;
	// The magic statement. This will flip from right to left.
	// present the modal view controller then when you dismissModalViewController
	// it will transition flip from left to right. Simple and elegant.
	vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:vc animated:YES];
	[vc release];	
}
-(void)backToMain:(id)sender
{
	listOfItems=nil;
	clear=FALSE;
	infoButt.hidden=NO;
	self.tableView.tableHeaderView=nil;
	[theAudio stop];
	if(statePrev)
	{
		statePrev=FALSE;
		[timer invalidate];
		timer=nil;
	}
	[[SimpleAudioEngine sharedEngine] stopEffect:id2];
	[[SimpleAudioEngine sharedEngine] stopEffect:id1];
	id1=0;
	id2=0;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	dotView.hidden=NO;
	//button.hidden=NO;
	buttonTech.hidden=NO;
	button2.hidden=NO;
	button3.hidden=NO;
	//self.tableView.hidden=NO;
	self.navigationController.navigationBarHidden=YES;
	self.tableView.scrollEnabled=NO;
	first=TRUE;
	for (UIView *view in self.view.subviews) {
		[view removeFromSuperview];
	}
	[self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
	[self viewDidLoad];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	if(first)
	{
		self.tableView.tableHeaderView=nil;
		buttons= [[NSMutableArray alloc] init];
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backToMain:)];
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		first=FALSE;
		//self.tableView.backgroundColor=[UIColor blackColor];
		//self.tableView.hidden=YES;
		//show buttons and stuff
		UIImage *dot;
		// loop through enemies, dropping pins
		dot = [UIImage imageNamed:@"cover.png"];
		CGRect dotFrame = CGRectMake(0, 0, dot.size.width, dot.size.height);
		self.navigationController.navigationBarHidden=YES;
		self.tableView.scrollEnabled=NO;
			dotView = [[UIImageView alloc] initWithFrame:dotFrame];
			dotView.center = CGPointMake(160, 240);
		dotView.image = dot;
			[self.view addSubview:dotView];
			//[dotView release];
			//dotView = nil;
		
		//create the button
		button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		//set the position of the button
		button.frame = CGRectMake(40, 410, 240, 40);
		//set the button's title
		[button setTitle:@"Check For Updates" forState:UIControlStateNormal];
		//listen for clicks
		[button addTarget:self action:@selector(buttonPressed)
		 forControlEvents:UIControlEventTouchUpInside];
		//add the button to the view
		//[self.view addSubview:button];
		[self performSelector:@selector(buttonPressed)];//update from server
		buttonTech=[UIButton buttonWithType:UIButtonTypeRoundedRect];
		buttonTech.frame=CGRectMake(40, 415, 240, 40);
		[buttonTech setTitle:@"Technical" forState:UIControlStateNormal];
		[buttonTech addTarget:self action:@selector(techPress)
			 forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:buttonTech];
		//create the button
		button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		//set the position of the button
		button2.frame = CGRectMake(40, 366, 240, 40);
		
		//set the button's title
		[button2 setTitle:@"Serial Lookup" forState:UIControlStateNormal];
		//listen for clicks
		[button2 addTarget:self action:@selector(buttonPressed2)
		 forControlEvents:UIControlEventTouchUpInside];
		//add the button to the view
		[self.view addSubview:button2];
		//3
		//create the button
		button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		//set the position of the button
		button3.frame = CGRectMake(40, 317, 240, 40);
		
		//set the button's title
		[button3 setTitle:@"Electronic Fork" forState:UIControlStateNormal];
		//listen for clicks
		//UIImage *fork=[UIImage imageNamed:@"Untitled-1.png"];
		//[button3 setImage:fork forState:UIControlStateNormal];
		[button3 addTarget:self action:@selector(buttonPressed3)
		  forControlEvents:UIControlEventTouchUpInside];
		//add the button to the view
		[self.view addSubview:button3];
		button6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		button6.frame = CGRectMake(40, 268, 240, 40);
		[button6 setTitle:@"Schematics" forState:UIControlStateNormal];
		[button6 addTarget:self action:@selector(buttonPressed6)
		  forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:button6];
		button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		//set the position of the button
		button4.frame = CGRectMake(40, 219, 240, 40);
		//set the button's title
		[button4 setTitle:@"Aural Aide" forState:UIControlStateNormal];
		//listen for clicks
		[button4 addTarget:self action:@selector(buttonPressed4)
		  forControlEvents:UIControlEventTouchUpInside];
		//add the button to the view
		[self.view addSubview:button4];
		//info button
		infoButt=[UIButton buttonWithType:UIButtonTypeInfoDark];
		[infoButt addTarget:self action:@selector(infoFlip)
		forControlEvents:UIControlEventTouchUpInside];
		[infoButt setCenter:CGPointMake(305, 15)];
		[self.view addSubview:infoButt];
		CurrentLevel=-1;
	}
	else if(CurrentLevel==0||CurrentLevel==2)
	{
			self.tableView.tableHeaderView=searchBar;
		CurrentLevel=0;
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
		NSString *documentsDirectoryPath = [paths objectAtIndex:0];
		NSString *path; 
		path=[documentsDirectoryPath  stringByAppendingPathComponent:@"manList.txt"];
		NSString *fileText = [NSString stringWithContentsOfFile:path];
		listOfItems = [[NSMutableArray alloc]
					   initWithArray:[fileText componentsSeparatedByString:@"\n"]
					   copyItems:YES];
		copyListOfItems = [[NSMutableArray alloc]
					   initWithArray:[fileText componentsSeparatedByString:@"\n"]
					   copyItems:YES];
		origListOfItems = [[NSMutableArray alloc]
						   initWithArray:[fileText componentsSeparatedByString:@"\n"]
						   copyItems:YES];
		for(int i=0;i<[listOfItems count];i++)
		{
			indexes2[i]=i;
		}
		self.navigationItem.title=@"Manufacturer";
	}
	else if(CurrentLevel==3)
	{
		self.navigationItem.title=CurrentTitle;
		NSString *toGive=[CurrentTitle stringByReplacingOccurrencesOfString:@"/" withString:@""];
		NSString *path = [[NSBundle mainBundle] pathForResource:toGive ofType:@"pdf"];
		NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
		UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		//[webView setCenter:CGPointMake(145, 215)];//change to move view
		//[webView setBounds:CGRectMake(145, 215, 355, 480)];
		//[webView setBounds:CGRectMake(160, 240, 320, 480)];
		//int width=[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"foo\").offsetHeight;"];
		//[webView setCenter:CGPointMake(width/2, 240)];//change to move view
		webView.scalesPageToFit = YES;
		[webView loadRequest:rq];
		//[webView setDelegate:self];
		//[webView setBackgroundColor:[UIColor clearColor]];
		//[webView setOpaque:NO];
		//[self.view addSubview:webView];
		self.tableView.scrollEnabled=NO;
		[self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
		//[self.view insertSubview:webView atIndex:0];
		[self.view addSubview:webView];
	}
	else
	{
		//CurrentLevel=1;
		self.navigationItem.title=CurrentTitle;
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
		NSString *documentsDirectoryPath = [paths objectAtIndex:0];
		NSString *path;// = [[NSBundle mainBundle] pathForResource:CurrentTitle ofType:@"txt"];  
		NSString *pathComp=[NSString stringWithFormat:@"%@.txt", CurrentTitle];
		path=[documentsDirectoryPath  stringByAppendingPathComponent:pathComp];
		//NSString *path = [[NSBundle mainBundle] pathForResource:CurrentTitle ofType:@"txt"];  
		NSString *fileText = [NSString stringWithContentsOfFile:path];
		listOfItems = [[NSMutableArray alloc]
					   initWithArray:[fileText componentsSeparatedByString:@"\n"]
					   copyItems:YES];
		copyListOfItems = [[NSMutableArray alloc]
						   initWithArray:[fileText componentsSeparatedByString:@"\n"]
						   copyItems:YES];
	}
	//search bar
	searchBar.autocorrectionType=UITextAutocorrectionTypeNo;
	searching=NO;
	letUserSelectRow=YES;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
	[self searchTableView];
	//also search ranges
}
-(void) searchTableView
{
	NSString *searchText=searchBar.text;
	int count=0;
	if(CurrentLevel==0)
	{
	for(int i=0;i<[origListOfItems count];i++)
	{
		//NSDictionary *dictionary =[self.tableDataSource objectAtIndex:i];
		NSString *check=[origListOfItems objectAtIndex:i];
		NSRange titleResultsRange=[check rangeOfString:searchText options:NSCaseInsensitiveSearch];
		if(titleResultsRange.length>0&&titleResultsRange.location == 0)
		{
			indexes2[count]=i;
			count++;
			[copyListOfItems addObject:check];
		}		
	}
	}
	else
	{
		for(int i=0;i<[listOfItems count];i++)
		{
		NSString *getFrom=[listOfItems objectAtIndex:i];
		NSMutableArray *temp = [[NSMutableArray alloc]
								initWithArray:[getFrom componentsSeparatedByString:@"-"]
								copyItems:YES];
		NSString *check=[temp objectAtIndex:1];
		//NSString *give=[temp objectAtIndex:0];
			NSString *give=getFrom;
		NSRange titleResultsRange=[check rangeOfString:searchText options:NSCaseInsensitiveSearch];
		if(titleResultsRange.length>0&&titleResultsRange.location == 0)
		{
			indexes[count]=i;
			count++;
			[copyListOfItems addObject:give];
		}
		else
		{//check for if the number is in the range
			int checkInt=[check intValue];
			int searchInt=[searchText intValue];
			if(i==[listOfItems count]-1)
			{//no future item
				while(searchInt<1000000000&&searchInt!=0)
				{
				if(searchInt>=checkInt)
				{//its the last year
					indexes[count]=i;
					count++;
					[copyListOfItems addObject:give];
					searchInt=2000000000;
				}
				else
				{//maybe if we add zeroes?
					searchInt*=10;
				}
				}
			}
			else
			{
				//int j=indexes[count];
				NSString *getFrom=[listOfItems objectAtIndex:i+1];
				NSMutableArray *temp = [[NSMutableArray alloc]
										initWithArray:[getFrom componentsSeparatedByString:@"-"]
										copyItems:YES];
				NSString *check2=[temp objectAtIndex:1];
				int nextInt=[check2 intValue];
				while(searchInt<1000000000&&searchInt!=0)
				{
				if(searchInt>=checkInt&&searchInt<nextInt)
				{//its in this range
					indexes[count]=i;
					count++;
					[copyListOfItems addObject:give];
					searchInt=2000000000;
				}
				else
				{//maybe if we add zeroes?
					searchInt*=10;
				}
				}
			}
		}
		[temp release];
		}
		//also search ranges
	}
}
-(void) searchTableView2
{
	NSString *searchText=searchBar.text;
	int count=0;
		for(int i=0;i<[listOfItems count];i++)
		{
			NSString *getFrom=[listOfItems objectAtIndex:i];
			NSMutableArray *temp = [[NSMutableArray alloc]
									initWithArray:[getFrom componentsSeparatedByString:@"-"]
									copyItems:YES];
			NSString *check=[temp objectAtIndex:1];
			//NSString *give=[temp objectAtIndex:0];
			NSString *give=getFrom;
			//NSRange titleResultsRange=[check rangeOfString:searchText options:NSCaseInsensitiveSearch];
			//if(titleResultsRange.length>0)
			{
				//indexes[count]=i;
				//count++;
				//[copyListOfItems addObject:give];
			}
			//else
			{//check for if the number is in the range
				int checkInt=[check intValue];
				int searchInt=[searchText intValue];
				if(i==[listOfItems count]-1)
				{//no future item
						if(searchInt>=checkInt)
						{//its the last year
							indexes[count]=i;
							count++;
							[copyListOfItems addObject:give];
						}
				}
				else
				{
					NSString *getFrom=[listOfItems objectAtIndex:i+1];
					NSMutableArray *temp = [[NSMutableArray alloc]
											initWithArray:[getFrom componentsSeparatedByString:@"-"]
											copyItems:YES];
					NSString *check2=[temp objectAtIndex:1];
					int nextInt=[check2 intValue];
						if(searchInt>=checkInt&&searchInt<nextInt)
						{//its in this range
							indexes[count]=i;
							count++;
							[copyListOfItems addObject:give];
						}
				}
			}
			[temp release];
		}
}

-(void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
	//remove all
	[copyListOfItems removeAllObjects];
	if(searchText.length>0)
	{
		searching=YES;
		letUserSelectRow=YES;
		self.tableView.scrollEnabled=YES;
		[self searchTableView];
	}
	else
	{
		searching=NO;
		self.tableView.scrollEnabled=NO;
		if(CurrentLevel==0)
		{
		for(int i=0;i<[listOfItems count];i++)
		{
			[copyListOfItems addObject:[listOfItems objectAtIndex:i]];
		}
		}
		else
		{
			for(int i=0;i<[listOfItems count];i++)
			{
				NSString *getFrom=[listOfItems objectAtIndex:i];
				NSMutableArray *temp = [[NSMutableArray alloc]
										initWithArray:[getFrom componentsSeparatedByString:@"-"]
										copyItems:YES];
				NSString *give=[temp objectAtIndex:0];
				[copyListOfItems addObject:give];
				[temp release];
			}
		}
	}
	[self.tableView reloadData];
}
-(void) doneSearching_Clicked:(id)sender
{
	if(CurrentLevel==0)
	{
	[searchBar resignFirstResponder];
	letUserSelectRow=YES;
	searching=NO;
	self.navigationItem.rightBarButtonItem=nil;
	self.tableView.scrollEnabled=YES;
	//[self searchTableView];
	//searchBar.text=@"";
	//[self.tableView reloadData];
	}
	else
	{
			[copyListOfItems removeAllObjects];
		//remove not in range ones
		[self searchTableView2];
		[self.tableView reloadData];
	}
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar
{
	searching=YES;
	//letUserSelectRow=NO;
	self.tableView.scrollEnabled=NO;
	//add the done button
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											  initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
											  target:self action:@selector(doneSearching_Clicked:)] autorelease];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(!clear)
	{
	if(CurrentLevel==0)
	{
		if(!searching)
		{
		return [origListOfItems count];
		}
		else
		{
			return [copyListOfItems count];
		}
	}
	else
	{
	if(!searching)
	{
		return [listOfItems count];
	}
	else
	{
		return [copyListOfItems count];
	}
	}
	}
	else {
		return 0;
	}

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		//[cell addSubview:[[UILabel alloc] initWithFrame:CGRectMake(40.0, 0.0, 280.0, ROW_HEIGHT - 1)]];
    }
    
	// Configure the cell.
	UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
	//theLabel.minimumFontSize = 5.0f;
	theLabel.numberOfLines = 2.0;
	theLabel.font = [UIFont systemFontOfSize:20];
	if(searching)
	{
		if(CurrentLevel==0)
		{
		NSString *giveLa=@" ";
		giveLa=[giveLa stringByAppendingString:[copyListOfItems objectAtIndex:indexPath.row]];
		theLabel.text=giveLa; //= cell.textLabel;
			cell.backgroundView = theLabel;
		}
		else
		{
					[cell.textLabel setText:[copyListOfItems objectAtIndex:indexPath.row]];
		}
	}
	else
	{
		if(CurrentLevel==0)
		{
			//[cell.textLabel setText:[origListOfItems objectAtIndex:indexPath.row]];
			NSString *giveLa=@" ";
			giveLa=[giveLa stringByAppendingString:[origListOfItems objectAtIndex:indexPath.row]];
			theLabel.text=giveLa; //= cell.textLabel;
				cell.backgroundView = theLabel;
		}
		else
		{//[fileText componentsSeparatedByString:@"\n"]
			NSString *getFrom=[listOfItems objectAtIndex:indexPath.row];
			/*
			NSMutableArray *temp = [[NSMutableArray alloc]
						   initWithArray:[getFrom componentsSeparatedByString:@"-"]
						   copyItems:YES];
			NSString *toGet=[temp objectAtIndex:0];
			[temp release];
			[cell.textLabel setText:toGet];
			 */
			[cell.textLabel setText:getFrom];
			//theLabel.text=getFrom;
			//NSString *giveLa=@" ";
			//giveLa=[giveLa stringByAppendingString:getFrom];
			//theLabel.text=giveLa; //= cell.textLabel;
		}
	}
    return cell;
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int i=indexes2[indexPath.row];
	[tableView  deselectRowAtIndexPath:indexPath  animated:YES]; 
	if(CurrentLevel==0)
	{
		NSString *compStr=@"Schematics";
		if([self.navigationItem.title isEqualToString:compStr])
		{//load schematics
			RootViewController *rvController=[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
			rvController.CurrentLevel=3;
			rvController.CurrentTitle=[origListOfItems objectAtIndex:i];
			[self.navigationController pushViewController:rvController animated:YES];
			//rvController.tableDataSource = Children;
			[rvController release];
		}
		else {
			RootViewController *rvController=[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
			rvController.CurrentLevel=1;
			rvController.CurrentTitle=[origListOfItems objectAtIndex:i];
			[self.navigationController pushViewController:rvController animated:YES];
			//rvController.tableDataSource = Children;
			[rvController release];
		}
	}
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

