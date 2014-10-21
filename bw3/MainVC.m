//
//  MainVC.m
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "MainVC.h"
#import "Database.h"
#import "LinkImport.h"

#import "AppDelegate.h"

/******** added by shirish 9/23/14 starts *******/
#import "viewMsgs.h"
#import "NotesHandler.h"

/******** added by shirish 9/23/14 ends *******/

////temp
//#import "NotesTableViewController.h"

@interface MainVC ()

@end

@implementation MainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.title = @"Dashboard";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // added by shirish 9/9/14
    CALayer *btnLayer = [_btnMsgs layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
     btnLayer = [_btnNotes layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
}

// to hide the navigation bar added by shirish starts - 8/19/2014
-(void)viewWillAppear:(BOOL)animated{
   
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
// to hide the navigation bar added by shirish ends - 8/19/2014

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Wb:(id)sender {
    
   //get the right table id
    NSInteger *TblId = 2000248;
    LinkImport *LI = [LinkImport alloc];
    [LI LinkImportApi:TblId];    
    
}

// calling action on Messages - Shirish jaiswal 7/8/2014


- (IBAction)msgs:(id)sender {
    
    //int imsgId = 2000273;
    NSInteger *IntMsgId = 2000281;//2000277;

    
    LinkImport *linkImportMsg = [LinkImport alloc];
    Cuboid *cubMsg = [[Cuboid alloc] init];
    cubMsg = [linkImportMsg LinkImportApi:IntMsgId];
    
    viewMsgs *viewMsgsObj = [[viewMsgs alloc] initWithNibName:nil bundle:nil];
    viewMsgsObj.msgCubId = IntMsgId;
    
    
    if ([cubMsg GetTableId]!= 0)
    {
        NSLog(@"Data returned from server");
        

        NSMutableArray *rowArray =[cubMsg GetRow];
        NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
        cubmsgs = [viewMsgsObj loadMessages:rowArray :@"linkImport"];
        
        // msgs.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        //[self presentViewController:msgs animated:YES completion:nil];
        
        
        //UINavigationController *navCMsgs = [[UINavigationController alloc] init];

        
        UINavigationController *navCMsgs = [[UINavigationController alloc] initWithRootViewController:viewMsgsObj];

        [navCMsgs setViewControllers:[NSArray arrayWithObject:self]];
        

        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        appDelegate.window.rootViewController = navCMsgs;
        
        NSLog(@"%@",self.navigationController);
        
        [self.navigationController pushViewController:viewMsgsObj animated:YES];
        
        NSLog(@"%@",self.navigationController);
        
        viewMsgsObj.msgs   = [[NSMutableArray alloc]init];
        [[viewMsgsObj msgs] addObjectsFromArray:cubmsgs];
        
        //    [viewtest msgs] = [cubmsgs mutableCopy];
        
        //    [[viewtest msgs]:cubmsgs,nil] ;
        
        
        //[viewtest msgs] = cubmsgs;
        
        
    }
    else{
        NSLog(@"No data returned from server");
    }
    
}

- (IBAction)notes:(id)sender {
   

    NotesHandler *notesHandlerObj = [[NotesHandler alloc] init];
    
    //[self.navigationController setViewControllers:[NSArray arrayWithObject:self]];
    
    // send the mainVC obj to the noteshandler to launch notes module
    [notesHandlerObj loadBenjaminNotes:self];

}
  
@end