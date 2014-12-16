//
//  MissingUpdatesVC.m
//  bw4
//
//  Created by Srinivas on 10/23/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "MissingUpdatesVC.h"
#import "MissingUpdates.h"

@interface MissingUpdatesVC ()

@end

@implementation MissingUpdatesVC

@synthesize CuboidName = _CuboidName;
@synthesize TableID = _TableID;
@synthesize TblId = _TblId;
@synthesize MsingUpd = _MsingUpd;

@synthesize lstImAt = _lstImAt;
@synthesize LstImId = _LstImId;

@synthesize LstUpdAt = _LstUpdAt;
@synthesize LstUpdId = _LstUpdId;
@synthesize LstUpdOn = _LstUpdOn;

@synthesize LstExAt = _LstExAt;
@synthesize LstExId = _LstExId;

@synthesize Cmnt = _Cmnt;

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
	// Do any additional setup after loading the view.
    MissingUpdates *MU = [[MissingUpdates alloc] init];
    NSArray *MUArr = [MU GetArrayAllUpdates:self.TableID];
    if([MUArr count] > 10)
    {
        self.TblId.text = [NSString stringWithFormat:@"TableId : %@",[MUArr objectAtIndex:0]];
        self.CuboidName.text = [NSString stringWithFormat:@"%@",[MUArr objectAtIndex:1]];
        self.MsingUpd.text = [NSString stringWithFormat:@"Number of Updates Missing : %@",[MUArr objectAtIndex:7]];
        
        self.LstUpdOn.text = [NSString stringWithFormat:@"Created On      : %@",[MUArr objectAtIndex:5]];
        self.LstUpdId.text = [NSString stringWithFormat:@"Transaction Id  : %@",[MUArr objectAtIndex:3]];
        self.LstUpdAt.text = [NSString stringWithFormat:@"Created By      : %@",[MUArr objectAtIndex:4]];
        self.Cmnt.text =     [NSString stringWithFormat:@"Comment         : %@",[MUArr objectAtIndex:6]];
        
        self.LstImId.text = [NSString stringWithFormat:@"Transaction Id  : %@",[MUArr objectAtIndex:8]];
        self.lstImAt.text = [NSString stringWithFormat:@"Created On      : %@",[MUArr objectAtIndex:9]];
        
        self.LstExId.text = [NSString stringWithFormat:@"Transaction Id  : %@",[MUArr objectAtIndex:10]];
        self.LstExAt.text = [NSString stringWithFormat:@"Created On      : %@",[MUArr objectAtIndex:11]];
        
    }
    else
    {
        self.TblId.text = [NSString stringWithFormat:@"TableId : %@",[MUArr objectAtIndex:0]];
        self.MsingUpd.text = [NSString stringWithFormat:@"Number of Updates Missing : 0"];
        
    }
    
    self.navigationItem.title = @"Missing Updates";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
