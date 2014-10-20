//
//  common.m
//  bw3
//
//  Created by Shirish Jaiswal on 10/14/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import "common.h"
#import <QuartzCore/QuartzCore.h>

@implementation common


/*available transitions
 
 kCATransitionFade,kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, @"cameraIris", @"cameraIrisHollowOpen", @"cameraIrisHollowClose", @"cube", @"alignedCube", @"flip", @"alignedFlip", @"oglFlip", @"rotate", @"pageCurl"
    @"pageUnCurl", @"rippleEffect", @"suckEffect"
 */

+(CATransition *)getViewTransistionStylePageCurl{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = @"pageUnCurl";//kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    return transition;
}



// returns a substring from start char to end char
// if start char not defined, take the first char of the string
// if end char note defined, consider the end of the string

+(NSString *)getSubstring:(NSString *)stringParam defineStartChar:(NSString *)start defineEndChar:(NSString *)end{
    
    NSString *subString = nil;
    NSRange startRange = [stringParam rangeOfString:start];
    if (startRange.location != NSNotFound)
    {
        subString = [stringParam substringFromIndex:startRange.location];
    }
    else{
        subString = [stringParam substringFromIndex:0];
    }
    
    NSRange endRange = [stringParam rangeOfString:end];
    if (endRange.location != NSNotFound)
    {
        subString = [stringParam substringToIndex:endRange.location];
    }
    else{
        subString = [stringParam substringToIndex:stringParam.length];
    }
    return subString;
}

@end
