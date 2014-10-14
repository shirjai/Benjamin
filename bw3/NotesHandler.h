//
//  NotesHandler.h
//  bw3
//
//  Created by Sarang Kulkarni on 10/14/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainVC.h"

@interface NotesHandler : NSObject

-(void)loadBenjaminNotes : (NSInteger *)IntNotesId: (MainVC *) mainVCObj;
+(void)submitNotes:(NSArray *)newNote;

@end
