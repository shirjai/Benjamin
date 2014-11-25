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

#import "LinkImport.h"
#import "Refresh.h"
#import "common.h"

@interface watchViewController ()<UICollectionViewDelegate, UICollectionViewDataSource//>
,UICollectionViewDelegateFlowLayout>
{
    UIRefreshControl *refreshControlObj;
}

@property (strong, nonatomic) IBOutlet UICollectionView *watchCollectionView;

@property (strong, nonatomic) IBOutlet watchCellViewLayout *cellViewLayout;


@end

@implementation watchViewController

@synthesize watchArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Watch";

    }
    return self;
}


- (void)viewDidLoad
{
    
  //  [self.watchCollectionView setCollectionViewLayout:[[watchCellViewLayout alloc]init]];
    
    [super viewDidLoad];
    
    refreshControlObj = [[UIRefreshControl alloc]init];
    [refreshControlObj addTarget:self action:@selector(refreshWatch) forControlEvents:UIControlEventValueChanged];
    [self.watchCollectionView addSubview:refreshControlObj];
    
    [self.watchCollectionView registerClass:[watchCellViewController class] forCellWithReuseIdentifier:@"watchCell"];
    
    [self.watchCollectionView reloadData];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_bwt.png"]];
 
   /// self.watchCollectionView.collectionViewLayout = [[watchCellViewLayout alloc] init];
    
    // Configure layout
    //UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //[flowLayout setItemSize:CGSizeMake(150, 55)];
    //[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //[self.watchCollectionView setCollectionViewLayout:flowLayout];


    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
	// important to reload data when view is redrawn
    [self.watchCollectionView reloadItemsAtIndexPaths:[self.watchCollectionView indexPathsForVisibleItems]];
	[self.watchCollectionView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Collection View Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //NSLog(@"numberOfSectionsInCollectionView:%d",[watchArray count]);
    return [watchArray count];
    //return 30;//[watchArray count];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"[watchArray[section] count]:%d",[watchArray[section] count]);
    return [watchArray[section] count];
    //return 3;//[watchMasterArray count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    watchCellViewController *cell = (watchCellViewController *)[collectionView dequeueReusableCellWithReuseIdentifier:@"watchCell" forIndexPath:indexPath];
    
   cell.cellLabel.frame=CGRectMake(12, 13, 98, 0);
    
    cell.cellLabel.text=watchArray[indexPath.section][indexPath.row];
    
    //NSLog(@"cellValue at Section%d Row%d = %@",indexPath.section,indexPath.row, cell.cellLabel.text);
    
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    cell.cellLabel.backgroundColor = [UIColor clearColor];
    
    cell.cellLabel.lineBreakMode=NSLineBreakByWordWrapping;
    //cell.cellLabel.preferredMaxLayoutWidth = CGRectGetWidth(collectionView.bounds);
    [cell.cellLabel  setNumberOfLines:0];
    
    //CGSize textSize=CGSizeMake(100, 100);
    
    //textSize = [watchArray[indexPath.section][indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    
    //[cell.cellLabel sizeThatFits:textSize];
    
    [cell.cellLabel sizeToFit];
    
    return cell;
}

-(void)refreshWatch
{

    Refresh *refreshObj = [[Refresh alloc]init];
    Cuboid *cubMsg = [[Cuboid alloc] init];
    int intMsgCuboidId = 2000284 ; //(int)_msgCubId;
    cubMsg = [refreshObj RefreshAPI:intMsgCuboidId:1];
    
    
    
    NSLog(@"Inside Refresh Watch -Tag Value cuboid");
    
    if (cubMsg != Nil)
    {
        NSLog(@"Data returned from server");
        
        NSMutableArray *mutarrNewRows =[cubMsg GetRow];
        //NSMutableArray *cubmsgs = [[NSMutableArray alloc] init];
        
        NSArray *arrSelColNames = [NSArray arrayWithObjects: @"Tag Name", @"Value", @"Timestamp", nil];
        
        //re-arrange data in watch format and get it in an array
        mutarrNewRows = [common prepareDataFromBuffer:mutarrNewRows ColNames:arrSelColNames RowIdCol:@"RowId"];

        NSMutableArray *watchRowArray = [[NSMutableArray alloc]init];
        
        // add data
        
        NSPredicate *predicate = nil;
        NSString *col1 = nil;
        NSString *col2 = nil;
        NSString *col3 = nil;
        
        for(NSMutableDictionary *mutdictRow in mutarrNewRows)
        {
            NSMutableArray *arrRow = [[NSMutableArray alloc] init];
            for (NSString *key in mutdictRow)
            {
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", @"Tag Name", key];
                if([predicate evaluateWithObject:mutdictRow])
                    col1 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", @"Value", key];
                if([predicate evaluateWithObject:mutdictRow])
                    col2 = [mutdictRow valueForKey:key];
                
                predicate = [NSPredicate predicateWithFormat:@"(%@ == %@)", @"Timestamp", key];
                if([predicate evaluateWithObject:mutdictRow])
                {
                    col3 = [mutdictRow valueForKey:key];
                    col3 = [common dateFromExcelSerialDate:[col3 doubleValue]];
                }
            }
            
            [arrRow addObject:col1];
            [arrRow addObject:col2];
            [arrRow addObject:col3];
            [watchRowArray addObject:arrRow];
        }
    
        if ([watchRowArray count])
        {
            [watchArray addObjectsFromArray:watchRowArray];
            
     /*       NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            NSIndexPath *indexPath = [[NSIndexPath alloc]init];
            
            for (int i=0; i<[watchRowArray count]; i++) {
                indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [indexPaths addObject:indexPath];
            }
            

            [self   beginUpdates];
            [self.watchCollectionView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
            [self.watchCollectionView endUpdates]; */
            
        }
        else{
            NSLog(@"No changes from the cloud");
        }
        [self.watchCollectionView reloadData];
        [refreshControlObj endRefreshing];
        
    }
    else{
        NSLog(@"Error in refreshing Tag Value Watch cuboid");
    }
    
}

#pragma mark – UICollectionViewDelegateFlowLayout

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSString *cellData = watchArray[indexPath.section][indexPath.row];
    
  //  return [watchArray[indexPath.section][indexPath.row] sizeWithAttributes:nil];
    
    return CGSizeMake(100, 100);
    
} */
    


@end
