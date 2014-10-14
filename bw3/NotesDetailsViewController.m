//
//  NotesDetailsViewController.m
//  bw3
//
//  Created by Shirish Jaiswal on 9/24/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import "NotesDetailsViewController.h"
#import "NotesHandler.h"
#import "common.h"

@interface NotesDetailsViewController ()

@property (nonatomic, strong) NSString* notesText;

@end

@implementation NotesDetailsViewController



//@synthesize notesScrollView;
@synthesize notesDetailTextView,notesDetailArray,notesDetailDict,notesText;

#pragma mark - tableview delegate

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            // Custom initialization
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    self.notesDetailTextView = [[notesDetail alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:notesDetailTextView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [notesDetailTextView setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    notesDetailTextView.delegate = self;
    
    //notesScrollView.contentSize = self.view.frame.size;

    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEditNotes:)];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNotes:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self registerForKeyboardNotifications];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    
	if(self.notesDetailDict != nil){
		notesDetailTextView.text = [notesDetailDict objectForKey:@"NotesVal"];
        
	}
    // to display the text if it is greater than the UITextview size
    //notesScrollView.frame = self.view.frame;
    notesDetailTextView.frame = self.view.frame;
    
    //set the title for the detailed text view with size limited till first new line character
    //NSString *note = [common getSubstring:notesDetailTextView.text defineStartChar:@"" defineEndChar:@"\n"];
    //self.navigationItem.title = note;
        

}


-(void)viewWillDisappear:(BOOL)animated{
    
	[super viewWillDisappear:animated];
    
    if (self.navigationItem.rightBarButtonItem.enabled == YES) {
        if (![notesDetailTextView.text isEqualToString:notesText] && notesText != nil) {
            [self saveAddedNotes];
        }
    }
    
        
	
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    
     NSLog(@"Inside textViewDidChangeSelection");
    
}


/*- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"Inside textviewediting :%@:",text);
    if ([text length] == 0) {
        return NO;
    }
    else
        return YES;
    
} */

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    NSLog(@"Inside textviewediting");
    notesText = notesDetailTextView.text;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveNotes:)];
    return YES;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSLog(@" inside willShowViewController");
    
}

-(void)textViewDidChange:(NSNotification *)notification{
    
}

-(void)viewDidLayoutSubviews{
   [super viewDidLayoutSubviews];
    //[self.notesScrollView layoutIfNeeded];
    //self.notesScrollView.contentSize = self.notesDetailTextView.bounds.size;
}

- (void)registerForKeyboardNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:)
												 name: UIKeyboardDidHideNotification object:nil];
}

-(void) keyboardDidShow: (NSNotification *)notif{

    //get keyboard size
    NSDictionary *info = [notif userInfo];
    NSValue *value  = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];//UIKeyboardFrameEndUserInfoKey
    CGSize keyboardSize = [value CGRectValue].size;
    
   // UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    //notesScrollView.contentInset = contentInsets;
    
    CGRect viewFrame = self.view.frame;
	viewFrame.size.height -= (keyboardSize.height);
    //resize the scroll view
   // if (CGRectContainsPoint(viewFrame, notesDetailTextView.frame.origin)) {
     //   [self.notesScrollView scrollRectToVisible:notesDetailTextView.frame animated:YES];
   // }
	//notesScrollView.frame = viewFrame;
    notesDetailTextView.frame = viewFrame;
    
 
}


-(void) keyboardDidHide: (NSNotification *)notif{
    
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	CGRect viewFrame = self.view.frame;
	viewFrame.size.height += keyboardSize.height;
	//notesScrollView.frame = viewFrame;
    notesDetailTextView.frame = viewFrame;
	
	//if (!keyboardVisible) {
		//NSLog(@"Keyboard is already hidden. Ignoring notification.");
	//	return;
	//}
    
    
}

#pragma mark - Benjamin custom methods

-(IBAction)cancelEditNotes:(id)sender{
    UIAlertView *cancelAlert = [[UIAlertView alloc] initWithTitle:@"Unsaved Changes!!" message:@"Close Without Saving?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [cancelAlert show];
}


-(IBAction)saveNotes:(id)sender{
    
    NSLog(@"notesDetailTextView.text:%@",notesDetailTextView.text);
    if (![notesDetailTextView.text isEqualToString:notesText] && notesText != nil) {
        [self saveAddedNotes];
    }
    
    if (notesDetailTextView.isFirstResponder) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNotes:)];
        [notesDetailTextView resignFirstResponder];
        //return;
    }
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //[self dismissViewControllerAnimated:YES completion:nil];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"Return to Editing Notes");
    }
    else{
         [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)saveAddedNotes{
    
    NSDateFormatter *DateFormat = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [DateFormat setLocale:posix];
    
    [DateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *dateString = [DateFormat stringFromDate:[NSDate date]];
     //[DateFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSMutableDictionary *newNote = [[NSMutableDictionary alloc] init];
    
    if (!notesDetailDict) {
        [newNote setValue:@"-1" forKey:@"RowId"];
    }
    else{
        [newNote setValue:[notesDetailDict objectForKey:@"RowId"]  forKey:@"RowId"];
    }
    [newNote setValue:notesDetailTextView.text forKey:@"NotesVal"];
    [newNote setObject:dateString forKey:@"NotesTimestamp"];
    
    if (notesDetailArray == nil) {
        notesDetailArray = [NSMutableArray alloc];
    }
    
    // to update an existing note,remove and then add 
    if(self.notesDetailDict != nil){
		[notesDetailArray removeObject:notesDetailDict];
		//self.notesDetailArray = nil; //This will release our reference too
		
	}
    
    [notesDetailArray addObject:newNote];
    
    //sort notes
	NSSortDescriptor *notesSorter = [[NSSortDescriptor alloc] initWithKey:@"NotesTimestamp" ascending:NO selector:@selector(compare:)];
	[notesDetailArray sortUsingDescriptors:[NSArray arrayWithObject:notesSorter]];
    
    //submit notes to the server    
    [NotesHandler submitNotes:newNote];
    
    //set the title for new note or modify the title if changed
    NSString *currentNoteTitle = self.navigationItem.title;
 //   NSString *newNoteTitle = [common getSubstring:notesDetailTextView.text defineStartChar:@"" defineEndChar:@"\n"];
 //   if (![currentNoteTitle isEqualToString:newNoteTitle]) {
//        self.navigationItem.title = newNoteTitle;

 //   }
    notesDetailTextView.delegate = self;
}




	

@end
