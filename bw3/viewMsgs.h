//
//  viewMsgs.h
//  bw3
//
//  Created by Shirish Jaiswal on 7/18/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface viewMsgs : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *msgs;
    
}

@property (nonatomic,retain) NSMutableArray *msgs;
@property (nonatomic) NSInteger *msgCubId;

-(NSMutableArray *)loadMessages:(NSMutableArray *)msgRowArray :(NSString *)action;

//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) IBOutlet UITableView *msgsTableView;


/**old
 {
 NSArray *colorNames;
 }
 
 */
// /**old**/ @property (nonatomic, retain) NSArray *colorNames;

@end

