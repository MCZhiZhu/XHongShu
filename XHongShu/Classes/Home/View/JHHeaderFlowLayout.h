//
//  JHHeaderFlowLayout.h
//  collectionView的首页
//
//  Created by 会跳舞的狮子 on 16/5/4.
//  Copyright © 2016年 会跳舞的狮子. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef CGFloat(^HeightBlock)(NSIndexPath *indexPath , CGFloat width);
@interface JHHeaderFlowLayout : UICollectionViewFlowLayout
//默认为64.0, default is 64.0
@property (nonatomic, assign) CGFloat naviHeight;


/** 列数 */
@property (nonatomic, assign) NSInteger lineNumber;
/** 行间距 */
@property (nonatomic, assign) CGFloat rowSpacing;
/** 列间距 */
@property (nonatomic, assign) CGFloat lineSpacing;
/** 内边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInsets;
/**
 *  计算各个item高度方法 必须实现
 *
 *  @param block 设计计算item高度的block
 */
- (void)computeIndexCellHeightWithWidthBlock:(CGFloat(^)(NSIndexPath *indexPath , CGFloat width))block;
@end
