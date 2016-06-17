//
//  GoodCollectionCell.m
//  XHongShu
//
//  Created by 宋江 on 16/6/17.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "GoodCollectionCell.h"

@implementation GoodCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"GoodCollectionCell" owner:self options:nil];
        self = [array lastObject];
    }
    return self;
}
@end
