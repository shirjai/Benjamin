//
//  Buffer.m
//  bw3
//
//  Created by Ashish on 4/28/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "Buffer.h"
#import "Database.h"
//#import "BwCuboid.h"

@implementation Buffer


-(NSString *)GetBufferLogin
{
    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@",self.user,seperator,self.pass];
    return buffer;
}

-(NSString *)ExtractResponseLogin:(NSString *)ResBuffer
{
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    
    NSLog(@"===response buffer=>%@===",ResBuffer);
    NSArray *resParts = [ResBuffer componentsSeparatedByString:@":"];
    NSString *ResBool = [resParts objectAtIndex:0];
    
    if ([ResBool isEqualToString: @"Success"])
    {
    NSArray *Resparts2 = [[resParts objectAtIndex:1] componentsSeparatedByString:seperator];
    NSString *UserID = [Resparts2 objectAtIndex:0];
    NSString *MemberID = [Resparts2 objectAtIndex:1];
    NSString *NHID = [Resparts2 objectAtIndex:2];
    NSString *NhName = [Resparts2 objectAtIndex:3];
    
        //save info to database
        Database *db =[Database alloc];
        [db getPropertiesFile];
        [db UpdateProperties:@"UserId" :  UserID];
        [db UpdateProperties:@"MemberId" : MemberID];
        [db UpdateProperties:@"NhId" :  NHID];
        [db UpdateProperties:@"NhName" :NhName];
        [db writePropertiesFile];
    
    }
    
    return ResBool;
    
}



//linkImport buffer
-(NSString *)GetBufferLinkImport:(NSInteger *)TableID
{
    //get saved information from DB
    Database *db =[Database alloc];
    [db getPropertiesFile];
    NSString *UserID = [db GetPropertyValue:@"UserId"];
    NSString *UserName = [db GetPropertyValue:@"UserName"];
    NSString *UserPass = [db GetPropertyValue:@"UserPass"];
    NSString *MemberId = [db GetPropertyValue:@"MemberId"];
    NSString *NhId = [db GetPropertyValue:@"NhId"];

    NSString *TblId = [NSString stringWithFormat: @"%ld",TableID];

    NSString *seperator;
    seperator = [NSString stringWithFormat:@"%c",1];
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@-1%@%@0",UserID,seperator,UserName,seperator,UserPass,seperator,MemberId,seperator,NhId,seperator,TblId,seperator,seperator,seperator];
    NSLog(@"BufferLI = %@" ,buffer);
    return buffer;
}


