//
//  ViewController.m
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "ViewController.h"
#import "UserLogin.h"
#import "MainVC.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.usertext.delegate = self;
    self.passtext.delegate = self;
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0,-10,320,400);
    [UIView commitAnimations];
    
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignInbutton:(id)sender {
    
    UserLogin *UL = [UserLogin alloc];
    NSString *loginResult = [NSString alloc];
    loginResult = [UL authenticateuser:self.usertext.text :self.passtext.text];
    
    
    if([loginResult isEqualToString: @"Success"])
    {
        [self.msgLogin setHidden:YES];
        MainVC *MVC = [[MainVC alloc]init];
        [self presentViewController:MVC animated:YES completion:nil];

    }
    else
    {
        [self.msgLogin setHidden:NO];
        [self.usertext setText:@""];
        [self.passtext setText:@""];
    }
    

}

@end
