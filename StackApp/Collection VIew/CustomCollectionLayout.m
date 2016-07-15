//
//  CustomCollectionLayout.h
//  StackApp
//
//  Created by datta on 14/07/2016.
//  Copyright © 2016 Stack Lab. All rights reserved.
//

#import "CustomCollectionLayout.h"

@interface CustomCollectionLayout ()

@end

@implementation CustomCollectionLayout
{
    NSDictionary *_layoutInfo;
    CGFloat maxColumnHeight;
    __weak id<CustomCollectionLayoutDelegate> delegate;
}

- (void)prepareLayout{
    
//    NSLog(@"prepareLayout");
    delegate = (id<CustomCollectionLayoutDelegate>) self.collectionView.delegate;
    //Calculate max values
    maxColumnHeight = [self maxColumnHeight];
    
    //Store calculated frames for cells in the dictionary
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    //Calculate Frame for a cell, per values from DataSource
    CGFloat originY = 0;
    CGFloat floatingSectionOriginY = self.collectionView.contentOffset.y;
    BOOL sectionIsFloating = NO;
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        
        UIEdgeInsets itemInsets = UIEdgeInsetsZero;
        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            itemInsets = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
            originY += itemInsets.top;
        }
        
        CGFloat height = 0;
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        CGFloat originX = itemInsets.left;
        
        if ([delegate respondsToSelector:@selector(collectionView:layout:shouldFloatSectionAtIndex:)]) {
            sectionIsFloating = [delegate collectionView:self.collectionView layout:self shouldFloatSectionAtIndex:section];
        }
        for (NSInteger item = 0; item < itemCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            CGSize itemSize = CGSizeZero;
            if ([delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
                itemSize = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
                float selectedOriginY = originY;
                if (sectionIsFloating) {
                    if (floatingSectionOriginY >= originY) {
                        selectedOriginY = floatingSectionOriginY;
                    }
                    itemAttributes.zIndex = 1000;//any value greater than '0'
                }
                itemAttributes.frame = CGRectMake(originX, selectedOriginY, itemSize.width, itemSize.height);
            }
            cellLayoutInfo[indexPath] = itemAttributes;
            
            CGFloat interItemSpacingX = 0;
            if ([delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
                interItemSpacingX = [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
            }
            
            originX += floorf(itemSize.width + interItemSpacingX);
            height = height > itemSize.height ? height : itemSize.height;
        }
        
        CGFloat interItemSpacingY = 0;
        if ([delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
            interItemSpacingY = [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
        }
        
        originY += floor(height + interItemSpacingY);
        if (sectionIsFloating) {
            floatingSectionOriginY += height;
        }
    }
    
    _layoutInfo = cellLayoutInfo;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:_layoutInfo.count];
    
    [_layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                     UICollectionViewLayoutAttributes *attributes,
                                                     BOOL *innerStop) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }];
    
    return allAttributes;
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _layoutInfo[indexPath];
}

- (CGSize)collectionViewContentSize
{
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat height = maxColumnHeight;
    return CGSizeMake(width, height);
}

//Maximum Height of perticular Column in CollectionView
- (CGFloat)maxColumnHeight
{
    NSInteger sectionCount = [self.collectionView numberOfSections];
    CGFloat maxHeight = 0;
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        CGFloat maxRowHeight = 0;
        for (NSInteger item = 0; item < itemCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            if ([delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
                CGSize itemSize = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
                maxRowHeight = itemSize.height > maxRowHeight ? itemSize.height : maxRowHeight;
            }
        }
        CGFloat interSectionSpacingY = 0;
        if ([delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
            interSectionSpacingY = [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
        }
        
        UIEdgeInsets itemInsets = UIEdgeInsetsZero;
        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            itemInsets = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        }
        
        maxHeight += maxRowHeight;
        
        //Add interSectionSpacing and Insets for all sections except last.
        if (section != sectionCount-1) {
            maxHeight += interSectionSpacingY + itemInsets.top;
        }
    }
    
    return maxHeight;
}

@end
