//
//  EditPotoCollectionView.m
//  XHongShu
//
//  Created by 宋江 on 16/6/8.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "EditPotoCollectionView.h"
@interface EditPotoCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@end
@implementation EditPotoCollectionView
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {

        _dataArray = [NSArray array];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //水平滑动
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"editPotoCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
    }
    return self;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"editPotoCell" forIndexPath:indexPath];


    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,90 , 90)];

    imageView.image = [UIImage imageNamed:@"user.png"];
    [cell.contentView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 90, 30)];

    nameLabel.text = _dataArray[indexPath.row];
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:nameLabel];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90,90);
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(4, 4,60, 4);

}
//collectionViewcell之间的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 4;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",cell.contentView); 
    if (indexPath.row==0) {
   
    }else{
        
    }
    
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
}

@end
