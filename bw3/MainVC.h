//
//  MainVC.h
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

// added by shirsish 9/9/14
#import <QuartzCore/QuartzCore.h>

@interface MainVC : UIViewController

- (IBAction)Wb:(id)sender;
- (IBAction)msgs:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnMsgs;
@property (strong, nonatomic) IBOutlet UIButton *btnNotes;

@end
