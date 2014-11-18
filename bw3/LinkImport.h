//
//  LinkImport.h
//  bw3
//
//  Created by Ashish on 6/3/14.
//  Copyright (c) 2014 Ashish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BwCuboid.h"
#import "Cuboid.h"

@interface LinkImport : NSObject

-(Cuboid *)LinkImportApi:(NSInteger*) TableId;
-(Cuboid*)LinkImportApiOnDemand:(NSInteger *)TableId onDemandParam:(NSString *)query;

@end
