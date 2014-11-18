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


@interface watchViewController ()<UICollectionViewDelegate, UICollectionViewDataSource//>
,UICollectionViewDelegateFlowLayout>

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
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_bwt.png"]];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
 
    
    
    // Configure layout
    //UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //[flowLayout setItemSize:CGSizeMake(150, 55)];
    //[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //[self.watchCollectionView setCollectionViewLayout:flowLayout];

    
    [self.watchCollectionView registerClass:[watchCellViewController class] forCellWithReuseIdentifier:@"watchCell"];
    
    
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
    
    watchCellViewController *cell = (watchCellViewController *)[collectionView dequeueReusableCellWithReuseIdentifier:@"watchCell" forIndexPath:indexPath];
    
   cell.cellLabel.frame=CGRectMake(12, 13, 76, 0);
    
    cell.cellLabel.text=watchArray[indexPath.section][indexPath.row];
    
    NSLog(@"cellValue at Section%d Row%d = %@",indexPath.section,indexPath.row, cell.cellLabel.text);
    
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setBorderColor:[UIColor blackColor].CGColor];
    
    
    cell.cellLabel.lineBreakMode=NSLineBreakByWordWrapping;
    //cell.cellLabel.preferredMaxLayoutWidth = CGRectGetWidth(collectionView.bounds);
    [cell.cellLabel  setNumberOfLines:0];
    
    //CGSize textSize=CGSizeMake(100, 100);
    
    //textSize = [watchArray[indexPath.section][indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    
    //[cell.cellLabel sizeThatFits:textSize];
    
    [cell.cellLabel sizeToFit];
    
    return cell;
}



#pragma mark – UICollectionViewDelegateFlowLayout

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSString *cellData = watchArray[indexPath.section][indexPath.row];
    
  //  return [watchArray[indexPath.section][indexPath.row] sizeWithAttributes:nil];
    
    return CGSizeMake(100, 100);
    
} */
    


@end
