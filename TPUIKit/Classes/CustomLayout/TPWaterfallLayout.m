//
//  TPWaterfallLayout.m
//  TPUIKit
//
//  Created by Topredator on 2024/12/22.
//

#import "TPWaterfallLayout.h"

@interface TPWaterfallLayout ()
@property (nonatomic) CGSize contentSize;
@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, strong) NSMutableArray *allItemAttributes;
@property (nonatomic, strong) NSMutableArray *sectionItemAttributes;
@property (nonatomic, strong) NSMutableDictionary *headersAttribute;
@property (nonatomic, strong) NSMutableDictionary *footersAttribute;
@property (nonatomic, strong) NSMutableArray *unionRects;
@end


/// How many items to be union into a single rectangle
static const NSInteger unionSize = 20;
@implementation TPWaterfallLayout
- (void)prepareLayout {
    [super prepareLayout];
    NSInteger sections = [self.collectionView numberOfSections];
    if (sections == 0) {
        return;
    }
    CGFloat contentSizeWidth = CGRectGetWidth(self.collectionView.frame);;
    [self.allItemAttributes removeAllObjects];
    [self.headersAttribute removeAllObjects];
    [self.footersAttribute removeAllObjects];
    [self.unionRects removeAllObjects];
    [self.sectionItemAttributes removeAllObjects];
    [self.columnHeights removeAllObjects];
    
    for (NSInteger section = 0; section < sections; section++) {
        // 计算columnCount
        NSInteger columnCount = [self columnCountForSection:section];
        if (columnCount == 0) return;
        /// 先 占位 column的高度
        NSMutableArray *sectionColumnHeights = @[].mutableCopy;
        for (NSInteger i = 0; i < columnCount; i++) {
            [sectionColumnHeights addObject:@(0)];
        }
        [self.columnHeights addObject:sectionColumnHeights];
    }
    
    CGFloat top = 0;
    
    UICollectionViewLayoutAttributes *attributes;
    for (NSInteger section = 0; section < sections; section++) {
        NSInteger columnCount = [self columnCountForSection:section];
        CGSize firstItemSize = [self itemSizeForSection:section row:0];
        CGFloat itemWidth = firstItemSize.width;
        
        // section header
        CGFloat headerHeight = [self headerSizeForSection:section].height;
        CGFloat itemSpace = [self itemSpaceForSection:section];
        
        if (headerHeight > 0) {
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            attributes.frame = CGRectMake(0, top, contentSizeWidth, headerHeight);
            self.headersAttribute[@(section)] = attributes;
            [self.allItemAttributes addObject:attributes];
            top += headerHeight;
        }
        
        UIEdgeInsets sectionInsets = [self sectionInsetForSection:section];
        top += sectionInsets.top;
        for (NSInteger index = 0; index < columnCount; index ++) {
            self.columnHeights[section][index] = @(top);
        }
        
        // section -> items
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *itemAttributes = @[].mutableCopy;
        for (NSInteger index = 0; index < itemCount; index++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
            NSUInteger columnIndex = [self shortestColumnIndexInSection:section];
            CGFloat x = sectionInsets.left + (itemWidth + itemSpace) * columnIndex;
            CGFloat y = [self.columnHeights[section][columnIndex] floatValue];
            CGSize itemSize = [self itemSizeForSection:section row:index];
            CGFloat itemHeight = 0;
            if (itemSize.height > 0 && itemSize.width > 0) {
                itemHeight = itemSize.height;
            }
            
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectMake(x, y, itemWidth, itemHeight);
            [itemAttributes addObject:attributes];
            [self.allItemAttributes addObject:attributes];
            self.columnHeights[section][columnIndex] = @(CGRectGetMaxY(attributes.frame) + itemSpace);
        }
        
        [self.sectionItemAttributes addObject:itemAttributes];
        
        // section footer
        NSUInteger columnIndex = [self longestColumnIndexInSection:section];
        if (((NSArray *)self.columnHeights[section]).count > 0) {
            top = [self.columnHeights[section][columnIndex] floatValue] - itemSpace + sectionInsets.bottom;
        } else {
            top = 0;
        }
        CGFloat footerHeight = [self footerSizeForSection:section].height;
        
        if (footerHeight > 0) {
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(0, top, contentSizeWidth, footerHeight);
            self.footersAttribute[@(section)] = attributes;
            [self.allItemAttributes addObject:attributes];
            top += footerHeight;
        }
        
        for (NSInteger index = 0; index < columnCount; index ++) {
            self.columnHeights[section][index] = @(top);
        }
    }
    
    NSInteger idx = 0;
    NSInteger itemCounts = [self.allItemAttributes count];
    while (idx < itemCounts) {
        CGRect unionRect = ((UICollectionViewLayoutAttributes *)self.allItemAttributes[idx]).frame;
        NSInteger rectEndIndex = MIN(idx + unionSize, itemCounts);
        
        for (NSInteger i = idx + 1; i < rectEndIndex; i++) {
            unionRect = CGRectUnion(unionRect, ((UICollectionViewLayoutAttributes *)self.allItemAttributes[i]).frame);
        }
        
        idx = rectEndIndex;
        
        [self.unionRects addObject:[NSValue valueWithCGRect:unionRect]];
    }
}
- (CGSize)collectionViewContentSize {
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) {
        return CGSizeZero;
    }
    CGSize contentSize = self.collectionView.bounds.size;
    contentSize.height = [[[self.columnHeights lastObject] firstObject] floatValue];
    
    if (contentSize.height < self.minimumContentHeight) {
        contentSize.height = self.minimumContentHeight;
    }
    
    return contentSize;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = nil;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        attribute = self.headersAttribute[@(indexPath.section)];
    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        attribute = self.footersAttribute[@(indexPath.section)];
    }
    return attribute;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sectionItemAttributes.count) {
        return nil;
    }
    if (indexPath.item >= [self.sectionItemAttributes[indexPath.section] count]) {
        return nil;
    }
    return (self.sectionItemAttributes[indexPath.section])[indexPath.item];
}
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger i;
    NSInteger begin = 0, end = self.unionRects.count;
    NSMutableDictionary *cellAttrDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *supplHeaderAttrDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *supplFooterAttrDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *decorAttrDict = [NSMutableDictionary dictionary];
    
    for (i = 0; i < self.unionRects.count; i++) {
        if (CGRectIntersectsRect(rect, [self.unionRects[i] CGRectValue])) {
            begin = i * unionSize;
            break;
        }
    }
    for (i = self.unionRects.count - 1; i >= 0; i--) {
        if (CGRectIntersectsRect(rect, [self.unionRects[i] CGRectValue])) {
            end = MIN((i + 1) * unionSize, self.allItemAttributes.count);
            break;
        }
    }
    for (i = begin; i < end; i++) {
        UICollectionViewLayoutAttributes *attr = self.allItemAttributes[i];
        if (CGRectIntersectsRect(rect, attr.frame)) {
            switch (attr.representedElementCategory) {
                case UICollectionElementCategorySupplementaryView:
                    if ([attr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                        supplHeaderAttrDict[attr.indexPath] = attr;
                    } else if ([attr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
                        supplFooterAttrDict[attr.indexPath] = attr;
                    }
                    break;
                case UICollectionElementCategoryDecorationView:
                    decorAttrDict[attr.indexPath] = attr;
                    break;
                case UICollectionElementCategoryCell:
                    cellAttrDict[attr.indexPath] = attr;
                    break;
            }
        }
    }
    NSArray *result = [cellAttrDict.allValues arrayByAddingObjectsFromArray:supplHeaderAttrDict.allValues];
    result = [result arrayByAddingObjectsFromArray:supplFooterAttrDict.allValues];
    result = [result arrayByAddingObjectsFromArray:decorAttrDict.allValues];
    return result;
}
#pragma mark----------------- Private method -----------------
- (NSInteger)columnCountForSection:(NSInteger)section {
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    UIEdgeInsets sectionInsets = [self sectionInsetForSection:section];
    collectionViewWidth -= (sectionInsets.left + sectionInsets.right);
    CGFloat itemWidth = [self itemSizeForSection:section row:0].width;
    CGFloat itemSpace = [self itemSpaceForSection:section];
    if (itemSpace + itemWidth == 0.0) {
        return 0;
    }
    return (collectionViewWidth + itemSpace) / (itemWidth + itemSpace);
}
- (CGSize)headerSizeForSection:(NSInteger)section {
    return  [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
}
- (CGSize)footerSizeForSection:(NSInteger)section {
    return [(id <UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
}
- (CGFloat)itemSpaceForSection:(NSInteger)section {
    return [(id <UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
}
- (UIEdgeInsets)sectionInsetForSection:(NSInteger)section {
    return [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
}
- (CGSize)itemSizeForSection:(NSInteger)section row:(NSInteger)row {
    return [(id <UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

/// 找出最短的列
- (NSInteger)shortestColumnIndexInSection:(NSInteger)section {
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;
    
    [self.columnHeights[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = idx;
        }
    }];
    return index;
}
/// 找出最长的列
- (NSUInteger)longestColumnIndexInSection:(NSInteger)section {
    __block NSUInteger index = 0;
    __block CGFloat longestHeight = 0;
    
    [self.columnHeights[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height > longestHeight) {
            longestHeight = height;
            index = idx;
        }
    }];
    
    return index;
}


- (NSInteger)rowCountForSection:(NSInteger)section {
    return 0;
}
//- (void)

#pragma mark----------------- Getter -----------------
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = @[].mutableCopy;
    }
    return _columnHeights;
}
- (NSMutableDictionary *)headersAttribute {
    if (!_headersAttribute) {
        _headersAttribute = @{}.mutableCopy;
    }
    return _headersAttribute;
}
- (NSMutableDictionary *)footersAttribute {
    if (!_footersAttribute) {
        _footersAttribute = @{}.mutableCopy;
    }
    return _footersAttribute;
}
- (NSMutableArray *)allItemAttributes {
    if (!_allItemAttributes) {
        _allItemAttributes = @[].mutableCopy;
    }
    return _allItemAttributes;
}
- (NSMutableArray *)sectionItemAttributes {
    if (!_sectionItemAttributes) {
        _sectionItemAttributes = @[].mutableCopy;
    }
    return _sectionItemAttributes;
}
- (NSMutableArray *)unionRects {
    if (!_unionRects) {
        _unionRects = @[].mutableCopy;
    }
    return _unionRects;
}
@end
