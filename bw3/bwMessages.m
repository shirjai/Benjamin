//
//  bwMessages.m
//  bw3
//
//  Created by Shirish Jaiswal on 7/24/14.
//  Copyright (c) 2014 Shirish Jaiswal. All rights reserved.
//

#import "bwMessages.h"
#import "LinkImport.h"
#import "Buffer.h"
#import "Http.h"
#import "Database.h"

@implementation bwMessages

-(void)initialize:(NSInteger *)TableId
{
    Buffer *Buff = [Buffer alloc];
    NSString *CallBuff = [Buff GetBufferLinkImport:TableId];


    //connect to server and link import the cuboid
    Http *CallBrwalk = [[Http alloc]init];
    NSString *Res;
  //  Res = [CallBrwalk callBoardwalk:CallBuff:@"xlLinkImportService"];
    BwCuboid *CuboidSer = [Buff ExtractResponseLinkImport:Res];
    Database *Db = [[Database alloc] init];
    [Db writeCuboid:CuboidSer];

    Cuboid *CUB = [[Cuboid alloc] init];

    [CUB SetCuboid:CuboidSer];
}



@end
