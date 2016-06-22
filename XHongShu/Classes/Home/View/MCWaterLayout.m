//
//  MCWaterLayout.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MCWaterLayout.h"

@interface MCWaterLayout()

/** 存放每列高度字典*/
@property (nonatomic, strong) NSMutableDictionary *dicOfheight;
/** 存放所有item的attrubutes属性*/
@property (nonatomic, strong) NSMutableArray *array;
/** 计算每个item高度的block，必须实现*/
@property (nonatomic, copy) HeightBlock block;

@end
@implementation MCWaterLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        //对默认属性进行设置
        /**
         默认行数 2行
         默认行间距 10.0f
         默认列间距 10.0f
         默认内边距 top:10 left:10 bottom:10 right:10
         */
        self.lineNumber = 2;
        self.rowSpacing = 10.0f;
        self.lineSpacing = 10.0f;
        self.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _dicOfheight = [NSMutableDictionary dictionary];
        _array = [NSMutableArray array];
    }
    return self;
}

/**
 *  准备好布局时调用
 */
- (void)prepareLayout{
    [super prepareLayout];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //初始化好每列的高度
    for (NSInteger i = 0; i < self.lineNumber ; i++) {
        [_dicOfheight setObject:@(self.sectionInsets.top) forKey:[NSString stringWithFormat:@"%ld",i]];
    }
    //得到每个item的属性值进行存储
    for (NSInteger i = 0 ; i < count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [_array addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

/**
 *  设置可滚动区域范围
 */
- (CGSize)collectionViewContentSize{
    __block NSString *maxHeightline = @"0";
    [_dicOfheight enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
        if ([_dicOfheight[maxHeightline] floatValue] < [obj floatValue] ) {
            maxHeightline = key;
        }
    }];
    return CGSizeMake(self.collectionView.bounds.size.width, [_dicOfheight[maxHeightline] floatValue] + self.sectionInsets.bottom);
}

/**
 *  计算indexPath下item的属性的方法
 *
 *  @return item的属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //通过indexPath创建一个item属性attr
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //计算item宽
    CGFloat itemW = (self.collectionView.bounds.size.width - (self.sectionInsets.left + self.sectionInsets.right) - (self.lineNumber - 1) * self.lineSpacing) / self.lineNumber;
    CGFloat itemH = 0;
    //计算item高
    if (self.block != nil) {
        itemH = self.block(indexPath, itemW);
    }else{
        NSAssert(itemH != 0,@"Please implement computeIndexCellHeightWithWidthBlock Method");
    }
    //计算item的frame
    CGRect frame;
    frame.size = CGSizeMake(itemW, itemH);
    //循环遍历找出高度最短行
    __block NSString *lineMinHeight = @"0";
    [_dicOfheight enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
        if ([_dicOfheight[lineMinHeight] floatValue] > [obj floatValue]) {
            lineMinHeight = key;
        }
    }];
    int line = [lineMinHeight intValue];
    //找出最短行后，计算item位置
    frame.origin = CGPointMake(self.sectionInsets.left + line * (itemW + self.lineSpacing), [_dicOfheight[lineMinHeight] floatValue]);
    _dicOfheight[lineMinHeight] = @(frame.size.height + self.rowSpacing + [_dicOfheight[lineMinHeight] floatValue]);
    attr.frame = frame;
    
    return attr;
}
/**
 *  返回视图框内item的属性，可以直接返回所有item属性,指定区域的cell布局对象.定新的区域的时候调用
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _array;
}

//return YES;表示一旦滑动就实时调用上面这个layoutAttributesForElementsInRect:方法
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}


/**
 *  设置计算高度block方法
 *
 *  @param block 计算item高度的block
 */
- (void)computeIndexCellHeightWithWidthBlock:(CGFloat (^)(NSIndexPath *, CGFloat))block{
    if (self.block != block) {
        self.block = block;
    }
}


@end








