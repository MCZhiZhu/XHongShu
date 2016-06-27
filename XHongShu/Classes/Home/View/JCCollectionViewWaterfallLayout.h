//
//  JCCollectionViewWaterfallLayout.h
//  JCCollectionViewWaterfallLayout
//
//  Created by 李京城 on 15/6/4.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCCollectionViewWaterfallLayoutDelegate <UICollectionViewDelegateFlowLayout>
@optional
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section;
@end

@interface JCCollectionViewWaterfallLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger columnCount; // default 2
@property (nonatomic, assign) CGFloat headerHeight; // default 0
@property (nonatomic, assign) CGFloat footerHeight; // default 0
@property (nonatomic, assign) CGFloat ofSetHeight;

@end
