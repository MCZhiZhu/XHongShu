//
//  CrossFieldCollectionCell.h
//  XHongShu
//
//  Created by 宋江 on 16/6/17.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrossFieldCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *price;
@end
