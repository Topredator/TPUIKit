//
//  TPFitWidthLayout.m
//  TPUIKit
//
//  Created by Topredator on 2024/12/22.
//

#import "TPFitWidthLayout.h"

@interface TPFitWidthLayout ()
@property (nonatomic) CGSize contentSize;
@property (nonatomic, strong) NSMutableArray *allItemAttributes;
@property (nonatomic, strong) NSMutableDictionary *headersAttribute;
@property (nonatomic, strong) NSMutableArray *sectionItemAttributes;
@property (nonatomic, strong) NSMutableDictionary *footersAttribute;
@property (nonatomic, strong) NSMutableArray *unionRects;
@end


/// How many items to be union into a single rectangle
static const NSInteger unionSize = 20;
@implementation TPFitWidthLayout

- (void)prepareLayout {
    [super prepareLayout];
    NSInteger sections = [self.collectionView numberOfSections];
    if (sections == 0) {
        return;
    }
    
    CGFloat top = 0;
    UICollectionViewLayoutAttributes *attributes;
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    for (NSInteger section = 0; section < sections; section++) {
        CGFloat itemSpace = [self itemSpaceForSection:section];
        CGFloat lineSpace = [self lineSpaceForSection:section];
        
        // section -> header
        CGSize headerSize = [self headerSizeForSection:section];
        if (headerSize.height > 0) {
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(0, top, collectionViewWidth, headerSize.height);
            self.headersAttribute[@(section)] = attributes;
            [self.allItemAttributes addObject:attributes];
            top += headerSize.height;
        }
        
        // section -> items
        UIEdgeInsets sectionInset = [self sectionInsetForSection:section];
        top += sectionInset.top;
        CGFloat left = sectionInset.left;
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        // 最大宽度
        CGFloat maxWidth = collectionViewWidth - (sectionInset.left + sectionInset.right);
        
        UICollectionViewLayoutAttributes *lastAttributes;
        NSMutableArray *itemAttributes = @[].mutableCopy;
        for (NSInteger index = 0; index < itemCount; index ++) {
            CGSize itemSize = [self itemSizeForSection:section row:index];
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
            CGFloat originX = left;
            CGFloat originY = top;
            CGFloat itemWidth = itemSize.width;
            CGFloat itemHeight = itemSize.height;
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            // >= 最大宽度
            if (itemWidth >= maxWidth) {
                itemWidth = maxWidth;
            }
            // 如果超过最大展示内容，另起一行
            if (left + itemWidth > collectionViewWidth - sectionInset.right) {
                left = sectionInset.left;
                top += lineSpace + itemHeight;
            }
            attributes.frame = CGRectMake(left, top, itemWidth, itemHeight);
            [itemAttributes addObject:attributes];
            [self.allItemAttributes addObject:attributes];
            lastAttributes = attributes;
            left += itemSpace + itemWidth;
        }
        if (lastAttributes) {
            top += lastAttributes.frame.size.height;
        }
        [self.sectionItemAttributes addObject:itemAttributes];
        
        top += sectionInset.bottom;
        // section -> footer
        CGSize footerSize = [self footerSizeForSection:section];
        if (footerSize.height > 0) {
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(0, top, collectionViewWidth, footerSize.height);
            self.footersAttribute[@(section)] = attributes;
            [self.allItemAttributes addObject:attributes];
            top += footerSize.height;
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
    
    self.contentSize = CGSizeMake(collectionViewWidth, top);
}

- (CGSize)collectionViewContentSize {
    return self.contentSize;
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
- (CGSize)headerSizeForSection:(NSInteger)section {
    return  [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
}
- (CGSize)footerSizeForSection:(NSInteger)section {
    return [(id <UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
}
- (CGFloat)itemSpaceForSection:(NSInteger)section {
    return [(id <UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
}
- (CGFloat)lineSpaceForSection:(NSInteger)section {
    return [(id <UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
}
- (UIEdgeInsets)sectionInsetForSection:(NSInteger)section {
    return [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
}
- (CGSize)itemSizeForSection:(NSInteger)section row:(NSInteger)row {
    return [(id <UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

#pragma mark----------------- Getter -----------------
- (NSMutableArray *)allItemAttributes {
    if (!_allItemAttributes) {
        _allItemAttributes = [NSMutableArray array];
    }
    return _allItemAttributes;
}
- (NSMutableDictionary *)headersAttribute {
    if (!_headersAttribute) {
        _headersAttribute = [NSMutableDictionary dictionary];
    }
    return _headersAttribute;
}
- (NSMutableArray *)sectionItemAttributes {
    if (!_sectionItemAttributes) {
        _sectionItemAttributes = @[].mutableCopy;
    }
    return _sectionItemAttributes;
}
- (NSMutableDictionary *)footersAttribute {
    if (!_footersAttribute) {
        _footersAttribute = [NSMutableDictionary dictionary];
    }
    return _footersAttribute;
}
- (NSMutableArray *)unionRects {
    if (!_unionRects) {
        _unionRects = @[].mutableCopy;
    }
    return _unionRects;
}
@end

