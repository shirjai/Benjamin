//
//  LinkImport.m
//  bw3
//
//  Created by Ashish on 6/3/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "LinkImport.h"
#import "Buffer.h"
#import "Http.h"
#import "Database.h"


@implementation LinkImport

-(Cuboid*)LinkImportApi:(NSInteger *)TableId
{
    Buffer *Buff = [Buffer alloc];
    NSString *CallBuff = [Buff GetBufferLinkImport:TableId];
    
    
    //connect to server and link import the cuboid
    Http *CallBrwalk = [[Http alloc]init];
    NSString *Res;
    Res = [CallBrwalk callBoardwalk:CallBuff:@"xlLinkImportService"];
    BwCuboid *CuboidSer = [Buff ExtractResponseLinkImport:Res];
    Database *Db = [[Database alloc] init];
    [Db writeCuboid:CuboidSer];
    
    Cuboid *CUB = [[Cuboid alloc] init];
    
    [CUB SetCuboid:CuboidSer];
    
    return CUB;
}

@end
