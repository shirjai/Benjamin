//
//  Http.m
//  bw3
//
//  Created by Ashish on 4/29/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Http.h"
#import "utilities.h"


@implementation Http{
    NSMutableData *responseData ;
   
}

-(NSString *)callBoardwalk:(NSString *)buffer:(NSString *) requestType
{
    //httpt_vb_Login
    NSString *inputbuff = [NSString stringWithFormat:@"t%@",buffer];
    utilities *utl = [utilities alloc];
    NSString *reqbuff = [utl PrepareRequest:inputbuff];
    NSLog(@"====request===>%@----",reqbuff);
    //connect to server with the request
    self.downloadComplete = NO;
    
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://pa.boardwalktech.com/bw_internal/%@",requestType]] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:150];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d", reqbuff.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[reqbuff dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error:&error];
    
    NSString *res = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];

    //decode the response from server
    NSString *ResDecoded = [utl PrepareResponse:res];
    
    return ResDecoded;
    
}

@end
