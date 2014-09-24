//
//  NotesDetailsViewController.h
//  bw3
//
//  Created by Sarang Kulkarni on 9/24/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesDetailsViewController : UIViewController{
    
    IBOutlet UIScrollView *notesScrollView;
    IBOutlet UITextView *notesDetailTextView;
    NSMutableArray *notesDetailArray;
    
}

@property(nonatomic, strong) UIScrollView *notesScrollView;
@property(nonatomic,strong) UITextView *notesDetailTextView;
@property(nonatomic, strong) NSMutableArray *notesDetailArray;

@end
