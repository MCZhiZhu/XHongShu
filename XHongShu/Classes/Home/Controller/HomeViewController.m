//
//  HomeViewController.m
//  XHongShu
//
//  Created by 周陆洲 on 16/5/24.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "HomeViewController.h"
#import "NotesDetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initNavBar];
}
- (void)initNavBar
{
    self.navigationController.navigationBar.barTintColor = MainRedColor;
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NotesDetailViewController *detailVC = [[NotesDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
