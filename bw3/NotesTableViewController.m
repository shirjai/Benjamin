//
//  NotesTableViewController.m
//  bw3
//
//  Created by Sarang Kulkarni on 9/23/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "NotesTableViewController.h"
#import "NotesDetailsViewController.h"

@interface NotesTableViewController ()

@end

@implementation NotesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.rightBarButtonItem = self.notesAddBtn;
    NSMutableArray *tmpArray = [[NSMutableArray alloc]  init];
    self.NotesRootArray = tmpArray;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.NotesRootArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NotesCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                                                            //forIndexPath:indexPath];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                                 
    }
    cell.textLabel.text = [[self.NotesRootArray objectAtIndex:indexPath.row] objectForKey:@"notesText"];
                             
    NSDateFormatter *DateFormat = [[NSDateFormatter alloc] init];
    [DateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    
    NSDate *NotesTimestamp = [[self.NotesRootArray objectAtIndex:indexPath.row] objectForKey:@"timeStamp"];
    
    cell.detailTextLabel.text = [DateFormat stringFromDate:NotesTimestamp];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    
    return cell;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	// important to reload data when view is redrawn
	[self.tableView reloadData];
}


- (IBAction)notesAddBtnPressed:(id)sender {
    NotesDetailsViewController *notesDetailsViewCtrl = [[NotesDetailsViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:notesDetailsViewCtrl];
    
    notesDetailsViewCtrl.notesDetailArray = self.NotesRootArray;
    [self presentViewController:navCtrl animated:YES completion:nil];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
