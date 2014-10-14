//
//  NotesHandler.m
//  bw3
//
//  Created by Sarang Kulkarni on 10/14/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "NotesHandler.h"

#import "Cuboid.h"
#import "LinkImport.h"
#import "NotesTableViewController.h"
#import "AppDelegate.h"
#import "Submit.h"

@implementation NotesHandler


-(void)loadBenjaminNotes:(NSInteger *)IntNotesId :(MainVC *) mainVCObj{


    LinkImport *linkImportNotes = [LinkImport alloc];
    Cuboid *cuboidNotes = [[Cuboid alloc] init];
    cuboidNotes = [linkImportNotes LinkImportApi:IntNotesId];

    if ([cuboidNotes GetTableId] != 0)
    {
        NSLog(@"Data returned from server");
    
        NSMutableArray *notesRowArray =[cuboidNotes GetRow];
        NSMutableArray *notesArray = [[NSMutableArray alloc] init];
        notesArray = [self loadNotesDataFromBuffer:notesRowArray];
    
        //sort notes in desc of timestamp
        NSSortDescriptor *notesSorter = [[NSSortDescriptor alloc] initWithKey:@"NotesTimestamp" ascending:NO selector:@selector(compare:)];
        [notesArray sortUsingDescriptors:[NSArray arrayWithObject:notesSorter]];
    
        NotesTableViewController  *ntvc = [[NotesTableViewController alloc] initWithNibName:nil bundle:nil];
    
        ntvc.NotesRootArray   = [[NSMutableArray alloc]init];
    //ntvc.NotesRootArray = notesArray;
        [[ntvc NotesRootArray] addObjectsFromArray:notesArray];
    
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
        UINavigationController *navCMsgs = [[UINavigationController alloc] initWithRootViewController:ntvc];
    
        [navCMsgs setViewControllers:[NSArray arrayWithObject:mainVCObj]];
    
        appDelegate.window.rootViewController = navCMsgs;
    
        NSLog(@"%@",mainVCObj.navigationController);
    
        [mainVCObj.navigationController pushViewController:ntvc animated:YES];
    
        NSLog(@"%@",mainVCObj.navigationController);
    }
    else{
        NSLog(@"No data returned from server");
    }
}

-(NSMutableArray *)loadNotesDataFromBuffer:(NSMutableArray *)notesRowArray{
    
    NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
    NSLog(@"Inside loadMessages");
    if (![notesRowArray count]) {
        
        NSLog(@"No changes or new rows from the server");
        
    }
    else{
        NSString *strColName = nil;
        NSString *strColVal = nil;
        Row *eachRow = nil;
        int irowCnt = 0;
        
        //for (Row *eachRow in msgRowArray)
        for ( irowCnt = irowCnt;  irowCnt < [notesRowArray count];irowCnt++)
        {
            eachRow = notesRowArray[irowCnt];
            NSLog(@"eachRow:%@",eachRow);
            NSLog(@"Rowid:%d",[eachRow RowId]);
            
            NSMutableDictionary *dictmsgs = [[NSMutableDictionary alloc] init];
            
            for (int i=0; i <[[eachRow ColName] count];i++)
            {
                
                strColName = [[eachRow ColName] objectAtIndex:i];
                strColVal = [[eachRow Value] objectAtIndex:i];
                NSLog(@"colname:%@",strColName);
                NSLog(@"colvalue:%@",strColVal);

                if ([strColName isEqualToString:@"NotesTimestamp"])
                {
                    [dictmsgs setObject:strColVal forKey:@"NotesTimestamp"];
                }
                if ([strColName isEqualToString:@"NotesVal"])
                {
                    [dictmsgs setObject:strColVal forKey:@"NotesVal"];
                    
                }

            }
            //[cubmsgs addObject:msgElement];
            [cubmsgs addObject:dictmsgs];
        }
    }
    return cubmsgs;
    
}

+(void)submitNotes:(NSArray *)newNote{
    
}
@end
