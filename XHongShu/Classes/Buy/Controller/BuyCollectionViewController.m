//
//  BuyCollectionViewController.m
//  XHongShu
//
//  Created by 宋江 on 16/6/16.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BuyCollectionViewController.h"
#import "GoodCollectionCell.h"
#import "CrossFieldCollectionView.h"
@interface BuyCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_buyCollectionView;
}
@end

@implementation BuyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame =CGRectMake(0, 94, VIEW_WEDTH, VIEW_HEIGHT - 94 -49);
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    _buyCollectionView  =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT) collectionViewLayout:flowLayout];
    _buyCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _buyCollectionView.delegate = self;
    _buyCollectionView.dataSource = self;
    [_buyCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [_buyCollectionView registerClass:[GoodCollectionCell class] forCellWithReuseIdentifier:@"GoodCell"];
    [self.view addSubview:_buyCollectionView];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else {
        return 10;
    }
}
//collectionViewcell之间的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 20;
    }else{
        return 10;
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [_buyCollectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, 200)];
            imageView.image = [UIImage imageNamed:@"user"];
            [cell addSubview:imageView];
            
            CrossFieldCollectionView *crossFieldView = [[CrossFieldCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), VIEW_WEDTH,160)];
            [cell addSubview:crossFieldView];
          
//        }
      return cell;
    }else{
        GoodCollectionCell *cell = [_buyCollectionView dequeueReusableCellWithReuseIdentifier:@"GoodCell" forIndexPath:indexPath];
        return cell;

    }

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(VIEW_WEDTH, 340);
        
    }else{
        return CGSizeMake((VIEW_WEDTH - 30)/2, 230);
    }
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(10, 10, 10,10);
    }else{
        return UIEdgeInsetsMake(20, 10, 10,10);
    }

}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
//        CollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
//        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT*0.6)];
//        
//        _headImageView.image =  _imageArray[0];
//        
//        [headerView addSubview:_headImageView];
//        
//        return headerView;
//    }else{
        return nil;
//    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"哈哈，可以");
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
