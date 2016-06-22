//
//  XHBranchPoint.m
//  XHTagView
//
//  Created by Jack_iMac on 16/2/22.
//  Copyright © 2016年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com. All rights reserved.
//

#import "XHBranchPoint.h"

@implementation XHBranchPoint

+ (instancetype)initlizerStartPoint:(CGPoint)startPoint
                           midPoint:(CGPoint)midPoint
                           endPoint:(CGPoint)endPoint
                          direction:(XHBranchLayerDirection)direction {
    XHBranchPoint *branchPoint = [[XHBranchPoint alloc] init];
    branchPoint.startPoint = startPoint;
    branchPoint.midPoint = midPoint;
    branchPoint.endPoint = endPoint;
    branchPoint.direction = direction;
    return branchPoint;
}

@end
