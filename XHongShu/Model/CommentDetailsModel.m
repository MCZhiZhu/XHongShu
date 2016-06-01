//
//  CommentDetailsModel.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "CommentDetailsModel.h"
#import "NewestComments.h"


@implementation CommentDetailsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"newest_comments":@"newestComments",@"hot_comments":@"hotComments"}];
}
@end
