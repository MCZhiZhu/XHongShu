//
//  GoodCollectionCell.h
//  XHongShu
//
//  Created by 宋江 on 16/6/17.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodDes;
@property (weak, nonatomic) IBOutlet UILabel *goodPrice;

@end