-(BwCuboid *)ExtractResponseLinkImport:(NSString *)ResBuffer
{
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    NSArray *resParts = [ResBuffer componentsSeparatedByString:ContentDeLimiter];
    NSLog(@"-------------------------------------------------------Res LI =%@",ResBuffer);
    
    //creae the cuboid object
    BwCuboid *Cuboid = [BwCuboid alloc];
   
    NSArray *resparts1 = [[resParts objectAtIndex:0] componentsSeparatedByString:seperator];
    NSString *ResBool = [resparts1 objectAtIndex:0];
    NSLog(@"===response bool=>%@===",ResBool);
    if ([ResBool isEqualToString: @"Success"])
    {
        //header info extract
        NSString *TableId = [resparts1 objectAtIndex:1];
        NSLog(@"==table id=>%@===",TableId);
        NSString *TableName = [resparts1 objectAtIndex:2];
        NSString *TableDes = [resparts1 objectAtIndex:3];
        NSString *View = [resparts1 objectAtIndex:4];
        NSString *UserId = [resparts1 objectAtIndex:5];
        NSString *MemberId = [resparts1 objectAtIndex:6];
        NSString *NhId = [resparts1 objectAtIndex:7];
        NSString *NumCols = [resparts1 objectAtIndex:8];
        NSString *NumRows = [resparts1 objectAtIndex:9];
        NSString *Tx_id = [resparts1 objectAtIndex:10];
        NSString *ExportTid = [resparts1 objectAtIndex:11];
        NSString *CriteriaTableId = [resparts1 objectAtIndex:12];
        NSString *Mode = [resparts1 objectAtIndex:13];
        
        [Cuboid SetTableId:[TableId intValue]];
        [Cuboid SetTableName:TableName];
        [Cuboid SetTableDes:TableDes];
        [Cuboid SetView:View];
        [Cuboid SetNumCols:[NumCols intValue]];
        [Cuboid SetNumRows:[NumRows intValue]];
        [Cuboid Settx_id:[Tx_id intValue]];
        [Cuboid SetExportTid:[ExportTid intValue]];
        [Cuboid SetCriteriaTblId:[CriteriaTableId intValue]];
        [Cuboid SetMode:[Mode intValue]];
        
        //column info
        NSLog(@"==NumCols=>%@===",NumCols);
        //convert nsstring to int
        int colcount = [NumCols intValue];
        NSArray *ColArr = [[resParts objectAtIndex:1] componentsSeparatedByString:seperator];
        NSMutableArray *ColID = [[NSMutableArray alloc] init];
        NSMutableArray *ColName = [[NSMutableArray alloc] init];
        for(int i =0;i < colcount; i++)
        {
           // NSLog(@"==col id%d=>%@===",i,[ColArr objectAtIndex:i*5]);
            [ColID addObject:[ColArr objectAtIndex:i*5]];
            NSLog(@"==col name=>%@===",[ColArr objectAtIndex:(i*5)+1]);
            [ColName addObject:[ColArr objectAtIndex:(i*5)+1]];
        }
        
        [Cuboid SetColumnIds:ColID];
        [Cuboid SetColumnNames:ColName];
        
        //row info
        NSLog(@"==NumCols=>%@===",NumRows);
        //convert nsstring to int
        int rowcount = [NumRows intValue];
        NSArray *RowArr = [[resParts objectAtIndex:2] componentsSeparatedByString:seperator];
        NSMutableArray *RowIds = [[NSMutableArray alloc] init];
        for(int i =0;i < rowcount; i++)
        {
            [RowIds addObject:[RowArr objectAtIndex:i]];
        }
        
        [Cuboid SetRowIds:RowIds];
        
        
        //celldata
        NSMutableArray *Cells = [[NSMutableArray alloc] init];
        for(int i=0;i<colcount;i++)
        {
            NSArray *CellArr = [[resParts objectAtIndex:3+(i*2)] componentsSeparatedByString:seperator];
            for(int j =0;j < rowcount; j++)
            {
                [Cells addObject:[CellArr objectAtIndex:j]];
            }
        }
        
        [Cuboid SetCells:Cells];
        
    }

    return Cuboid;
    
}



-(NSString *)GetBufferRefresh:(NSInteger *)TableID
{
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    
    //get existing cuboid from local database
    int tableID = TableID;
    Database *DB = [[Database alloc]init];
    BwCuboid *BWD = [DB Getcuboid:tableID];
    
    [DB getPropertiesFile];
    NSString *UserID = [DB GetPropertyValue:@"UserId"];
    NSString *UserName = [DB GetPropertyValue:@"UserName"];
    NSString *UserPass = [DB GetPropertyValue:@"UserPass"];
    NSString *MemberId = [DB GetPropertyValue:@"MemberId"];
    NSString *NhId = [DB GetPropertyValue:@"NhId"];
    
    //create the buffer from properties of cuboid
    NSString *buffer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%d%@-1%@%@%@%d%@%d%@%d%@0%@%@",UserID,seperator,UserName,seperator,UserPass,seperator,MemberId,seperator,NhId,seperator,tableID,seperator,seperator,[BWD GetView],seperator,[BWD Gettx_id],seperator,[BWD GetExportTid],seperator,[BWD GetMode],seperator,seperator,ContentDeLimiter];
    
    
    //get string of rowids
    NSString *TempStr = @"";
    NSArray *RowIds = [BWD GetRowIds];
    for(int i=0;i<[BWD GetNumRows]; i++)
    {
        TempStr = [NSString stringWithFormat:@"%@%@%@",TempStr,[RowIds objectAtIndex:i],seperator];
    }
    
    TempStr = [TempStr substringToIndex:[TempStr length]-1];
    TempStr = [NSString stringWithFormat:@"%@%@",TempStr,ContentDeLimiter];
    buffer = [NSString stringWithFormat:@"%@%@",buffer,TempStr];

    
    NSLog(@"BufferRefresh = %@" ,buffer);
    return buffer;
    
}


