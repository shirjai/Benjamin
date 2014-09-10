//
//  AppDelegate.h
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <UIKit/UIKit.h>

// added by shirish 8/13
#import "MainVC.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

// added by shirish 8/13
@property(strong, nonatomic) MainVC *mainView;
@property(strong, nonatomic) UINavigationController *navCMsgs;

@end
