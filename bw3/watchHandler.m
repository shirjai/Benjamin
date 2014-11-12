//
//  watchHandler.m
//  bw3
//
//  Created by Sarang Kulkarni on 11/7/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "watchHandler.h"
#import "watchViewController.h"
#import "AppDelegate.h"
#import "LinkImport.h"
#import "common.h"

@implementation watchHandler

-(void)loadBenjaminWatch:(MainVC *) mainVCObj{
    
    //get notes properties
    //NSDictionary *propDict = [NotesHandler loadValuesfromProperties];
    
    //assign notes properties
    NSInteger *intWatchTagValId =  2000284;//[[propDict objectForKey:@"tableId"] integerValue];
    NSString *rowColName = @"RowId";//[propDict objectForKey:@"rowIdKey"];;
    NSString *strTagColName = @"Tag Name";//[propDict objectForKey:@"timeColName"];
    NSString *strValColName = @"Value";// valCol = [propDict objectForKey:@"valueColName"];
    NSString *strTimeColName = @"Timestamp";// valCol = [propDict objectForKey:@"valueColName"];
    
    LinkImport *linkImportWatch = [LinkImport alloc];
    
    //link import notes cuboid
    Cuboid *cuboidTagVal = [linkImportWatch LinkImportApi:intWatchTagValId];
    
    int TagValTableId = [cuboidTagVal GetTableId];
    if ( TagValTableId != 0)
    {
        NSLog(@"Data returned from server");
        
        NSMutableArray *mutarrRowTagVal =[cuboidTagVal GetRow];
        NSMutableArray *mutarrTagVal = [[NSMutableArray alloc] init];
        NSArray *arrSelColNames = [NSArray arrayWithObjects: strTagColName, strValColName, strTimeColName, nil];
        
        //re-arrange data in notes format and get it in an array
        mutarrTagVal = [common prepareDataFromBuffer:mutarrRowTagVal ColNames:arrSelColNames RowIdCol:rowColName];
  
    
        watchViewController  *watchVC = [[watchViewController alloc] initWithNibName:nil bundle:nil];
        
        NSMutableArray *watchRowArray = [[NSMutableArray alloc]init];
        
        // add header
        [watchRowArray addObject:arrSelColNames];
        
      /*  NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex:0];
        for (int i=1; i<[arrSelColNames count]; i++) {
            [indexes addIndex:i];
        }
        [watchArray insertObjects:arrSelColNames atIndexes:indexes]; */
        
        // add data
        
        NSPredicate *predicate = nil;
        NSString *col1 = nil;
        NSString *col2 = nil;
        NSString *col3 = nil;
        
        for(NSMutableDictionary *mutdictRow in mutarrTagVal)
        {
            NSMutableArray *arrRow = [[NSMutableArray alloc] init];
            for (NSString *key in mutdictRow)
            {
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strTagColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                     col1 = [mutdictRow valueForKey:key];
 
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strValColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col2 = [mutdictRow valueForKey:key];

                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", strTimeColName, key];
                if([predicate evaluateWithObject:mutdictRow])
                    col3 = [mutdictRow valueForKey:key];
            }
            
            [arrRow addObject:col1];
            [arrRow addObject:col2];
            [arrRow addObject:col3];
            [watchRowArray addObject:arrRow];
        }
        

        watchVC.watchArray   = [[NSMutableArray alloc]init];
    
       [[watchVC watchArray] addObjectsFromArray:watchRowArray];
        
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
        UINavigationController *watchNavCtrl = [[UINavigationController alloc] initWithRootViewController:watchVC];
        
        [watchNavCtrl setViewControllers:[NSArray arrayWithObject:mainVCObj]];
    
    
        appDelegate.window.rootViewController = watchNavCtrl;
    
        [appDelegate.window makeKeyAndVisible];
    
        NSLog(@"%@",mainVCObj.navigationController);
        
        [mainVCObj.navigationController pushViewController:watchVC animated:YES];
        
        NSLog(@"%@",mainVCObj.navigationController);
  
    }
    else{
        NSLog(@"No data returned from server");
    }
}

@end
