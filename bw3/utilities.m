//
//  utilities.m
//  bw3
//
//  Created by Ashish on 5/2/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import "utilities.h"
#import "ZipArchive.h"
#import "base64-1.h"

@implementation utilities
-(NSString *)PrepareRequest:(NSString *)usrpass
{
    NSFileManager *NFM;
    NSString *fullpath;
    NSFileHandle *NFH;
    
    
    //setup path and file name to write the user details
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [path objectAtIndex:0];
    NFM = [NSFileManager defaultManager];
    NFH = [NSFileHandle fileHandleForUpdatingAtPath:[filepath stringByAppendingPathComponent:@"userdetail.txt"]];
    [NFM changeCurrentDirectoryPath:filepath];
    fullpath = [NSString stringWithFormat:@"%@",[filepath stringByAppendingPathComponent :@"userdetail.txt"]];
    
    bool fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullpath];
    if(!fileExists)
    {
        [NFM createFileAtPath:fullpath contents:nil attributes:nil];
    }
    
    NFH = [NSFileHandle fileHandleForUpdatingAtPath:fullpath];
    NSData *userpassstr;
    const char *bytecount = [usrpass UTF8String];
    userpassstr = [NSData dataWithBytes:bytecount length:strlen(bytecount)];
    [userpassstr writeToFile:fullpath atomically:YES];
    
    
    
    //zip a file
    NSString* zippath = [filepath stringByAppendingPathComponent:@"userdetail.zip"];
    ZipArchive *ZA = [[ZipArchive alloc]init];
    bool responce = [ZA CreateZipFile2:zippath];
    responce = [ZA addFileToZip:fullpath newname:@"userdetail.txt"];
    
    //read the binary zip file
    NSData *bdata = [NSData dataWithContentsOfMappedFile:zippath];
    
    //base64
    base64_1 *B64 = [base64_1 alloc];
    NSString *bdataStr = [B64 base64EncodeData:bdata];
    //NSLog(@"==%@==",bdataStr);
    return bdataStr;
    
    
}


-(NSString *)PrepareResponse:(NSString *)response
{
    //NSString *res = [[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding];
    NSLog(@"===response=>%@===",response);
    
    NSError *error = nil;
   
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [path objectAtIndex:0];
        
    NSString* zippath = [filepath stringByAppendingPathComponent:@"userdetailRES.zip"];
    ZipArchive *ZA = [[ZipArchive alloc]init];
    bool res = [ZA CreateZipFile2:zippath];
   // responce = [ZA addFileToZip:fullpath newname:@"userdetailRES.txt"];
    
    //decore base 64
    base64_1 *B64 = [base64_1 alloc];
    NSData *bdata = [B64 base64DecodeString:response];
    
    //write to zip file 
    bool WriteResult = [bdata writeToFile:zippath options:NSDataWritingAtomic error:&error];
    NSLog(@"Write returned error: %@", [error localizedDescription]);
    
    //unzip the file
    res = [ZA UnzipOpenFile:zippath];
    res = [ZA UnzipFileTo:filepath overWrite:YES];
    
    //file manager to read file just unzipped
    NSFileManager *NFM;
    NSString *fullpath;
    NSFileHandle *NFH;
    
    NFM = [NSFileManager defaultManager];
    NFH = [NSFileHandle fileHandleForUpdatingAtPath:[filepath stringByAppendingPathComponent:@"userdetail.txt"]];
    [NFM changeCurrentDirectoryPath:filepath];
    fullpath = [NSString stringWithFormat:@"%@",[filepath stringByAppendingPathComponent :@"userdetail.txt"]];
    NFH = [NSFileHandle fileHandleForReadingAtPath:[filepath stringByAppendingPathComponent:@"Resonse.txt"]];
    bdata = [NFM contentsAtPath:[filepath stringByAppendingPathComponent :@"response.txt"]];
    NSString *resstr = [[NSString alloc] initWithData:bdata encoding:NSASCIIStringEncoding];
    //NSLog(@"===response string=>%@===",resstr);
    return resstr;
    
}


 -(BwCuboid *)MergeRefreshCuboid:(Cuboid *)CUB :(BwCuboid *)BWC
 {
    [BWC SetNumCols:[CUB GetNumCols]];
    [BWC SetNumRows:[CUB GetNumRows]];
    [BWC Settx_id:[CUB Gettx_id]];
     
     NSMutableArray *cellsold;
     NSMutableArray *cellsnew;
     cellsold = [BWC GetCells];
     cellsnew = [[NSMutableArray alloc]init];
 
     //---travrse through the row objects
     NSMutableArray *newrowids = [BWC GetRowIds];
     int oldrowcount = [newrowids count];
     Row *R1;
     NSArray *Rows = [CUB GetRow];
     for(int i=0;i<[Rows count];i++)
        {
            R1 = [[Row alloc]init];
            R1 = [Rows objectAtIndex:i];
            int rowidnew = [R1 GetRowID];
            int newrowflag = 1;
            //--traverse through rowids and if new rowid then add to rowid array
            for(int j=0;j<[newrowids count];j++)
            {
                int newrowid = [[newrowids objectAtIndex:j] intValue];
                if(rowidnew == newrowid)
                {
                    newrowflag = 0;
                }
            }
            if(newrowflag == 1)
            {
                NSString *newrowidtocuboid = [NSString stringWithFormat:@"%d",rowidnew];
                [newrowids addObject:newrowidtocuboid];
            }
 
 
            //--traverse through all cells to add to cells array
            
 
 
            NSArray *ColName = [R1 GetColNames];
            NSArray *Value = [R1 GetValues];
            int newrowcount = 0;
            //--for new rows
            if(newrowflag == 1)
            {
                int l = 0;
                int m = 1;
                for(int k = 0;k<[cellsold count];k++)
                {
                    if(m==(oldrowcount+newrowcount))
                    {
                        [cellsnew addObject:[cellsold objectAtIndex:k]];
                        [cellsnew addObject:[Value objectAtIndex:l]];
                        m=0;
                        l=l+1;
                    }
                    else
                    {
                        [cellsnew addObject:[cellsold objectAtIndex:k]];
                    }
                    m=m+1;
                }
                newrowcount = newrowcount+1;
            }
 
 
            //--for existing rows
 
        }
     
     [BWC SetRowIds:newrowids];
     
     if([cellsnew count]>0)
     {
         [BWC SetCells:cellsnew];
     }
     return BWC;
 
}
 

@end
