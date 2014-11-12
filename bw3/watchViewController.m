//
//  watchViewController.m
//  collectionViewStudy
//
//  Created by Sarang Kulkarni on 10/31/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import "watchViewController.h"

// import the custom cell
#import "watchCellViewController.h"

// import the custom layout
#import "watchCellViewLayout.h"

@interface watchViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *watchCollectionView;

@property (strong, nonatomic) IBOutlet watchCellViewLayout *cellViewLayout;


@end

@implementation watchViewController

@synthesize watchArray;

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
    
 /*
    watchArray = [[NSMutableArray alloc]init];
    
    watchArray = @[@[@"cell  1",@"cell 2 ",@"cell3  "],
                   @[@"cell14",@"cell15",@"cell16"],
                   @[@"cell17",@"cell18",@"cell19"],
                   @[@"cell20",@"cell21",@"cell22"],
                   @[@"cell23",@"cell24",@"cell25"],
                   @[@"cell26",@"",@""]];
    
   [watchArray addObject:@"cell11"];
    [watchArray addObject:@"cell12"];
    [watchArray addObject:@"cell13"];
    
    [watchArray addObject:@"cell14"];
    [watchArray addObject:@"cell15"];
    [watchArray addObject:@"cell16"];

    [watchArray addObject:@"cell17"];
    [watchArray addObject:@"cell18"];
    [watchArray addObject:@"cell19"];
    
    [watchArray addObject:@"cell20"];
    [watchArray addObject:@"cell21"];
    [watchArray addObject:@"cell22"];
    
    [watchArray addObject:@"cell23"]; */
    
    
    // Do any additional setup after loading the view from its nib.
    
    [self.watchCollectionView registerClass:[watchCellViewController class] forCellWithReuseIdentifier:@"watchCell"];
    
    
    // Configure layout
 /*   UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(200, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.watchCollectionView setCollectionViewLayout:flowLayout];
  */
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    //[[self navigationController] setNavigationBarHidden:NO animated:NO];
	// important to reload data when view is redrawn
    [self.watchCollectionView reloadItemsAtIndexPaths:[self.watchCollectionView indexPathsForVisibleItems]];
	[self.watchCollectionView reloadData];
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Collection View Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [watchArray count];
    //return 30;//[watchArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"[watchArray[section] count]:%d",[watchArray[section] count]);
    return [watchArray[section] count];
    //return 3;//[watchMasterArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //UILabel *label = (UILabel *)[cell viewWithTag:100];
    //NSArray *dataArray = [watchMasterArray objectAtIndex:indexPath.section];
    
    
     watchCellViewController *cell = (watchCellViewController *)[collectionView dequeueReusableCellWithReuseIdentifier:@"watchCell" forIndexPath:indexPath];
    
    NSLog(@"indexPath.section->%d",indexPath.section);
    
   // if (indexPath.section < [watchArray count]) {
    NSLog(@"cellValue at Row %d",indexPath.row);
    //[cell.cellLabel  setText:[watchArray objectAtIndex:indexPath.section]];
    
    
    cell.cellLabel.text=watchArray[indexPath.section][indexPath.row];
    //[cell.cellLabel  setText:[NSString stringWithFormat:@"%d%d",indexPath.section, indexPath.row]];
   //[cell.cellLabel  setText:[NSString stringWithFormat:@"%d",indexPath.section]];
   // }
    
    
   // [cell.layer setBorderWidth:2.0f];
   // [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
   
    
    
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout













@end
