//
//  watchCellViewLayout.m
//  collectionViewStudy
//
//  Created by Sarang Kulkarni on 11/5/14.
//  Copyright (c) 2014 shirish. All rights reserved.
//

#import "watchCellViewLayout.h"
#import "watchCellViewController.h"
#import "watchViewController.h"
#import "colHeaderFormat.h"

static NSString * const cellWatch = @"cellWatch";

@interface watchCellViewLayout ()

@property (nonatomic, strong) NSDictionary *layoutInfo;

@end

@implementation watchCellViewLayout

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];

    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
        [self registerClass:[colHeaderFormat class] forDecorationViewOfKind:[colHeaderFormat kind]];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 13.0f, 0.0f);
    self.itemSize = CGSizeMake(106.0f, 100.0f);
    self.interItemSpacingY = 0.0f;
    self.numberOfColumns = 3;//[self.collectionView numberOfItemsInSection:section] ;//3;
  
}

#pragma mark - Layout

- (void)prepareLayout
{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSInteger item = 0;
        
        for (;item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForCellWatchAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
            
        }
        
    }
    
    newLayoutInfo[cellWatch] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) 
    {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) 
        {
            if (CGRectIntersectsRect(rect, attributes.frame)) 
            {
                
                //UICollectionViewLayoutAttributes *attributesin = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:[colHeaderFormat kind] withIndexPath:indexPath];
                //if (indexPath.section == 0)
                //{
                 //   attributesin.frame = attributes.frame;
                  //  attributesin.zIndex = 0;
                //}
                
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
    
/*    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newArray = [array mutableCopy];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (CGRectIntersectsRect([obj CGRectValue], rect))
        {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:[colHeaderFormat kind] withIndexPath:key];
            attributes.frame = [obj CGRectValue];
            attributes.zIndex = 0;
            //attributes.alpha = 0.5; // screenshots
            [newArray addObject:attributes];
        }
    }];
    
    array = [NSArray arrayWithArray:newArray];
    
    return array; */
}
/*

// layout attributes for a specific decoration view
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    id hdrRect = self.layoutInfo[indexPath];
    if (!hdrRect)
        return nil; // no shelf at this index (this is probably an error)
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:[colHeaderFormat kind] withIndexPath:indexPath];
    
    attributes.frame = [hdrRect CGRectValue];
    attributes.zIndex = 0; // shelves go behind other views

    return attributes;
} */


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[cellWatch][indexPath];
}

- (CGSize)collectionViewContentSize
{
    NSInteger rowCount = [self.collectionView numberOfSections] / self.numberOfColumns;
    // make sure we count another row if one is only partially filled
    if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount++;
    
    CGFloat height = self.itemInsets.top +
    (rowCount + 2) * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
    self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}


#pragma mark - Private

- (CGRect)frameForCellWatchAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger row = indexPath.section / self.numberOfColumns;
   // NSInteger column = indexPath.section % self.numberOfColumns;
     NSInteger row = indexPath.section;
     NSInteger column = indexPath.item;
    
    CGFloat spacingX =  self.collectionView.bounds.size.width -
                        self.itemInsets.left -
                        self.itemInsets.right -
                        (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1)
        spacingX = spacingX / (self.numberOfColumns - 1);
    
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);

    
    CGFloat originY = floor(self.itemInsets.top +(self.itemSize.height + self.interItemSpacingY) * row);

    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

@end