-(BwCuboid *)ExtractResponseRefresh:(NSString *)ResBuffer:(int) mode
{
    NSLog(@"Refresh response = %@" ,ResBuffer);
    BwCuboid *BWC = [[BwCuboid alloc]init];
    
    NSString *seperator = [NSString stringWithFormat:@"%c",1];
    NSString *ContentDeLimiter = [NSString stringWithFormat:@"%c",2];
    NSArray *resParts = [ResBuffer componentsSeparatedByString:ContentDeLimiter];
    NSLog(@"-------------------------------------------------------Res Refresh =%@",ResBuffer);
    
    //creae the cuboid object
    NSArray *resparts1 = [[resParts objectAtIndex:0] componentsSeparatedByString:seperator];
    NSString *ResBool = [resparts1 objectAtIndex:0];
    NSLog(@"===response bool=>%@===",ResBool);
    if ([ResBool isEqualToString: @"Success"])
    {
        NSString *numcolumns = [resparts1 objectAtIndex:1];
        NSString *numRows = [resparts1 objectAtIndex:2];
        NSString *maxTid = [resparts1 objectAtIndex:3];
        
        [BWC SetNumCols:[numcolumns intValue]];
        [BWC SetNumRows:[numRows intValue]];
        [BWC Settx_id:[maxTid intValue]];

        
        //------column names
        int colcount = [numcolumns intValue];
        NSArray *ColArr = [[resParts objectAtIndex:1] componentsSeparatedByString:seperator];
        NSMutableArray *ColID = [[NSMutableArray alloc] init];
        NSMutableArray *ColName = [[NSMutableArray alloc] init];
        for(int i =0;i < colcount*3; i++)
        {
            // NSLog(@"==col id%d=>%@===",i,[ColArr objectAtIndex:i*5]);
            [ColID addObject:[ColArr objectAtIndex:i]];
            //NSLog(@"==col name=>%@===",[ColArr objectAtIndex:(i*5)+1]);
            [ColName addObject:[ColArr objectAtIndex:i+1]];
            i = i+2;
        }
        
        //------get cell
        NSArray *CellArr = [[resParts objectAtIndex:3] componentsSeparatedByString:seperator];
        NSMutableArray *ColumnID = [[NSMutableArray alloc] init];
        NSMutableArray *rowID = [[NSMutableArray alloc] init];
        NSMutableArray *cellv = [[NSMutableArray alloc] init];
        NSMutableArray *ColumnName = [[NSMutableArray alloc] init];
        
        if ([CellArr count]>1)
        {
            for(int i =0;i < [CellArr count] ; i++)
            {
               // NSLog(@"==col id%d=>%@===",i,[CellArr objectAtIndex:i]);
                [rowID addObject:[CellArr objectAtIndex:i]];
                //NSLog(@"==col name=>%@===",[CellArr objectAtIndex:i+1]);
                [ColumnID addObject:[CellArr objectAtIndex:i+1]];
                [cellv addObject:[CellArr objectAtIndex:i+2]];
            
                //get column name
                for(int j = 0;j<colcount;j++)
                {
                    NSString *colidstr = [ColID objectAtIndex:j];
                    NSString *colnamestr = [CellArr objectAtIndex:i+1];
                    if( [colnamestr isEqualToString: colidstr])
                    {
                        [ColumnName addObject:[ColName objectAtIndex:j]];
                    }
                }
            
                i = i+4;
            }
        }
        
        [BWC SetRowIds:rowID];
        [BWC SetColumnIds:ColumnID];
        [BWC SetColumnNames:ColumnName];
        [BWC SetCells:cellv];
        
    }
    
    
    return BWC;
    
}


@end
