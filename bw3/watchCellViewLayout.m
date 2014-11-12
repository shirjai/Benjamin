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
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(22.0f, 10.0f, 13.0f, 10.0f);
    self.itemSize = CGSizeMake(98.0f, 50.0f);
    self.interItemSpacingY = 1.0f;
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
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

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










