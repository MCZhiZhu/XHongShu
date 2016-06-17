//
//  AddFriendsCell.m
//  XHongShu
//
//  Created by 宋江 on 16/6/15.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "AddFriendsCell.h"

#import <UIImageView+WebCache.h>

@implementation AddFriendsCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AddFriendsCell" owner:self options:nil];
        self = [array lastObject];

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

- (IBAction)addAttention:(id)sender {
}

- (IBAction)hide:(id)sender {
}

- (IBAction)imageClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 0) {
        
    }else if (btn.tag == 1){
    
    }else if (btn.tag == 2){
    
    }
}
-(void)setAddFriendsModel:(AddFriendsModel *)addFriendsModel{
    _addFriendsModel = addFriendsModel;
    [_userPoto setImage:[self stringToImage:_addFriendsModel.images] forState:UIControlStateNormal];

    _userName.text = _addFriendsModel.nickname;
    [_image0 setImage:[self stringToImage:[self arrayToModel:_addFriendsModel.notesList[0]].images] forState:UIControlStateNormal];
    [_image1 setImage:[self stringToImage:[self arrayToModel:_addFriendsModel.notesList[1]].images] forState:UIControlStateNormal];
    [_image2 setImage:[self stringToImage:[self arrayToModel:_addFriendsModel.notesList[2]].images] forState:UIControlStateNormal];
    
    _describe.text = _addFriendsModel.recommendInfo;
    
}
#pragma mark 字符串 转 Image
- (UIImage *)stringToImage:(NSString *)str{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
    return image;
}
#pragma mark 字典 转 Model
- (NotesList *)arrayToModel:(NSDictionary *)dict{
    
     return [[NotesList alloc] initWithDictionary:dict error:nil];
}
@end
