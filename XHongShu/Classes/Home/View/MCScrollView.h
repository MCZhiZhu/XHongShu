//
//  MCScrollView.h
//  XHongShu
//
//  Created by 周陆洲 on 16/6/12.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCScrollViewDelegate <NSObject>

-(void)scrollViewDidScroll:(UIScrollView *)scrollView viewHeight:(CGFloat)height;

@end

@interface MCScrollView : UIScrollView<UIScrollViewDelegate>

@property (retain,nonatomic) NSMutableArray * imageNameArray;
@property (retain,nonatomic) NSArray * imageItemArray;

@property (assign,nonatomic) CGFloat scrollLastH;

@property (weak,nonatomic) id<MCScrollViewDelegate> mcDelegate;

@end
