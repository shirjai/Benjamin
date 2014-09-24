//
//  NotesDetailsViewController.m
//  bw3
//
//  Created by Sarang Kulkarni on 9/24/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "NotesDetailsViewController.h"

@interface NotesDetailsViewController ()

@end

@implementation NotesDetailsViewController

@synthesize notesScrollView,notesDetailTextView,notesDetailArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    notesDetailTextView.delegate = self;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEditNotes:)];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNotes:)];
    
}

-(IBAction)cancelEditNotes:(id)sender{
    UIAlertView *cancelAlert = [[UIAlertView alloc] initWithTitle:@"Unsaved Changes!!" message:@"Close Without Saving?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [cancelAlert show];
}


-(IBAction)saveNotes:(id)sender{
    if (notesDetailTextView.isFirstResponder) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNotes:)];
        [notesDetailTextView resignFirstResponder];
        return;
    }
    
    [self saveAddedNotes];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    NSMutableDictionary *newNote = [[NSMutableDictionary alloc] init];
    
    [newNote setValue:notesDetailTextView.text forKey:@"notesText"];
    [newNote setObject:[NSDate date] forKey:@"timeStamp"];
    
    if (notesDetailArray == nil) {
        notesDetailArray = [NSMutableArray alloc];
    }
    [notesDetailArray addObject:newNote];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    NSLog(@"Inside textviewediting");
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveNotes:)];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
