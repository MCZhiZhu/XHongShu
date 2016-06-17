//
//  ToolMothod.m
//  XHongShu
//
//  Created by 周陆洲 on 16/5/24.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "ToolMothod.h"

@implementation ToolMothod
//绘制线
+ (UIView *)createLineWithWidth:(CGFloat)width andHeight:(CGFloat)height andColor:(UIColor *)color{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    line.backgroundColor = color;
    
    return line;
}
@end
