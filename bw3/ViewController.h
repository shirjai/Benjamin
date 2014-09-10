//
//  ViewController.h
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UITextField *usertext;
@property (weak, nonatomic) IBOutlet UITextField *passtext;
- (IBAction)SignInbutton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *msgLogin;

@end
