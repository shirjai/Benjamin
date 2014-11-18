//
//  Buffer.h
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BwCuboid.h"
#import "Cuboid.h"

@interface Buffer : NSObject

@property NSString *user;
@property NSString *pass;

-(NSString *) GetBufferLogin;
-(NSString *) ExtractResponseLogin: (NSString*) ResBuffer;

-(NSString *) GetBufferLinkImport:(NSInteger *)TableID;
-(BwCuboid *) ExtractResponseLinkImport:(NSString*) ResBuffer;

-(NSString *) GetBufferRefresh:(NSInteger *)TableID;
-(BwCuboid *) ExtractResponseRefresh:(NSString*) ResBuffer:(int) mode;

-(NSString *) GetBufferSubmit:(Cuboid *) cub;
-(Cuboid *) ExtractResponseSubmit:(NSString *) ResBuffer:(Cuboid *) cub;

/***** start: ondemand linkImport buffer added by shirish on 11/13/14*****/
-(NSString *)GetBufferLinkImportOnDemand:(NSInteger *)TableID onDemandParam:(NSString *)query;
/***** end: ondemand linkImport buffer added by shirish on 11/13/14*****/

@end
