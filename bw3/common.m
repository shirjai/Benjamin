//
//  common.m
//  bw3
//
//  Created by Sarang Kulkarni on 10/14/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "common.h"
#import <QuartzCore/QuartzCore.h>

@implementation common

+(CATransition *)getViewTransistionStylePageCurl{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = @"pageUnCurl";//kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    return transition;
}

@end
