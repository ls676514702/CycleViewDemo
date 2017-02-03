//
//  LSCollectionViewFlowLayout.m
//  CycleImageDemo
//
//  Created by 梁森 on 17/2/3.
//  Copyright © 2017年 Personal Project. All rights reserved.
//

#import "LSCollectionViewFlowLayout.h"

@implementation LSCollectionViewFlowLayout
- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
}
@end
